# iterate

One command to master them all. TDD-enforced iterative development workflow.

## Workflow

```
[Foundation] → Explore → Plan → [Red → Green → Refactor] → Verify → Commit
      ↑
      New projects only
```

### Phases

0. **Foundation** - Tech stack selection and architectural decisions (new projects only)
1. **Explore** - Understand the problem space, codebase, and constraints
2. **Plan** - Design the solution architecture and break down into tasks
3. **Red** - Write failing tests first (unit + integration)
4. **Green** - Minimal implementation to make tests pass
5. **Refactor** - Clean up while keeping tests green (optional if tests pass)
6. **Verify** - Ensure all tests pass, code reviewed
7. **Commit** - Commit with proper context and roadmap reference

## Usage

```bash
# Start new project (Foundation phase)
/iterate new project task management app

# Start new feature on existing project
/iterate add user authentication

# Continue current work
/iterate continue
# or just
/iterate
```

## FOUNDATION.md (New Projects)

For new projects, the foundation agent creates `FOUNDATION.md` documenting:

```markdown
# Project Foundation

## Overview
[Project description and goals]

## Target Platforms
- Primary: Web (React SPA)
- Secondary: Mobile (React Native)

## Tech Stack

### Frontend
- Framework: React 18
- Rationale: Large ecosystem, team expertise

### Backend
- Language: Rust
- Framework: Axum
- Rationale: Performance-critical, type safety

### Database
- Primary: PostgreSQL
- Rationale: Complex queries, data integrity

## Testing Strategy
- Unit: cargo test
- Integration: cargo test --test integration
- E2E: Playwright
```

## ROADMAP.md

The plugin maintains a `ROADMAP.md` file that tracks your current feature:

```markdown
# ROADMAP

## Project Foundation
See FOUNDATION.md for tech stack and architectural decisions.

## Current Feature: User Authentication

### Phase: Green (Implementation)

- [x] **Foundation**: Tech stack selected
- [x] **Explore**: Understand auth requirements
- [x] **Plan**: JWT-based auth with refresh tokens
- [ ] **Red**: Write failing tests
  - [x] Unit: `tests/unit/auth_test.rs`
  - [ ] Integration: `tests/integration/auth_flow_test.rs`
- [ ] **Green**: Implement to pass tests
- [ ] **Verify**: All tests pass, code reviewed
- [ ] **Commit**: Merge to main

**Test Status**: Unit ✅ | Integration ⏳

---

## Backlog
- [ ] Rate limiting middleware
- [ ] User profile management

## Completed
- [x] Project scaffolding (N/A - no tests)
```

## Configuration

Create `.claude/iterate.local.md` in your project:

```yaml
---
strictness: strict  # strict | warn | off
require_integration_tests: true
require_unit_tests: true
---

Project-specific notes and overrides...
```

### Strictness Levels

- **strict**: Block implementation without tests (enforces TDD)
- **warn**: Allow but log violations to ROADMAP.md
- **off**: No enforcement (for non-testable tasks)

## Agents

| Agent | Purpose |
|-------|---------|
| foundation | Tech stack selection (new projects) |
| explorer | Deep codebase exploration and constraint discovery |
| planner | Architecture design and test strategy planning |
| red-phase | Write comprehensive failing tests |
| green-phase | Minimal implementation to pass tests |
| verifier | Verify tests pass and code quality |
| committer | Context-aware commits with roadmap updates |

## Integration

After planning is complete, the plugin offers to launch `/feature-dev:feature-dev` with prepared context for seamless transition to implementation.
