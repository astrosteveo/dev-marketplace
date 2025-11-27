---
name: researcher
description: >
  Research phase of Red-Green-Refactor TDD workflow. Deep exploration of codebase, stack, domain,
  and problem space before any planning or coding begins. Use when: (1) user shares a new idea,
  feature request, or bug report, (2) user says "research", "explore", "investigate", "understand",
  "look into", or "analyze", (3) starting work on an unfamiliar area of the codebase, (4) before
  planning any new epic or feature. This phase produces understanding, NOT code.
---

# Research Phase

Understand before acting. No code. No planning. Just exploration.

## Explore

| Area | Discover |
|------|----------|
| Stack | Languages, frameworks, test tools, conventions |
| Codebase | Entry points, patterns, similar features, test structure |
| Domain | Problem type, common solutions, trade-offs, prior art |
| Problem | User goal, success criteria, constraints, edge cases |

## Actions

1. Read config files (package.json, etc.)
2. Find similar implementations
3. Identify existing patterns
4. Ask clarifying questions
5. **NO CODE** - exploration only

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| Assume you know the stack | Read actual config files |
| Trust training data | Read actual codebase |
| Start planning | Finish exploring first |
| Write any code | Take notes only |

## Output

```
## Research Summary

**Stack**: [language, frameworks, test tools, conventions]
**Domain**: [problem type, common solutions, selected approach]
**Problem**: [user goal, success criteria, constraints, edge cases]
**Approach**: [similar code references, pattern to follow, key risks]

Ready to plan?
```

## Exit → Plan
