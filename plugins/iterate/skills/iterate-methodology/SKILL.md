---
name: Iterate Methodology
description: This skill should be used when the user asks about "iterative development workflow", "Explore Plan Code Verify Commit", "Red Green Refactor", "TDD workflow", "ROADMAP.md format", "how iterate works", "iteration phases", "Foundation phase", "tech stack selection", or needs guidance on the iterate plugin's methodology, phase transitions, or ROADMAP.md structure.
version: 1.1.0
---

# Iterate Methodology

## Overview

The iterate methodology is a disciplined, TDD-enforced development workflow that ensures quality through systematic phases:

```
[Foundation] → Explore → Plan → [Red → Green → Refactor] → Verify → Commit
      ↑
      New projects only
```

This approach enforces test-driven development (TDD) through the Red-Green-Refactor cycle while maintaining ROADMAP.md and FOUNDATION.md as sources of truth.

## Core Philosophy

### Foundation First (New Projects)

For brand new projects, establish foundational decisions before coding:
- Tech stack selection with rationale
- Target platforms and clients
- Database and infrastructure choices
- Testing framework decisions

### Feature-by-Feature Iteration

Development happens one feature at a time:
1. Complete the full cycle for current feature
2. Learn from implementation
3. Apply learnings to next feature

### Test-Driven Development (TDD)

The [Red → Green → Refactor] cycle is mandatory unless tests are genuinely impossible:
- **Red**: Write failing tests FIRST
- **Green**: Write MINIMAL code to pass
- **Refactor**: Clean up while green (optional if tests pass)

### Living Documentation

ROADMAP.md evolves as work progresses:
- Hooks automatically update status
- Current phase always visible
- Test results tracked per task

## Workflow Phases

### Phase 0: Foundation (New Projects Only)

**Purpose**: Establish tech stack and architectural decisions before any coding.

**When Required**:
- Starting a brand new project
- Major architectural pivot
- NOT for regular feature iterations

**Activities**:
- Define target platforms (web, mobile, CLI, etc.)
- Select frontend framework (if applicable)
- Choose backend language and framework
- Select database and infrastructure
- Establish testing strategy

**Output**: FOUNDATION.md with all decisions and rationale

**Transition to Explore**: When tech stack documented in FOUNDATION.md

### Phase 1: Explore

**Purpose**: Understand the codebase and constraints before planning.

**Activities**:
- Map codebase architecture
- Identify existing patterns
- Discover dependencies
- Assess test infrastructure

**Transition to Plan**: When codebase understanding is sufficient.

### Phase 2: Plan

**Purpose**: Design architecture and test strategy before coding.

**Activities**:
- Design component structure
- Define unit test strategy
- Define integration test strategy
- Break work into tasks

**Transition to Red**: When architecture and test strategy are defined.

### Phase 3: Red (TDD)

**Purpose**: Write failing tests that define expected behavior.

**Activities**:
- Write unit tests that FAIL
- Write integration tests that FAIL
- Verify tests fail for expected reasons

**Critical Rule**: Tests MUST fail. If they pass, they test nothing useful.

**Transition to Green**: When ALL tests exist and FAIL.

### Phase 4: Green (TDD)

**Purpose**: Write minimal code to make tests pass.

**Activities**:
- Implement one test at a time
- Write SIMPLEST code that passes
- Run tests after each change

**Critical Rule**: Don't optimize, don't add features, don't refactor yet.

**Transition to Refactor/Verify**: When ALL tests PASS.

### Phase 5: Refactor (Optional)

**Purpose**: Clean up code while keeping tests green.

**When to Skip**: May skip IF both unit AND integration tests pass.

**Activities**:
- Improve code quality
- Remove duplication
- Improve naming
- Run tests after each change

**Transition to Verify**: When code is clean AND tests still pass.

### Phase 6: Verify

**Purpose**: Final quality check before commit.

**Activities**:
- Run ALL tests
- Check code quality
- Verify test coverage
- Update ROADMAP.md

**Transition to Commit**: When verification confirms quality.

### Phase 7: Commit

**Purpose**: Create meaningful commit with proper documentation.

**Activities**:
- Stage relevant files
- Create commit with ROADMAP reference
- Move feature to Completed section
- Prepare for next iteration

## ROADMAP.md Format

The living document format for tracking progress:

```markdown
# ROADMAP

## Current Feature: [Feature Name]

### Phase: [Emoji] [Phase Name]

- [ ] **Explore**: [Summary]
- [ ] **Plan**: [Summary]
- [ ] **Red**: Write failing tests
  - [ ] Unit: `[test file path]`
  - [ ] Integration: `[test file path]`
- [ ] **Green**: Implement to pass
- [ ] **Verify**: Tests pass, reviewed
- [ ] **Commit**: Merged

**Test Status**: Unit [status] | Integration [status]

**Notes**:
- [Important notes, blockers, decisions]

---

## Backlog
- [ ] [Future feature 1]
- [ ] [Future feature 2]

## Completed
- [x] [Feature] (Unit [status] | Integration [status])
```

### Phase Indicators

| Phase | Indicator |
|-------|-----------|
| Foundation | `### Phase: Foundation (Tech Stack)` |
| Explore | `### Phase: Exploring` |
| Plan | `### Phase: Planning` |
| Red | `### Phase: Red (Writing Tests)` |
| Green | `### Phase: Green (Implementing)` |
| Refactor | `### Phase: Refactoring` |
| Verify | `### Phase: Verifying` |
| Commit | `### Phase: Committing` |

### Test Status Values

| Status | Meaning |
|--------|---------|
| `Pending` | Not yet run |
| `Pass` | All tests passing |
| `Fail` | Tests failing (expected in Red) |
| `N/A` | Not applicable (with justification) |

## TDD Enforcement

### Strictness Levels

Configure in `.claude/iterate.local.md`:

```yaml
---
strictness: strict
---
```

| Level | Behavior |
|-------|----------|
| `strict` | Block implementation without tests |
| `warn` | Allow but log violations |
| `off` | No enforcement |

### When Tests Are N/A

Some tasks genuinely cannot have tests:
- Configuration changes (no logic)
- Documentation updates
- Pure UI styling
- Build/deployment scripts

For N/A tasks:
1. Mark tests as `N/A`
2. Provide justification in Notes
3. Set strictness to `off` temporarily

## Feature-Dev Integration

After planning is complete:
1. ROADMAP.md has architecture documented
2. Test strategy is defined
3. Offer to launch `/feature-dev:feature-dev`
4. Feature-dev provides specialized implementation agents
5. Iterate hooks continue tracking ROADMAP.md

## Additional Resources

### Reference Files

For detailed guidance:
- **`references/tdd-patterns.md`** - TDD best practices and patterns
- **`references/roadmap-examples.md`** - Complete ROADMAP.md examples

### Configuration

Settings file: `.claude/iterate.local.md`
```yaml
---
strictness: strict
require_integration_tests: true
require_unit_tests: true
---
```
