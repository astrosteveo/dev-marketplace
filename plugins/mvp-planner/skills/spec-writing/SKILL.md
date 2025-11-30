---
name: Spec Writing
description: >
  This skill should be used when Claude needs to create or understand specification
  documents for software projects. Trigger phrases include "how do I write a spec",
  "what should a spec include", "create a specification", "spec template", "write
  user stories", "acceptance criteria". Provides templates and best practices for
  different spec formats.
version: 1.0.0
---

# Spec Writing

Create clear, actionable specification documents that guide implementation effectively.

## Purpose of a Spec

A good specification document:
1. **Captures requirements** clearly and completely
2. **Guides implementation** with actionable details
3. **Documents decisions** for future reference
4. **Aligns stakeholders** on what's being built
5. **Prevents misunderstandings** before coding starts

## Spec Writing Principles

### 1. Be Clear, Not Comprehensive
**Good spec:** Clear problem, clear solution, clear scope
**Bad spec:** Every possible detail documented upfront

The best specs are **just enough** to guide implementation without becoming outdated immediately.

### 2. Focus on "What" and "Why", Not "How"
**Good:** "Users need to search recipes by ingredient"
**Bad:** "Implement a full-text search using Elasticsearch with..."

Let implementation figure out the "how" unless architecture is critical to the decision.

### 3. Make It Actionable
Every spec should answer:
- What problem are we solving?
- Who is it for?
- What are we building?
- What are we explicitly NOT building?
- How do we know it's done?

## Spec Template Options

### Minimal Template
**Best for:** Solo developers, simple projects, rapid prototyping

**Structure:**
```markdown
# MVP: [Name]

## Problem
[1-2 sentences]

## MVP Features
- [ ] Feature 1
- [ ] Feature 2

## Post-MVP
- Feature 3
- Feature 4

## Next Steps
[Ready-to-implement commands or tasks]
```

**Pros:** Fast to write, easy to scan, low maintenance
**Cons:** Light on detail, might miss edge cases

### Structured Template (Recommended Default)
**Best for:** Most projects, balanced detail, team environments

**Structure:**
```markdown
# MVP Plan: [Name]

## Problem Statement
[2-3 sentences describing the problem]

## Target Users
[Who has this problem]

## Value Proposition
[Why they'll use this solution]

---

## MVP Scope

### In Scope (MVP Features)

#### Feature 1: [Name]
**Description:** [What it does]
**Why MVP:** [Rationale]
**User Story:** As a [user], I want [capability] so that [benefit]

### Out of Scope (Post-MVP)
- **Feature X** - [Why deferred]

---

## Technical Approach
[High-level architecture if needed]

## Success Metrics
[How we measure success]

## Next Steps
[Implementation commands or tasks]
```

**Pros:** Good balance of detail and brevity, flexible
**Cons:** Takes longer to write than minimal

### Agile/Jira Template
**Best for:** Agile teams, sprint planning, enterprise environments

**Structure:**
```markdown
# Epic: [Name]

## Epic Description
**Problem:** [The problem]
**Users:** [Target users]
**Value:** [Value proposition]

---

## MVP User Stories

### Story 1: [Title]
**As a** [user type]
**I want** [capability]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

**Priority:** Must Have
**Story Points:** [Estimate]

---

## Post-MVP Backlog
[Deferred stories]

## Implementation Plan
[Sprint breakdown]
```

**Pros:** Jira-ready, great for teams, clear acceptance criteria
**Cons:** More overhead, can feel bureaucratic for solo work

## Writing User Stories

### The Template
```
As a [type of user]
I want [capability]
So that [benefit]
```

### Good User Stories (INVEST Criteria)

**I - Independent:** Can be built separately from other stories
**N - Negotiable:** Details can be discussed and refined
**V - Valuable:** Delivers value to users
**E - Estimable:** Team can estimate effort
**S - Small:** Can be completed in one iteration
**T - Testable:** Clear acceptance criteria

### Examples

✅ **Good:**
```
As a home cook
I want to search my recipes by ingredient
So that I can find recipes using what I have in my fridge
```

❌ **Bad (too vague):**
```
As a user
I want to search
So that I can find stuff
```

❌ **Bad (too technical):**
```
As a developer
I want to implement a PostgreSQL full-text search index
So that search is fast
```

## Writing Acceptance Criteria

Acceptance criteria define when a feature is "done." Use clear, testable statements.

### Good Acceptance Criteria

✅ **Specific and testable:**
- When user enters ingredient name, matching recipes display within 2 seconds
- Search is case-insensitive
- Partial matches are supported (searching "tom" finds "tomato")
- If no recipes match, display "No recipes found" message

❌ **Bad (vague):**
- Search should be fast
- Search should work well
- Users should be able to find recipes

### Formats for Acceptance Criteria

