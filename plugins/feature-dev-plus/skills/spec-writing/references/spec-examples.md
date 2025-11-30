# Spec Examples

Full example specifications for common feature types.

## Example 1: OAuth Authentication

### Feature: Google OAuth Authentication

#### Overview

Add Google OAuth 2.0 as a login method alongside existing email/password authentication, allowing users to sign in with their Google accounts without creating new passwords.

#### Problem Statement

Users currently must create and remember unique passwords for our application. This creates friction during signup, increases support burden for password resets, and presents security risks from weak or reused passwords. Many users prefer using existing trusted identity providers.

#### User Stories

- As an end user, I want to sign in with my Google account so that I don't have to create another password
- As an end user, I want my session to persist across browser restarts so that I don't have to log in repeatedly
- As an end user, I want clear error messages if OAuth fails so that I know what went wrong
- As a security administrator, I want OAuth tokens stored securely so that user accounts are protected
- As a developer, I want OAuth implementation to follow existing auth patterns so that maintenance is straightforward

#### Acceptance Criteria

- [ ] User sees "Sign in with Google" button on login page
- [ ] Clicking button redirects to Google OAuth consent page
- [ ] User can approve or deny permissions
- [ ] Approval redirects back to app with user logged in
- [ ] Denial redirects to login page with clear error message
- [ ] Access tokens refresh automatically before expiration
- [ ] Expired tokens that can't refresh prompt re-authentication
- [ ] Logout clears all OAuth tokens and sessions
- [ ] Sessions persist for 7 days or until explicit logout
- [ ] Invalid OAuth state parameters are rejected with error
- [ ] Network failures during OAuth show retry-able errors

#### Technical Approach

**Architecture Overview**: Implement OAuth 2.0 authorization code flow following existing authentication middleware pattern. Store tokens in Redis with TTL matching OAuth token expiration.

**Key Components**:

| Component | Purpose | Location |
|-----------|---------|----------|
| OAuthProvider | Abstract OAuth provider interface | src/auth/providers/oauth-provider.ts |
| GoogleOAuthProvider | Google-specific OAuth implementation | src/auth/providers/google-oauth.ts |
| TokenStore | Secure token persistence with Redis | src/auth/token-store.ts |
| OAuthMiddleware | Express middleware for OAuth routes | src/auth/middleware/oauth.ts |
| SessionManager | Session creation and validation | src/auth/session-manager.ts |

**Integration Points**:
- Express routes: Add `/auth/oauth/google` and `/auth/oauth/callback` endpoints
- Existing auth middleware: Chain with OAuth middleware for protected routes
- User model: Add `oauthProvider` and `oauthUserId` fields
- Config: Add OAuth client ID, secret, and redirect URL

**Data Model**:

User table additions:
```
oauthProvider: string | null  (e.g., "google")
oauthUserId: string | null    (provider's user ID)
```

Session store (Redis):
```
sessionId (key): {
  userId: string,
  accessToken: string,
  refreshToken: string,
  expiresAt: timestamp
}
TTL: 7 days
```

**Security Considerations**:
- Store client secret in environment variable, never commit to code
- Validate OAuth state parameter to prevent CSRF
- Use HTTPS for all OAuth redirects (enforce in production)
- Hash tokens before storing in Redis (or use encrypted Redis)
- Validate OAuth tokens on every protected route access
- Implement rate limiting on OAuth endpoints

#### Test Strategy

**Testable**:
- Token exchange logic (mock Google API responses)
- Token refresh flow (mock expired tokens)
- Session creation and validation
- State parameter generation and validation
- Error handling (invalid codes, network failures)
- Token storage and retrieval from Redis

**Non-testable**:
- Google OAuth consent page UI
- Redirect user experience timing
- Button styling on login page

**Test Types**:
- Unit tests: OAuthProvider methods, token validation, state generation
- Integration tests: Full OAuth flow with mocked Google API
- E2E tests: Login flow through real browser (optional, in staging)

#### Implementation Considerations

**Dependencies**:
- `googleapis` npm package for Google OAuth client
- Redis for token storage (already in use)
- Environment variables: `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`, `OAUTH_REDIRECT_URL`

**Migration**: No data migration needed. Existing email/password users continue working. OAuth users are new records or linked by email matching.

**Performance**: Token refresh adds ~100ms to request latency. Implement background refresh 5 minutes before expiration to minimize user-facing latency.

**Monitoring**:
- Log OAuth flow failures (code exchange, token refresh)
- Track OAuth login success rate
- Alert on high OAuth error rates (> 5%)

#### Out of Scope

- Facebook, GitHub, or other OAuth providers (future)
- Linking existing email/password accounts to OAuth (future)
- Multi-factor authentication (separate feature)
- OAuth scopes beyond basic profile info (future enhancement)

#### Success Metrics

