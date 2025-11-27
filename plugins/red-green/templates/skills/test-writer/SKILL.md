---
name: test-writer
description: >
  Red phase of Red-Green-Refactor TDD workflow. Writes failing tests before any implementation.
  Use when: (1) user says "test", "red", "write test", or "test first", (2) starting implementation
  of an ACTIVE story, (3) need to define expected behavior. This phase MUST produce a failing test.
  No implementation code in this phase.
---

# Red Phase

Write the test. Watch it fail. Then implement.

## Pre-Flight

1. Check ROADMAP.md for ACTIVE story
2. No active story? **STOP** → "No active story. Which story should we start?"

## Test Structure

```
test("[behavior]", () => {
  // Arrange: Set up preconditions
  // Act: Perform the action
  // Assert: Verify the outcome
})
```

## Checklist

- [ ] Tests ONE behavior
- [ ] Descriptive name (what/why)
- [ ] Arrange-Act-Assert structure
- [ ] Independent (no test interdependence)

## Process

1. Write test for ACTIVE story
2. Run test - **MUST FAIL**
3. If passes: story done or test wrong
4. If syntax error: fix test, not a valid failure

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| Write implementation first | Test first, always |
| Multiple behaviors per test | One test, one behavior |
| Test implementation details | Test observable behavior |
| Skip the failing run | Verify it fails correctly |

## Output

```
Test written: [test file:line]

Testing: [story name]
Status: RED (failing as expected)
Error: [failure message]

Ready to implement?
```

## Exit → Green (implementer)
