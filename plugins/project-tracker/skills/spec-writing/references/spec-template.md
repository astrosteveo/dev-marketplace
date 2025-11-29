# Spec Template

Use this template when creating new specs with `/create-spec`.

---

## Template

```markdown
# {Feature Name}

## Overview

{One paragraph describing what this feature does and why it matters to the user/project. Focus on the "what" and "why", not the "how".}

## Acceptance Criteria

{Ordered list of checkboxes. Each should be independently verifiable and completable in 1-4 hours.}

- [ ] {First/foundational criterion - often data model or core structure}
- [ ] {Second criterion - builds on first}
- [ ] {Third criterion - adds functionality}
- [ ] {Continue as needed...}
- [ ] {Final criterion - often integration or polish}

## Technical Notes

{Implementation guidance, constraints, and context.}

**Approach:**
{Suggested implementation strategy or key decisions.}

**Depends on:**
{List specs/features this requires to be completed first, or "None" if standalone.}

**Blocks:**
{List specs/features that cannot start until this is done, or "None" if no dependents.}

**Constraints:**
{Performance requirements, compatibility needs, or limitations to respect.}

## Progress Log

| Date | Update |
|------|--------|
| {YYYY-MM-DD} | Spec created |
```

---

## Example: Filled Template

```markdown
# Decision System

## Overview

"Thought" popups during races that affect outcomes. Player manages one driver's mental state through real-time decisions. This creates a psychological management layer on top of the racing simulation, making player choices matter beyond just car setup.

## Acceptance Criteria

- [ ] Decision data structures exist (Decision, DecisionOption, DecisionOutcome)
- [ ] Psyche-based triggers fire (high anxiety, high fatigue, low confidence)
- [ ] Event-based triggers fire (overtake attempts, being passed, position changes)
- [ ] Decisions have time limits with expiry behavior (driver decides based on personality)
- [ ] Chat-bubble UI appears in corner (non-modal, doesn't pause game)
- [ ] Decision outcomes affect driver psyche stats
- [ ] Decision outcomes affect driver behavior/performance
- [ ] Decision log visible in HUD
- [ ] Player's controlled driver is visually marked

## Technical Notes

**Approach:**
Event-driven architecture where race events and psyche state changes emit events that the decision system listens to. Decisions queue and display one at a time to avoid overwhelming player.

**Depends on:**
- Psyche System (needs psyche stats to trigger and modify)
- Basic AI + Racing (needs race events to trigger decisions)

**Blocks:**
- Ability System (abilities will interact with decision outcomes)

**Constraints:**
- Decisions must not pause gameplay (async/non-blocking UI)
- Maximum 1 active decision at a time to maintain clarity
- Decision timeout should be tunable (default 10 seconds)

## Progress Log

| Date | Update |
|------|--------|
| 2024-01-15 | Spec created |
| 2024-01-16 | Data structures complete |
| 2024-01-17 | Working on trigger system |
```

---

## Tips for Using This Template

1. **Overview**: Write this for someone unfamiliar with the project. Why does this feature matter?

2. **Acceptance Criteria**: Order matters! Earlier items should unblock later items. If you find yourself writing "after X is done", reorder.

3. **Technical Notes**: This is where you capture decisions and constraints that would otherwise be lost. Future you will thank present you.

4. **Progress Log**: Update this as you work. It helps with session resumption and creates a record of how the feature evolved.
