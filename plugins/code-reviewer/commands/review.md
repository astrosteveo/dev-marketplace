---
description: Review code for quality, best practices, and potential issues
---

# Review Command

When invoked, perform a comprehensive code review on the specified file or recent changes.

## Review Checklist

1. **Code Quality**: Readability, naming conventions, code organization
2. **Best Practices**: Language idioms, design patterns, SOLID principles
3. **Potential Bugs**: Edge cases, null checks, error handling
4. **Performance**: Obvious inefficiencies, unnecessary operations
5. **Security**: Input validation, injection risks, sensitive data handling

## Output Format

Provide feedback organized by severity:
- **Critical**: Must fix before merge
- **Warning**: Should address
- **Suggestion**: Nice to have improvements

Keep feedback actionable and specific with line references.
