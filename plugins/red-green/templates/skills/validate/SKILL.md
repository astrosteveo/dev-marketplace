---
name: curator
description: >
  Validation phase of Red-Green-Refactor TDD workflow. Final verification, cleanup, and commit.
  Use when: (1) user says "validate", "verify", "commit", "done", or "finish", (2) after
  implementation and optional refactoring complete, (3) ready to finalize a story. Updates
  ROADMAP.md and creates clean commits.
---

# Validate Phase

Verify. Clean up. Commit. Move on.

## Pre-Flight

1. All tests passing?
2. On correct branch?

## Checklist

- [ ] All tests pass
- [ ] No debug code left behind
- [ ] No commented-out code
- [ ] No console.log/print statements
- [ ] Follows codebase conventions
- [ ] Acceptance criteria met

## Process

1. Run full test suite
2. Review changes (`git diff`)
3. Update ROADMAP.md (mark story complete)
4. Commit with clear message

## ROADMAP.md Update

```markdown
## Active
[Clear]

## Current Epic: [Name]
### Stories
- [x] Completed story ✓
- [ ] Next story
```

## Commit Format

```
[type]: [description]

[what and why]

Story: [story name]
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`

## Output

```
Story completed: [story name]

Commit: [hash]
Files changed: [count]
Tests: All passing

Next story?
```

## Exit → Next Story or New Epic
