---
name: spec-writing
description: This skill should be used when the user asks to "write a spec", "create a specification", "define acceptance criteria", "break down a feature", "write user stories", or needs guidance on structuring feature requirements. Provides patterns for effective spec writing and task decomposition.
version: 0.1.0
---

# Spec Writing Guide

## Overview

Effective specs bridge the gap between idea and implementation. A good spec answers three questions: What are we building? How do we know it's done? What constraints exist?

## Spec Structure

Every spec follows this structure:

```markdown
# {Feature Name}

## Overview
What this feature does and why it matters. One paragraph.

## Acceptance Criteria
Checkboxes that define "done". Each should be independently verifiable.

## Technical Notes
Implementation hints, constraints, dependencies, blockers.

## Progress Log
Date-stamped updates as work progresses.
```

## Writing Acceptance Criteria

Good acceptance criteria are **SMART**: Specific, Measurable, Achievable, Relevant, Time-bound (implicitly, by being scoped to this spec).

### Patterns for AC

**User-facing behavior:**
```markdown
- [ ] User can {action} and sees {result}
- [ ] When {condition}, the system {behavior}
- [ ] {Component} displays {information} in {format}
```

**Technical requirements:**
```markdown
- [ ] {System} handles {edge case} by {behavior}
- [ ] Performance: {operation} completes in under {time}
- [ ] Data persists across {boundary}
```

**Integration points:**
```markdown
- [ ] {Feature} integrates with {existing system} via {mechanism}
- [ ] {Event} triggers {response} in {dependent system}
```

### Granularity

Each AC should be:
- **Completable in 1-4 hours** - If longer, break it down
- **Independently testable** - Can verify without other ACs
- **Ordered by dependency** - Earlier items unblock later ones

## Task Decomposition Patterns

### Vertical Slice

Build one complete path through all layers first:
```
1. Data model for core entity
2. Basic UI to display entity
3. User action to modify entity
4. Persistence of changes
```

### Foundation First

Build infrastructure, then features:
```
1. Core data structures
2. Basic rendering/display
3. User input handling
4. Feature-specific logic
```

### MVP Expansion

Start minimal, add depth:
```
1. Simplest working version
2. Error handling
3. Edge cases
4. Polish and UX improvements
```

## Dependency Notation

Mark blockers in Technical Notes:

```markdown
## Technical Notes

**Depends on:**
- Basic Ship & Movement (for ship entity)
- Resource System (for fuel consumption)

**Blocks:**
- Combat System (needs ship damage model)
```

## Common Mistakes

1. **Vague AC**: "System works well" → "System responds within 200ms"
2. **Too large**: "Implement combat" → Break into weapons, shields, AI, damage
3. **Missing edge cases**: Happy path only → Include error states
4. **No dependencies**: Isolated spec → Note what it needs and enables

## Additional Resources

### Reference Files

For detailed templates and examples:
- **`references/spec-template.md`** - Complete spec template with examples

## Quick Reference

**Spec sections:** Overview → Acceptance Criteria → Technical Notes → Progress Log

**AC format:** `- [ ] {Verifiable statement of done}`

**Granularity:** 1-4 hours per AC, independently testable

**Dependencies:** Note in Technical Notes what blocks/is blocked by this spec
