---
description: Transform vague ideas into concrete MVP specifications with guided discovery and prioritization
argument-hint: "[optional: your product idea]"
allowed-tools:
  - Read
  - Write
  - Task
  - AskUserQuestion
---

# MVP Planner - Plan Command

Your task is to guide the user through MVP planning, from idea to actionable specification.

## Command Flow

1. **Check for existing state**
   - Read `.mvp-state.json` if it exists
   - If state exists: Auto-resume from last phase with notification
   - If no state: Start fresh planning workflow

2. **Detect or determine guidance mode**
   - If user provided detailed idea in `$ARGUMENT`: Use **speed mode**
   - If user provided vague idea: Use **beginner mode**
   - If user provided moderate detail: Use **balanced mode**
   - Criteria for detection:
     - **Speed mode**: Input includes specific features, tech stack, or clear scope
     - **Beginner mode**: Input is 1-2 sentences with vague concept
     - **Balanced mode**: Input has some detail but lacks scope or features

3. **Launch agent workflow**
   - Use Task tool to launch agents sequentially
   - Each agent receives the current state and guidance mode
   - State is automatically saved by SubagentStop hook after each agent

## Agent Workflow

Launch agents in this order:

1. **discovery-guide**
   - Input: User's idea, guidance mode
   - Output: Problem statement, target users, core value proposition
   - Saves to `.mvp-state.json`

2. **feature-brainstorm**
   - Input: Discovery output, guidance mode
   - Output: List of potential features/systems
   - Saves to `.mvp-state.json`

3. **mvp-scoper**
   - Input: Feature list, guidance mode
   - Output: Features categorized as MVP or Post-MVP
   - Saves to `.mvp-state.json`

4. **spec-writer**
   - Input: All previous outputs, user settings
   - Output: Complete specification document (`mvp-spec.md`)
   - Provides ready-to-use `/feature-dev:feature-dev` commands

## Resume Behavior

When `.mvp-state.json` exists:

```
Resuming MVP planning for: [idea name]
Last completed: [phase name]
Continuing from: [next phase]
```

Then launch the appropriate next agent.

## Settings

Check for `.claude/mvp-planner.local.md` and read YAML frontmatter for:
- `default_mode`: Override auto-detection
- `spec_template`: Format preference (minimal, structured, agile, custom)
- `spec_file`: Output location (default: `mvp-spec.md`)
- `auto_resume`: Whether to auto-resume (default: true)
- `prioritization_framework`: simple, moscow, or rice

## Example Execution

**Beginner mode (vague input):**
```
User: /mvp-planner:plan Build a recipe manager

You: Starting MVP planning in beginner mode...
     Launching discovery-guide agent to explore your idea...
```

**Speed mode (detailed input):**
```
User: /mvp-planner:plan Build a CLI Docker manager with TUI, container
      listing, log streaming, and exec. MVP excludes image management.

You: Detected detailed input. Starting in speed mode...
     Launching discovery-guide to confirm scope...
```

**Resume mode:**
```
User: /mvp-planner:plan

You: Resuming MVP planning for: Recipe Manager
     Last completed: feature-brainstorm
     Continuing from: mvp-scoper

     Launching mvp-scoper agent...
```

## Important Notes

- NEVER run all agents at once - launch sequentially and wait for each to complete
- Each agent updates state via SubagentStop hook automatically
- If user provides `$ARGUMENT`, use it as the idea. Otherwise, ask for the idea.
- Always inform user which mode is being used (beginner/balanced/speed)
- Trust the hooks to handle state saving and compaction prevention
