# Red Phase Skill

Write failing tests before implementation.

## When to Activate

- User says "write tests for...", "test...", "red phase"
- User describes a feature without existing tests
- Starting any new functionality

## Behavior

1. **Understand the requirement** - What behavior needs to be tested?
2. **Write test cases** - Cover happy path, edge cases, error conditions
3. **Verify tests fail** - Run tests to confirm they fail for the right reason
4. **Stop** - Do not write implementation code

## Test Quality Guidelines

- One assertion per test when possible
- Descriptive test names that explain the expected behavior
- Arrange-Act-Assert pattern
- Test behavior, not implementation details

## Output Format

```
Writing tests for: [feature description]

Tests created:
- [test name]: [what it verifies]
- [test name]: [what it verifies]

Running tests...
[X failed, as expected]

Ready for green phase. Say "implement" or "make it pass" to continue.
```
