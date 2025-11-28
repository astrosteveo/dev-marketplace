---
name: test-reviewer
description: >
  Quality gate between Red and Green phases. Reviews test cases for meaningful assertions and
  catches superficial tests that would pass without validating behavior. Use when: (1) user says
  "review tests", "check tests", "are these tests good", (2) after writing tests before implementing,
  (3) suspicious that tests might be passing trivially. Blocks progression to Green if tests are weak.
---

# Test Review

Quality gate. Verify tests are meaningful before implementing.

## Pre-Flight

1. Tests written? If not: **STOP** → "Write tests first (Red phase)."
2. Find test file for ACTIVE story

## Five Quality Checks

| Check | Question |
|-------|----------|
| **Assertion Alignment** | Does the assertion verify what the test name claims? |
| **Superficial Passing** | Would this pass even if the code was broken/missing? |
| **Setup Validity** | Does Arrange actually create the scenario described? |
| **Behavioral Focus** | Testing observable behavior or implementation details? |
| **Failure Mode** | Does the test fail for the RIGHT reason? |

## Red Flags

| Pattern | Problem | Verdict |
|---------|---------|---------|
| `Assert.IsNotNull(x)` only | Existence != correctness | WEAK |
| `Assert.IsTrue(true)` | Always passes | SUPERFICIAL |
| `Assert.Pass()` | No assertion | SUPERFICIAL |
| Test name ≠ assertion | Misleading coverage | WEAK |
| No Arrange, just Act | Missing preconditions | WEAK |
| Mocking the SUT | Testing nothing | SUPERFICIAL |
| `catch { Assert.Pass() }` | Hiding failures | SUPERFICIAL |
| Hardcoded expected = actual | Circular logic | SUPERFICIAL |

## Verdicts

| Verdict | Meaning | Action |
|---------|---------|--------|
| **STRONG** | Assertion validates claimed behavior | Proceed to Green |
| **WEAK** | Tests something, but not the right thing | Improve before Green |
| **SUPERFICIAL** | Would pass without real implementation | Rewrite required |

## Process

1. Read test file for ACTIVE story
2. For EACH test method:
   - State the claimed behavior (from test name)
   - State what assertion actually checks
   - Compare: do they match?
   - Check for red flags
   - Assign verdict
3. Block Green phase if any SUPERFICIAL tests
4. Recommend improvements for WEAK tests

## Output Format

```
## Test Review: [file:line]

### [TestMethodName]
**Claims**: [what the test name says it tests]
**Actually Tests**: [what the assertion verifies]
**Verdict**: STRONG | WEAK | SUPERFICIAL
**Issue**: [if not STRONG, what's wrong]
**Fix**: [specific improvement]

---

## Summary
- Strong: N
- Weak: N
- Superficial: N

**Gate**: PASS | BLOCKED
[If BLOCKED: "Fix superficial tests before implementing."]
[If PASS: "Tests are meaningful. Ready for Green phase."]
```

## Anti-Patterns (in this phase)

| Don't | Do Instead |
|-------|------------|
| Skip review to save time | Weak tests waste more time later |
| Accept "it compiles" as passing | Verify meaningful assertions |
| Review implementation code | Focus only on test quality |
| Write implementation to fix tests | Fix the tests themselves |

## Exit → Green (implement)

Only when Gate = PASS