**Given-When-Then (BDD style):**
```
Given I have 50 recipes in my collection
When I search for "chicken"
Then I see all recipes containing "chicken" in title or ingredients
```

**Checklist style:**
```
- [ ] User can enter search term
- [ ] Search is performed on title and ingredients
- [ ] Results update as user types (debounced)
- [ ] Clicking result opens recipe detail
```

## Scope Management

### What to Include in Scope Section

**In Scope (MVP):**
- Features that deliver core value
- Essential technical requirements
- Must-have user workflows

**Explicitly Out of Scope (Post-MVP):**
- Nice-to-have features (with WHY deferred)
- Future enhancements
- Advanced capabilities
- Alternative approaches considered but rejected

### Why "Out of Scope" Matters

Explicitly documenting what's NOT being built:
- Prevents scope creep
- Sets stakeholder expectations
- Documents deferred decisions
- Helps with future prioritization

Example:
```markdown
## Out of Scope (Post-MVP)

- **Recipe Sharing** - Deferred to focus on personal use case. Revisit after 100 active users.
- **Multi-language Support** - MVP is English-only. Add localization based on user requests.
- **Offline Mode** - Requires service worker complexity. Add if mobile usage exceeds 30%.
```

## Technical Approach Section

Include when:
- Architecture decisions affect scope or timeline
- Technical constraints exist (browser compatibility, performance)
- Tech stack needs alignment (new technology vs proven tools)

**Good technical approach:**
```markdown
## Technical Approach

**Frontend:** React + TypeScript
- Chosen for: Team familiarity, component reusability
- Trade-off: Bundle size vs developer productivity

**Storage:** LocalStorage for MVP
- Rationale: No backend needed initially, faster to ship
- Migration path: Can sync to cloud storage in Post-MVP

**Recipe Import:** Cheerio for web scraping
- Handles most cooking websites
- Fallback to manual entry if scraping fails
```

**Avoid:** Page-long technical designs with every implementation detail. Save that for architecture docs.

## Success Metrics Section

Define how you'll know if the MVP succeeds. Be specific and measurable.

**Good metrics:**
- "Can organize 50+ recipes in under 30 minutes"
- "Find any recipe in under 10 seconds"
- "Used at least 3 times per week"

**Bad metrics (too vague):**
- "Users like it"
- "It works well"
- "Good performance"

## Next Steps Section

End with actionable next steps. Make it easy to start implementing.

**For feature-dev integration:**
```markdown
## Next Steps

Ready-to-use feature-dev commands:
```bash
/feature-dev:feature-dev Recipe CRUD with title, ingredients, instructions
/feature-dev:feature-dev Search and filter recipes by name and ingredient
```
```

**For manual implementation:**
```markdown
## Next Steps

1. Set up React project with TypeScript
2. Implement Recipe CRUD (start here - core functionality)
3. Add search functionality
4. Build mobile-responsive UI
5. Implement recipe import from URLs
```

## Common Spec Mistakes

### 1. Too Much Detail Too Soon
**Mistake:** 50-page spec documenting every edge case before writing code
**Fix:** Start with high-level spec, fill details as you implement

### 2. No Problem Statement
**Mistake:** Jump straight to features without explaining WHY
**Fix:** Always start with problem, users, value

### 3. Vague Requirements
**Mistake:** "Search should be good"
**Fix:** "Search returns results in < 2 seconds, supports partial matching"

### 4. No Scope Boundaries
**Mistake:** Open-ended scope that grows forever
**Fix:** Explicitly list what's out of scope and why

### 5. Writing for Wrong Audience
**Mistake:** Technical spec for business stakeholders, or vice versa
**Fix:** Know your audience and write accordingly

## Spec Templates by Use Case

| Use Case | Recommended Template | Why |
|----------|---------------------|-----|
| Solo side project | Minimal | Speed > completeness |
| Small team project | Structured | Balance detail and agility |
| Enterprise/Agile team | Agile | Integrates with Jira/sprint process |
| Open source project | Structured | Community needs clarity |
| Client deliverable | Agile | Stakeholder expectations |

## Template Files

See `examples/` directory for:
- `minimal-template.md` - Lightweight spec template
- `structured-template.md` - Balanced detail template
- `agile-template.md` - Jira-ready template
- `custom-template.md` - Customizable template base

## Best Practices Summary

1. **Start with the problem** - Always explain why before what
2. **Be specific about scope** - Both in-scope and out-of-scope
3. **Make it testable** - Clear acceptance criteria
4. **Keep it current** - Update as decisions change
5. **Make it actionable** - End with clear next steps
6. **Choose right template** - Match formality to context
7. **Focus on value** - Every feature should deliver user value

---

**Remember:** The best spec is the one that actually gets used. Don't over-engineer your documentation process.
