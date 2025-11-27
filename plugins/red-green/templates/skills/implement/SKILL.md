---
name: implementer
description: >
  Green phase of Red-Green-Refactor TDD workflow. Writes minimal implementation code to make
  failing tests pass. Use when: (1) user says "implement", "green", "make it pass", "code",
  or "build", (2) after a failing test exists for the ACTIVE story. This phase writes ONLY
  enough code to pass the test. No extras. No refactoring yet.
---

# Green Phase

Write the minimum code to make the test pass. Nothing more.

## Pre-Flight

1. Verify test is failing (RED)
2. Test passes? **STOP** → "Test already passes. Story may be complete."
3. No test? **STOP** → "No failing test. Write test first."

## Three Laws of TDD

1. Write no production code except to make a failing test pass
2. Write no more of a test than is sufficient to fail
3. Write no more production code than is sufficient to pass

## Process

1. Understand the failure (what's expected vs actual)
2. Make it compile/run
3. Make it return something
4. Make it return the right thing
5. Run test - **MUST PASS**
6. Verify no other tests broken

## Acceptable (For Now)

- Duplication (will refactor)
- Hardcoded values (will generalize)
- Simple/naive solutions (will optimize)

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| Add error handling "just in case" | Only what test requires |
| Refactor while implementing | Implement first, refactor later |
| Handle untested edge cases | One test, one behavior |
| "While I'm here..." additions | Minimal code only |

## Output

```
Implementation complete: [file:line]

Story: [story name]
Status: GREEN (test passing)

Ready to validate/refactor?
```

## Exit → Refactor or Validate
