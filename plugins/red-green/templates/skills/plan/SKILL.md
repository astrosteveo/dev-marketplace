---
name: architect
description: >
  Planning phase of Red-Green-Refactor TDD workflow. Breaks features into small, testable stories
  and manages the ROADMAP.md backlog. Use when: (1) user says "plan", "break down", "stories",
  "roadmap", "architect", or "design", (2) after research phase completes, (3) starting a new
  epic or feature. This phase produces stories in ROADMAP.md, NOT code.
---

# Plan Phase

Break it down before building. Stories, not code.

## INVEST Stories

| Criteria | Meaning |
|----------|---------|
| **I**ndependent | No dependencies on other stories |
| **N**egotiable | Acceptance criteria, not implementation details |
| **V**aluable | Delivers user value |
| **E**stimable | Small enough to understand |
| **S**mall | Completable in one session |
| **T**estable | Clear pass/fail criteria |

## Story Size

```
Too Big:    "Implement user authentication"
Right Size: "Return 401 for missing auth header"
            "Return 401 for expired token"
            "Return 200 with user data for valid token"
```

Each story = one test = one behavior.

## Process

1. Define epic (goal, scope, dependencies)
2. List behaviors as Given/When/Then
3. Convert to stories with test criteria
4. Order: foundation → happy path → edge cases → polish
5. Update ROADMAP.md
6. **NO CODE** - planning only

## ROADMAP.md Format

```markdown
## Active
[Story being worked on]

## Current Epic: [Name]
**Goal**: [outcome]

### Stories
- [ ] Story 1 - [test criteria]
- [ ] Story 2 - [test criteria]

## Backlog
[Future epics]
```

## Output

```
Added [N] stories to roadmap:
1. [Story 1] - [brief description]
2. [Story 2] - [brief description]

Which story should we mark ACTIVE?
```

## Exit → Red (test-writer)