- OAuth login adoption: Target 30% of new users within 1 month
- Password reset requests: Decrease by 20%
- Login completion rate: Increase by 10%
- OAuth login errors: < 2% failure rate

---

## Example 2: Admin Dashboard

### Feature: Administrative Dashboard

#### Overview

Create a web-based administrative dashboard for support staff to view user accounts, troubleshoot issues, and perform basic account operations without direct database access.

#### Problem Statement

Support staff currently troubleshoot user issues by requesting database queries from engineering, causing delays (hours to days) and distracting engineers from development work. There's no self-service way to view user account details, session information, or recent activity.

#### User Stories

- As a support agent, I want to search for users by email or ID so that I can quickly find accounts
- As a support agent, I want to view user account details so that I can verify information reported in tickets
- As a support agent, I want to see recent user activity so that I can troubleshoot issues
- As a support manager, I want audit logs of admin actions so that I can ensure proper use
- As an engineer, I want support to self-serve basic queries so that I can focus on development

#### Acceptance Criteria

- [ ] Dashboard requires admin authentication (separate from user auth)
- [ ] Search finds users by email (exact match) or user ID
- [ ] User detail page shows: ID, email, created date, last login, account status
- [ ] User detail page shows last 50 activities (logins, API calls, errors)
- [ ] Admin can view but not edit user data
- [ ] All admin searches and views are logged with timestamp and admin ID
- [ ] Dashboard is responsive and works on tablet devices
- [ ] Non-admin users cannot access dashboard (403 error)
- [ ] Search returns results in < 1 second for database of 100K users

#### Technical Approach

**Architecture Overview**: Separate admin React SPA served from `/admin` route with backend API endpoints requiring admin role authentication. Read-only database access through service layer.

**Key Components**:

| Component | Purpose | Location |
|-----------|---------|----------|
| AdminDashboard (React) | Main dashboard UI | frontend/src/admin/AdminDashboard.tsx |
| UserSearch (React) | Search interface | frontend/src/admin/UserSearch.tsx |
| UserDetail (React) | User detail view | frontend/src/admin/UserDetail.tsx |
| AdminAPI | Express endpoints | backend/src/api/admin.ts |
| AdminAuthMiddleware | Admin role verification | backend/src/middleware/admin-auth.ts |
| UserService | Read-only user queries | backend/src/services/user-service.ts |
| AuditLogger | Admin action logging | backend/src/services/audit-logger.ts |

**Integration Points**:
- Authentication: Extend existing JWT auth to support admin role claim
- User database: Read-only queries through existing User model
- Audit log: New table in existing database
- Frontend build: Add admin SPA to build pipeline

**Data Model**:

Admin audit log (new table):
```
id: UUID (primary key)
adminId: string (user ID of admin)
action: string (e.g., "user_search", "user_view")
targetUserId: string | null
metadata: JSON (search query, filters, etc.)
timestamp: timestamp
```

User table additions:
```
role: enum('user', 'admin')  [default: 'user']
```

**Security Considerations**:
- Require admin role for all /api/admin/* endpoints
- Implement rate limiting on search (max 60 requests/minute per admin)
- Log all admin actions for audit trail
- No write operations in initial version (read-only)
- Sanitize all search inputs to prevent injection
- Mask sensitive fields (e.g., show partial OAuth tokens only)

#### Test Strategy

**Testable**:
- Admin authentication middleware (role verification)
- Search query logic (exact email match, user ID lookup)
- Activity log retrieval and pagination
- Audit log recording
- Rate limiting enforcement
- Authorization failures (non-admin access attempts)

**Non-testable**:
- Dashboard layout and styling
- Responsive design breakpoints
- Loading spinner animations
- Color scheme and typography

**Test Types**:
- Unit tests: Service layer methods, auth middleware
- Integration tests: API endpoints with database
- E2E tests: Search and detail view workflows

#### Implementation Considerations

**Dependencies**:
- React 18+ (already in use)
- React Router for admin SPA routing
- Existing UI component library

**Migration**:
- Add `role` column to users table (default 'user')
- Manually promote initial admin users via database update
- Create audit_log table

**Performance**:
- Add database index on users.email for fast search
- Limit activity log to last 50 items (paginated)
- Cache user detail for 30 seconds (minimize database load)

**Monitoring**:
- Track admin dashboard usage (logins, searches per day)
- Alert on admin access during off-hours (potential security issue)
- Monitor search performance (p95 latency)

#### Out of Scope

- Editing user accounts (future feature, requires approval workflow)
- Bulk operations (future)
- Advanced filtering (date ranges, account status) (future)
- Exporting search results (future)
- User impersonation (separate security review needed)

#### Success Metrics

- Engineering time spent on support queries: Reduce by 50%
- Average support ticket resolution time: Decrease by 30%
- Admin dashboard usage: 80% of support staff use weekly
- Self-service query rate: 90% of user lookups done via dashboard
