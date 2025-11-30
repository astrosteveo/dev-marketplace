---
name: MVP Methodology
description: >
  This skill should be used when Claude needs to understand or teach what makes
  something truly "minimal" while still being "viable" - the core tension in MVP
  planning. Trigger phrases include "what is MVP", "how do I decide what's minimal",
  "is this feature MVP", "am I over-engineering", "what should be in the first version".
version: 1.0.0
---

# MVP Methodology

Understand what makes something a true Minimum Viable Product and how to scope MVPs effectively.

## Core Principle

An MVP is the **smallest thing you can build that still delivers measurable value** to real users.

It's about **learning**, not launching perfectly.

## The Two Common Mistakes

### 1. Building Too Much (Over-Engineering)
- Adding "nice-to-have" features before validating core value
- Trying to compete with mature products on day one
- Building for hypothetical future users instead of current ones
- Confusing MVP with "feature complete"

**Result:** Months of development, no validation, wasted effort on wrong features

### 2. Building Too Little (Under-Engineering)
- Shipping something so minimal it provides no value
- Skipping essential features because "MVP should be small"
- Building a toy instead of a product
- Ignoring basic usability

**Result:** Users try it once and never come back, no learning happens

## The MVP Balance

A good MVP is:
- **Minimal**: Smallest feature set possible
- **Viable**: Actually solves the core problem
- **Product**: Real enough to learn from

## The Essential Question

For each potential feature, ask:

> **"Can users get the core value without this feature?"**

- If YES → Post-MVP (defer it)
- If NO → MVP (include it)
- If MAYBE → Dig deeper, understand the core value better

## MVP Scoping Framework

### Step 1: Identify the Core Problem
What specific problem are you solving? Be precise.

❌ Bad: "Help people be more productive"
✅ Good: "Help developers find Docker containers faster than using docker ps"

### Step 2: Identify the Core Value
What's the minimum value that makes someone use your solution instead of their current approach?

Example: Recipe manager
- Core value: "Find my recipes faster than searching through bookmarks"
- Not core value: "Share recipes with friends" (social feature, not core)

### Step 3: List Features That Deliver Core Value
Only include features essential to delivering that core value.

Example: CLI Docker Manager
- ✅ MVP: TUI interface, list containers, view logs (delivers core value)
- ❌ Post-MVP: Resource graphs, saved filters (nice-to-haves)

### Step 4: Remove Everything Else
Be ruthless. Every feature you defer is a week you get to launch sooner and start learning.

## Real-World MVP Examples

### Twitter (2006)
**MVP:**
- Post 140 character updates
- See updates from people you follow
- Public timeline

**Not in MVP:**
- Retweets
- Likes/favorites
- Images/videos
- Hashtags
- Direct messages
- Mobile apps

**Result:** Launched in 2 weeks, validated core value, then added features based on learning

### Dropbox (2007)
**MVP:**
- Sync files between computers
- Basic folder interface

**Not in MVP:**
- File sharing with others
- Mobile apps
- Version history
- Selective sync
- Team features

**Result:** Simple demo video validated demand before building full product

### Stripe (2010)
**MVP:**
- Process credit card payments via API
- Basic dashboard

**Not in MVP:**
- Subscriptions
- Multiple currencies
- Complex routing
- Radar fraud detection
- Connect platform

**Result:** Focused on "easiest way to accept payments" validated before expanding

## Red Flags: You're Over-Engineering If...

🚩 "We need authentication before we can launch"
→ Ask: Can MVP work for single-user or local-only first?

🚩 "We need mobile apps on day one"
→ Ask: Can MVP be mobile-responsive web first?

🚩 "We need real-time updates"
→ Ask: Can MVP use polling or manual refresh?

🚩 "We need to support all these formats/platforms"
→ Ask: Can MVP support just the most common one?

🚩 "We need analytics and admin dashboards"
→ Ask: Can MVP use simple logging first?

🚩 "We should build it as a platform from the start"
→ Ask: Can MVP solve one specific use case first?

## Green Flags: You're Scoping Well If...

✅ The MVP feels uncomfortably small
✅ You're embarrassed by what you're shipping
✅ You could build it in days/weeks, not months
✅ You can explain the core value in one sentence
✅ You're deferring obvious good features
✅ You have a clear plan for what to validate

## The MVP Mindset

Think of MVP as a **learning tool**, not a product launch:

**Wrong mindset:** "Let's build version 1.0 with all basic features"
**Right mindset:** "Let's build the smallest thing to test our core assumption"

**Wrong question:** "What features do we need to compete?"
**Right question:** "What's the minimum to solve the problem?"

**Wrong goal:** "Launch something we're proud of"
**Right goal:** "Learn whether our solution works"

## After MVP: What Comes Next?

Once MVP is live and being used:

1. **Validate**: Did it solve the core problem?
2. **Measure**: Are users getting value?
3. **Learn**: What do users actually need?
4. **Iterate**: Add features based on real usage, not guesses

The Post-MVP features you deferred might not even be what users want. MVP helps you find out what they actually need.

## Quick Reference Guide

| Question | Answer |
|----------|--------|
| How many features? | 3-8 typically, focus on quality over quantity |
| How long to build? | Days to weeks, not months |
| Who should use it? | Real users with the problem (even if it's just you) |
| What if it's too simple? | Good! Simple means fast validation |
| What if users want more? | Great signal! Now you know what to build next |
| What if no one uses it? | You just saved months building the wrong thing |

## Common MVP Prioritization Frameworks

### Simple Framework (Recommended)
For each feature ask: "Is this essential for core value?"
- Yes → MVP
- No → Post-MVP

### MoSCoW Method
- **M**ust have → MVP
- **S**hould have → Soon after MVP
- **C**ould have → Later
- **W**on't have → Never

### RICE Scoring
Score features on:
- **R**each: How many users?
- **I**mpact: How much value?
- **C**onfidence: How sure?
- **E**ffort: How much work?

Formula: (R × I × C) / E = Priority score

## Further Reading

See `references/mvp-case-studies.md` for detailed examples of successful MVPs and their evolution.

---

**Remember:** The best MVP is the one you can ship this week, not the perfect one you'll ship "someday."
