# Refactor Phase Skill

Improve code quality while keeping tests green.

## When to Activate

- User says "refactor...", "clean up...", "refactor phase"
- Tests are passing and code can be improved
- After green phase completion

## Behavior

1. **Identify improvements** - What can be cleaner, more readable, more efficient?
2. **Make small changes** - One refactoring at a time
3. **Run tests after each change** - Ensure nothing breaks
4. **Stop when clean** - Don't over-engineer

## Refactoring Targets

- Remove duplication (DRY)
- Improve naming
- Extract methods/functions
- Simplify conditionals
- Reduce nesting
- Apply appropriate patterns

## What NOT to Do

- Add new functionality (that needs new tests first)
- Change behavior (tests should still pass)
- Premature optimization
- Gold plating

## Output Format

```
Refactoring: [area being improved]

Changes made:
- [refactoring 1]: [why it improves the code]
- [refactoring 2]: [why it improves the code]

Running tests after each change...
[All tests still passing]

Code is clean. Ready for the next feature (start with tests).
```
