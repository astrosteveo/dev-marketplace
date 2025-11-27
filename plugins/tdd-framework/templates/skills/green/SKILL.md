# Green Phase Skill

Write minimal code to make tests pass.

## When to Activate

- User says "implement...", "make it pass", "green phase"
- Tests exist and are failing
- After red phase completion

## Behavior

1. **Review failing tests** - Understand what needs to pass
2. **Write minimal code** - Just enough to make tests green
3. **Run tests** - Verify all tests pass
4. **Stop** - Do not add extra features or optimize

## Minimal Code Guidelines

- No premature optimization
- No "while we're here" additions
- No speculative generality
- If it's not tested, don't build it

## Output Format

```
Making tests pass for: [feature description]

Implementation:
- [brief description of code added]

Running tests...
[All tests passed]

Ready for refactor phase. Say "refactor" or "clean up" to improve the code.
Or continue with new tests for the next feature.
```
