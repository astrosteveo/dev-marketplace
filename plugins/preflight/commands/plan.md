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

Prevents the "oh shit I forgot to decide X" problem mid-implementation by forcing all technical decisions upfront.

## Command Flow

1. **Check for existing state**
   - Read `.preflight-state.json` if it exists
   - If state exists AND incomplete: Resume from last decision
   - If no state OR complete: Start fresh

2. **Detect or get project info**
   - If user provided `$ARGUMENT`: Use as project name/description
   - If no argument: Ask "What are you building?"

3. **Launch decision-guide agent**
   - Pass project info and any existing state
   - Agent will:
     - Detect project type (game, web app, script, etc.)
     - Ask ALL critical technical questions for that type
     - Save decisions to state file as they're made

4. **Launch foundation-writer agent** (after decisions complete)
   - Reads completed state
   - Creates `foundation.md` with all decisions documented
   - Includes rationale for each decision
   - Provides "next steps" guidance

## State File (`.preflight-state.json`)

```json
{
  "project_name": "space-sim",
  "project_type": "multiplayer_game",
  "phase": "decisions" | "complete",
  "decisions": {
    "scale": {
      "question": "How many concurrent players?",
      "answer": "1000",
      "rationale": "Determines architecture pattern"
    }
  }
}
```

## Resume Behavior

If `.preflight-state.json` exists and phase != "complete":
```
Resuming preflight for: [project_name]
Phase: [current phase]
Decisions made: X/Y

Continuing...
```

## Important

- ONE decision at a time (don't overwhelm)
- Save to state after EACH decision
- Make it CLEAR what's being asked and why
- Prevent ANY coding until ALL decisions made
- foundation.md is the "contract" - everything decided, documented, ready to build
