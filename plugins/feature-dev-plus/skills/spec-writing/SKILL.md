---
name: Spec Writing
description: This skill should be used when Claude needs to write a feature specification, create acceptance criteria, document requirements, define user stories, or structure feature documentation. Trigger phrases include "write a spec", "create specification", "document requirements", "define acceptance criteria", "write user stories".
version: 1.0.0
---

# Spec Writing Skill

Write clear, comprehensive, actionable feature specifications that serve as implementation blueprints.

## Core Principles

1. **Specific over Vague**: Use concrete examples, not abstract descriptions
2. **Testable Criteria**: Every acceptance criterion should be verifiable
3. **User-Focused**: Start with problems and outcomes, not technical solutions
4. **Scoped**: Clearly define what's in and out of scope
5. **Referenced**: Point to examples and patterns, don't duplicate

## Spec Structure

Use this template for all feature specifications:

### 1. Overview (2-3 sentences)
- What the feature does
- Why it matters
- Who benefits

### 2. Problem Statement (3-5 sentences)
- What problem exists today
- Impact of the problem
- Why solving it is important

### 3. User Stories (3-5 stories)

Format: `As a {user type}, I want {goal} so that {benefit}`

**Examples:**
- As a developer, I want to resume features after /clear so that I don't lose progress
- As a product manager, I want clear specs so that implementation matches requirements
- As a user, I want OAuth login so that I don't create another password

**Guidelines:**
- Focus on user goals, not technical implementation
- Each story captures one user workflow
- Include benefit (the "so that" part)
- Cover main use cases, not every edge case

### 4. Acceptance Criteria (5-10 criteria)

Format: Checklist items that are specific and testable

**Good criteria:**
- [ ] User can click "Sign in with Google" and be redirected to Google OAuth
- [ ] Invalid tokens return 401 error with clear message
- [ ] Session persists across browser restarts for 7 days
- [ ] Logout clears all tokens and redirects to home page

**Poor criteria:**
- [ ] Authentication works well
- [ ] System is secure
- [ ] User experience is good

**Include:**
- Happy path scenarios
- Edge cases (empty, null, boundaries)
- Error handling expectations
- Integration requirements
- Performance expectations (if relevant)

### 5. Technical Approach

**Architecture Overview**: How feature fits into existing system (2-3 sentences)

**Key Components** (table format):

| Component | Purpose | Location |
|-----------|---------|----------|
| OAuthProvider | Handles OAuth flow | src/auth/oauth-provider.ts |
| TokenStore | Manages token persistence | src/auth/token-store.ts |

**Integration Points**:
- System/module it integrates with
- How integration works
- Dependencies or prerequisites

**Data Model** (if applicable):
- Data structures needed
- Database tables/fields
- State management approach

**Security Considerations**:
- Authentication/authorization needs
- Validation requirements
- Potential vulnerabilities to address

### 6. Test Strategy

Separate testable from non-testable elements:

**Testable:**
- Business logic (calculations, validations, data transforms)
- API integrations (request/response handling)
- State management operations
- Error handling and edge cases
- Authentication/authorization logic

**Non-testable (skip automated tests):**
- Visual styling and layout
- Subjective UX
- Animation timing
- Game rendering
- Manual workflows

**Test types needed**:
- Unit tests: {For what components}
- Integration tests: {For what workflows}
- E2E tests: {If needed, for what scenarios}

### 7. Implementation Considerations

**Dependencies**: Libraries, services, or configurations needed

**Migration/Upgrade**: If changing existing functionality, how to migrate

**Performance**: Any performance implications or optimizations needed

**Monitoring**: What to log or monitor after deployment

### 8. Out of Scope

Explicitly list what this feature does NOT include:

- Related features that might seem included but aren't
- Future enhancements to consider later
- Clarifications of boundaries

**Example:**
- Out of scope: Facebook OAuth (only Google in this version)
- Out of scope: Multi-factor authentication (future enhancement)
- Out of scope: Account linking (existing accounts only)

### 9. Success Metrics

How to measure if feature succeeded after deployment:

- Usage metrics
- Performance metrics
- User satisfaction indicators
- Business impact measures

## Writing Guidelines

