---
name: plan
description: Make all foundational technical decisions before coding
argument-hint: "[project-name or idea]"
allowed-tools:
  - Read
  - Write
  - Task
  - AskUserQuestion
---

# Preflight Plan Command

Your task is to help the user make ALL foundational technical decisions before writing any code.

## Purpose

Prevents the "oh shit I forgot to decide X" problem mid-implementation by forcing all technical decisions upfront. Creates ROADMAP.md as the single source of truth for planning and implementation tracking.

## Command Flow

1. **Check for existing ROADMAP.md**
   - Read `ROADMAP.md` if it exists
   - Check YAML frontmatter `phase` field:
     - If `phase: planning`: Resume from last decision
     - If `phase: planning_complete`: Launch foundation-writer to complete roadmap
     - If `phase: implementation`: Roadmap already complete, show current status
   - If no ROADMAP.md: Start fresh

2. **Detect or get project info**
   - If user provided `$ARGUMENT`: Use as project name/description
   - If no argument: Ask "What are you building?"

3. **Launch decision-guide agent**
   - Pass project info and any existing ROADMAP.md state
   - Agent will:
     - Create initial ROADMAP.md with YAML frontmatter
     - Detect project type (game, web app, script, etc.)
     - Ask ALL critical technical questions for that type
     - Update ROADMAP.md frontmatter after EACH decision
     - Set `phase: planning_complete` when done

4. **Launch foundation-writer agent** (after decisions complete)
   - Reads ROADMAP.md with all decisions in frontmatter
   - Enriches ROADMAP.md with:
     - Full technical decisions section
     - Architecture diagrams
     - Project structure
     - Implementation roadmap with checkboxes
     - feature-dev commands for each phase
   - Updates `phase: implementation`
   - Creates/updates `CLAUDE.md` for session continuity

## ROADMAP.md Structure

```markdown
---
project: space-sim
created: 2025-11-30
type: multiplayer-game
phase: planning | planning_complete | implementation
decisions:
  - question: "How many concurrent players?"
    answer: "100-500"
    rationale: "Mid-scale MMO"
    category: "scale"
  # ... all decisions
roadmap_status:
  - phase: 1
    name: "Project Setup"
    status: pending | in_progress | complete
  # ... all phases
---

# space-sim - Technical Roadmap

[Full content created by foundation-writer]
```

## Resume Behavior

If `ROADMAP.md` exists:

```
Resuming preflight for: [project_name]
Phase: [current phase from frontmatter]
Decisions made: X/Y (for planning phase)
OR
Current implementation phase: [phase name] ([X/Y] tasks complete)

Continuing...
```

## Important

- **Single source of truth**: ROADMAP.md contains ALL state
- ONE decision at a time (don't overwhelm)
- Update ROADMAP.md after EACH decision
- Make it CLEAR what's being asked and why
- Prevent ANY coding until ALL decisions made
- ROADMAP.md is tracked in git - progress is visible in commits
- Hooks will enforce ROADMAP.md updates during implementation

## Success

User ends up with:
- ✅ ROADMAP.md with all decisions documented
- ✅ YAML frontmatter for machine parsing
- ✅ Actionable implementation phases with checkboxes
- ✅ Exact `/feature-dev:feature-dev [phase]` commands to run
- ✅ CLAUDE.md for automatic session context
- ✅ No surprises - everything decided before coding
