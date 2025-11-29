---
name: discover
description: Decompose a project idea into prioritized features
argument-hint: "<project idea or topic>"
allowed-tools:
  - Read
  - Write
  - Edit
  - SlashCommand
  - AskUserQuestion
---

# Project Discovery

Guide the user through decomposing a project idea into actionable, prioritized features. This command is designed to help users who may be new to software development understand how to break down large ideas into manageable pieces.

## Philosophy

Discovery is a **collaborative thinking process**, not just output generation. The goal is to:
1. Help users understand their own idea more deeply
2. Teach decomposition patterns through example
3. Produce a prioritized feature list they can execute on

## Process

### Phase 1: Understanding the Vision (2-3 questions)

Start by understanding what the user wants to build. Ask questions like:

- "What's the core experience you want users to have?"
- "If you could only ship ONE thing, what would it be?"
- "Who is this for and what problem does it solve for them?"

Keep questions conversational. Avoid overwhelming with too many questions at once.

### Phase 2: Identifying the MVP

Help the user identify the Minimum Viable Product - the smallest version that delivers value.

Explain the concept:
> "Let's identify your MVP - the simplest version that would actually be useful. This isn't about cutting corners, it's about finding the core value and proving it works before adding complexity."

Ask:
- "What's the absolute minimum someone needs to get value from this?"
- "What can we save for later without losing the core experience?"

### Phase 3: Feature Decomposition

Break the idea into features. Use these patterns and EXPLAIN them to the user:

**Vertical Slice Pattern:**
> "I'm suggesting we start with [X] because it's a 'vertical slice' - it touches all the layers (data, logic, UI) and gives us something complete to build on. Future features will extend this foundation."

**Foundation First Pattern:**
> "These first few features are foundational - [Y] needs to exist before [Z] can work. Think of it like building a house: foundation, then walls, then roof."

**MVP Expansion Pattern:**
> "Once the MVP is working, we can expand outward: better error handling, edge cases, polish. Each expansion makes the core experience more robust."

### Phase 4: Prioritization & Dependencies

Order features by:
1. **Dependencies** - What must exist before other things can work?
2. **Value** - What delivers the most user value soonest?
3. **Risk** - What's technically uncertain and should be validated early?

Note blockers and dependencies for each feature.

### Phase 5: Output to ROADMAP.md

After user approves the breakdown, update ROADMAP.md:

1. Read current ROADMAP.md
2. Add discovered features to Backlog section
3. Format each feature with:
   - Name
   - One-line description
   - Key acceptance criteria hints (2-4 bullets)
   - Dependencies (if any)

Example format for Backlog:
```markdown
## Backlog

### Basic Ship & Movement
Ship renders and responds to keyboard input.
- Ship entity with position, velocity, rotation
- Keyboard controls (WASD or arrows)
- Ship renders on screen with basic sprite
- _No dependencies_

### Star System View
Background stars and solar system layout.
- Parallax star background
- Planets/stations as destinations
- Camera follows ship
- _Depends on: Basic Ship & Movement_

### Ship-to-Planet Navigation
Select and travel to destinations.
- Click planet to select destination
- Ship travels toward selected destination
- Arrival detection and state change
- _Depends on: Star System View_
```

### Phase 6: Offer Next Step

After updating ROADMAP.md:

> **Discovery complete!** I've added {N} features to your backlog.

Then use AskUserQuestion: "Ready to create a spec for the first feature?"
- Options: List the top 2-3 MVP features from the backlog, plus "No, I'll do it later"
- If user selects a feature, use SlashCommand to run `/project-tracker:create-spec {selected feature}`

## Tips

- If user seems overwhelmed, slow down and focus on just the MVP
- Use analogies to familiar products when helpful
- Celebrate the clarity that emerges from good decomposition
- Remind users: "You can always `/project-tracker:discover` again to add more features later"

## Edge Cases

**No ROADMAP.md exists:**
Use AskUserQuestion: "No ROADMAP.md found. Initialize project-tracker first?"
- Options: "Yes, initialize" / "No, I'll create it manually"
- If yes, use SlashCommand to run `/project-tracker:tracker-init`, then continue with discovery

**User idea is too vague:**
Ask more clarifying questions. "Tell me more about [aspect]."

**User wants to skip to building:**
Gently suggest the value: "Taking 10 minutes to plan can save hours of rework. But if you'd prefer, we can start with just the first feature."

**Features are too large:**
Help break them down further: "This feels like it might be 2-3 features. What if we separated [X] from [Y]?"