### Be Specific

**Vague**: "Improve authentication system"
**Specific**: "Add Google OAuth 2.0 login as alternative to email/password authentication"

**Vague**: "Handle errors properly"
**Specific**: "Invalid tokens return 401 with error message, expired tokens trigger refresh flow"

### Use Examples

**Without example**: "Support various input formats"
**With example**: "Support formats: ISO 8601 dates, Unix timestamps, MM/DD/YYYY strings"

**Without example**: "Validate user input"
**With example**: "Validate: email format (RFC 5322), password length (8-64 chars), no SQL injection"

### Reference Existing Patterns

Instead of describing implementation in detail, reference existing code:

**Good**: "Follow authentication pattern in src/auth/password-auth.ts:45-89"
**Poor**: "Create a class with constructor that takes config, implement authenticate method that..."

### Keep It Scannable

- Use tables for structured data
- Use bullet lists for items
- Use headers for organization
- Use bold for emphasis
- Keep paragraphs short (3-5 sentences max)

## Common Patterns

### API Endpoint Spec

```markdown
### Endpoint: POST /api/auth/oauth/callback

**Purpose**: Handle OAuth provider callback with authorization code

**Request**:
- Query params: `code` (string, required), `state` (string, required)
- Headers: None required

**Response** (200 OK):
```json
{
  "accessToken": "string",
  "refreshToken": "string",
  "expiresIn": 3600
}
```

**Errors**:
- 400: Invalid or missing code/state
- 401: Code already used or expired
- 500: Provider communication failure
```

### Data Model Spec

```markdown
### User Session Model

**Fields**:
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| sessionId | string (UUID) | Yes | Unique identifier |
| userId | string | Yes | User identifier |
| accessToken | string | Yes | OAuth access token |
| refreshToken | string | Yes | OAuth refresh token |
| expiresAt | timestamp | Yes | Token expiration time |
| createdAt | timestamp | Yes | Session creation time |

**Indexes**: sessionId (primary), userId (indexed for lookup)

**TTL**: 7 days from createdAt, auto-delete
```

### Workflow Spec

```markdown
### OAuth Login Flow

1. User clicks "Sign in with Google"
2. System redirects to Google OAuth consent page
3. User approves permissions
4. Google redirects to callback URL with code
5. System exchanges code for tokens
6. System creates session with tokens
7. System redirects user to dashboard
8. User is authenticated

**Error scenarios**:
- Step 3: User denies → Redirect to login with error message
- Step 5: Invalid code → Show error, allow retry
- Step 5: Network failure → Show error, allow retry
```

## Anti-Patterns to Avoid

### ❌ Over-Specification

Don't dictate exact implementation details that constrain developers:

**Bad**: "Create a class called `GoogleOAuthProvider` that extends `AbstractOAuthProvider` with methods `getAuthUrl(redirectUri: string): string`, `exchangeCode(code: string): Promise<Tokens>`"

**Good**: "Implement Google OAuth provider following the pattern in src/auth/oauth-provider.ts"

### ❌ Vague Requirements

Don't use subjective terms without concrete criteria:

**Bad**: "System should be fast and user-friendly"

**Good**: "Login completes in < 2 seconds, error messages clearly explain what went wrong"

### ❌ Missing Edge Cases

Don't only spec the happy path:

**Missing**: "User logs in successfully"

**Complete**: "User logs in successfully, expired tokens auto-refresh, invalid tokens show clear error, network failures allow retry"

### ❌ Coupling Spec to Implementation

Don't make implementation decisions that should be architectural:

**Bad**: "Use Redis for token storage with 7-day TTL"

**Good**: "Store tokens with 7-day expiration (implementation choice: Redis, DynamoDB, or in-memory store based on scale needs)"

## For More Details

See reference files:
- `references/spec-examples.md` - Full example specs for common features
- `references/acceptance-criteria-patterns.md` - Comprehensive AC patterns
- `references/user-story-templates.md` - User story formulas for different domains

See example files:
- `examples/oauth-spec.md` - Complete OAuth feature spec
- `examples/api-endpoint-spec.md` - REST API endpoint spec
- `examples/ui-component-spec.md` - UI component with testable/non-testable split
