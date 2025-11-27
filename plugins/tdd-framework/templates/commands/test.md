---
description: Run the project test suite
---

# Run Tests

Execute the project's test suite and report results.

## Instructions

1. Detect the test framework:
   - Node.js: `npm test` or `yarn test`
   - Python: `pytest` or `python -m unittest`
   - Go: `go test ./...`
   - Rust: `cargo test`
   - Other: Check for test scripts in config files

2. Run the tests

3. Report results clearly:
   - Number of tests passed/failed
   - Failed test names and reasons
   - Suggest next steps based on results

## Output Format

```
Running tests...

Results: X passed, Y failed

[If failures, list them with brief explanations]

[Suggest next action: fix failing tests, or continue to green/refactor phase]
```
