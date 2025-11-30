---
name: feature-dev-plus
description: Enhanced feature development with discovery mode, spec-driven workflow, state persistence, and context management
argument-hint: "Optional: describe the feature you want to build"
allowed-tools:
  - Read
  - Write
  - Bash
  - Task
  - AskUserQuestion
  - TodoWrite
---

# Feature Development Plus Command

You are orchestrating an enhanced feature development workflow with state persistence and context-aware resumption.

## Process

### 1. Check for Existing State

First, check if `.feature-state.json` exists in the current directory:

```bash
if [ -f ".feature-state.json" ]; then cat .feature-state.json; fi
```

**If state file exists:**
- Read the JSON to extract feature name, current phase, and progress
- Use AskUserQuestion to ask: "Resume paused feature '{name}' (currently in {phase} phase) or start new feature?"
- Options: "Resume", "Start New"
- If "Resume": Skip to step 3 and continue from current phase
- If "Start New": Continue with step 2

### 2. Determine Entry Mode

**If $ARGUMENT is provided:**
- User has clear idea of what to build
- Skip discovery, proceed directly to spec writing
- Create initial state file:
  ```json
  {
    "currentFeature": {
      "name": "[derive-from-argument]",
      "description": "$ARGUMENT",
      "phase": "spec",
      "startedAt": "[current-timestamp]",
      "updatedAt": "[current-timestamp]"
    },
    "phases": {
      "discovery": "skipped",
      "spec": "in_progress",
      "plan": "pending",
      "implementation": "pending",
      "test": "pending",
      "commit": "pending"
    },
    "tasks": []
  }
  ```
- Proceed to step 3 with "spec" phase

**If no $ARGUMENT provided:**
- User needs help articulating requirements
- Create initial state with discovery phase:
  ```json
  {
    "currentFeature": {
      "name": "unknown",
      "description": "To be determined",
      "phase": "discovery",
      "startedAt": "[current-timestamp]",
      "updatedAt": "[current-timestamp]"
    },
    "phases": {
      "discovery": "in_progress",
      "spec": "pending",
      "plan": "pending",
      "implementation": "pending",
      "test": "pending",
      "commit": "pending"
    },
    "tasks": []
  }
  ```
- Launch discovery-guide agent using Task tool
- Exit after agent launches (agent will update state and trigger next phase)

### 3. Create Todo List for Phase Tracking

Use TodoWrite to create a todo list showing all phases with current status:

```
- Discovery: [completed/in_progress/pending/skipped]
- Spec Writing: [completed/in_progress/pending]
- Planning: [completed/in_progress/pending]
- ** User Approval **: [completed/pending]
- Implementation: [completed/in_progress/pending]
- Testing: [completed/in_progress/pending]
- Commit: [completed/in_progress/pending]
```

### 4. Execute Current Phase

Based on `currentFeature.phase` in state file:

**Phase: discovery**
- Launch discovery-guide agent (Haiku model)
- Agent will ask questions and create spec stub
- Exit after launching

**Phase: spec**
- Launch spec-writer agent (Sonnet model)
- Agent will create comprehensive spec document
- Exit after launching

**Phase: plan**
- Launch code-architect agent (Sonnet model)
- Agent will analyze codebase and create implementation plan
- Exit after launching

**Phase: approval**
- Read spec file and plan file from state
- Present plan summary to user
- Use AskUserQuestion: "Review complete. Approve implementation plan?"
- Options: "Approve & Start Implementation", "Revise Plan", "Cancel"
- If approved: Update state phase to "implementation", continue
- If revise: Ask what to change, relaunch code-architect
- If cancel: Exit gracefully

**Phase: implementation**
- Read plan from state file
- Launch code-architect agent with implementation mode (Sonnet model)
- Agent autonomously implements all files in plan
- Exit after launching

**Phase: test**
- Read spec and implementation status from state
- Determine if feature has testable logic:
  - Check spec for "Test Strategy" section
  - Look for keywords: "logic", "computation", "validation", "business rules"
  - Skip if: "visual", "UI", "gamedev", "rendering", "subjective"
- If testable: Launch test-designer agent (Haiku model)
- If not testable: Update state phase to "commit", skip to commit phase

**Phase: commit**
- Read state file for all changes made
- Create git commit with descriptive message
- Use pattern: "feat: {feature-name}\n\n{brief description from spec}"
- Update state to mark feature as completed
- Remove state file (feature complete)
- Output success message with summary

### 5. State File Management

**Always** use the state file as source of truth:
- Read state before making decisions
- Write updates after each phase transition
- Include timestamps for tracking
- Maintain `resumeContext` for detailed resumption info

### 6. Token Efficiency Best Practices

- **Use agents aggressively**: Offload all heavy work to Task tool with appropriate agents
- **Don't explore codebase**: Let agents do exploration in their own context
- **Keep command logic minimal**: Just orchestration, no analysis
- **Exit after launching agents**: Don't wait or monitor, let hooks handle state updates
- **Parallel operations**: Launch multiple agents if phases allow (discovery → spec can batch)

### 7. Context Management

If you notice context approaching limits during this command:
- Immediately save current state to file
- Add `pausedAt` timestamp and `pauseReason: "context_limit"`
- Instruct user: "State saved. Run /clear then /feature-dev-plus to resume"
- Exit gracefully

## Important Notes

- **This is instructions FOR you (Claude)**, not instructions to show the user
- Use Task tool for all agent launches, never try to do agent work inline
- Trust the state file completely, it's maintained by state-manager agent via hooks
- Be concise in outputs, detailed logs go in state file
- Always create TodoWrite list for phase visibility
- Auto-progress through discovery → spec → plan, then PAUSE for approval before implementation

## Example Flow

**User runs:** `/feature-dev-plus "Add OAuth2 login"`

**You do:**
1. Check `.feature-state.json` - doesn't exist
2. Argument provided, skip discovery
3. Create state file (phase: spec)
4. Create TodoWrite list
5. Launch spec-writer agent
6. Exit

**Agent completes, hook updates state to phase: plan**

**Next command invocation (automatic or manual):**
1. Read state - phase is "plan"
2. Launch code-architect agent
3. Exit

**Agent completes, hook updates state to phase: approval**

**Next invocation:**
1. Read state - phase is "approval"
2. Read plan file
3. Show plan to user
4. Ask for approval
5. If approved: Update state to "implementation"
6. Launch implementation agent
7. Exit

**...continues until commit phase, then feature complete**

## Error Handling

- If state file is corrupted: Ask user to delete and restart
- If agent fails: Keep state intact, user can retry
- If user cancels: Mark state as "cancelled", don't delete file
- If context limits hit: Pause gracefully with clear instructions
