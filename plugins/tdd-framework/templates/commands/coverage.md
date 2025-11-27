---
description: Run tests with coverage reporting
---

# Test Coverage

Run tests with coverage analysis to identify untested code.

## Instructions

1. Detect the coverage tool:
   - Node.js: `npm test -- --coverage` or `nyc`
   - Python: `pytest --cov` or `coverage run`
   - Go: `go test -cover ./...`
   - Rust: `cargo tarpaulin` or `cargo llvm-cov`

2. Run tests with coverage

3. Report:
   - Overall coverage percentage
   - Files/functions with low coverage
   - Uncovered lines if available

## Output Format

```
Running tests with coverage...

Overall Coverage: XX%

Low coverage areas:
- [file]: XX% - [uncovered functionality]
- [file]: XX% - [uncovered functionality]

Recommendations:
- [Specific tests that could improve coverage]
```
