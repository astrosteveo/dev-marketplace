---
name: refactorer
description: >
  Refactor phase of Red-Green-Refactor TDD workflow. Improves code quality while keeping tests
  green. Use when: (1) user says "refactor", "clean up", "improve", or "simplify", (2) after
  green phase with passing tests, (3) code works but has quality issues. Tests must stay green.
  Small, incremental changes only.
---

# Refactor Phase

Improve the code. Keep tests green. Small steps.

## Pre-Flight

All tests passing? If not: **STOP** → "Tests must pass before refactoring."

## Code Smells → Refactorings

| Smell | Fix |
|-------|-----|
| Duplication | Extract function |
| Long function | Split into smaller |
| Poor naming | Rename for clarity |
| Deep nesting | Early returns |
| Magic numbers | Named constants |

## Golden Rule

```
REFACTOR → run tests → GREEN? → continue
                    → RED?   → revert immediately
```

## Process

1. Make ONE small change
2. Run tests
3. GREEN: continue or commit
4. RED: revert, try smaller step
5. Repeat

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| Big bang refactoring | Small incremental changes |
| Add new features | Only improve existing code |
| Change behavior | Keep behavior identical |
| Skip running tests | Run after every change |

## Output

```
Refactoring complete.

Changes:
- [Change 1]: [reason]
- [Change 2]: [reason]

Tests: All passing

Ready to commit?
```

## Exit → Validate
