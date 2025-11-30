---
name: Workflow Orchestration
description: This skill should be used when Claude needs to understand the feature development workflow, manage state persistence, resume paused features, handle context management, or understand phase transitions. Trigger phrases include "resume feature", "workflow phases", "state management", "how does the workflow work".
version: 1.0.0
---

# Workflow Orchestration Skill

Understand and manage the spec-driven feature development workflow with state persistence and context-aware resumption.

## Workflow Overview

The feature-dev-plus workflow follows this progression:

```
Discovery → Spec → Plan → [User Approval] → Implementation → Test → Commit
```

**Automatic phases** (no user intervention):
- Discovery → Spec → Plan

**Manual approval**:
- User reviews plan before implementation begins

**Implementation phases** (automatic after approval):
- Implementation → Test → Commit

## Phase Details

### 1. Discovery (Optional)

**When**: User runs `/feature-dev-plus` without argument

**Agent**: discovery-guide (Haiku)

**Purpose**: Help user articulate vague ideas through guided questions

**Outputs**:
- Initial spec stub: `docs/specs/{feature-name}.md`
- Updated state file with feature name and description

**Transitions to**: Spec phase

**Skip if**: User provides feature description as argument

---

### 2. Spec Writing

**When**: After discovery OR user provides argument

**Agent**: spec-writer (Sonnet)

**Purpose**: Create comprehensive feature specification

**Inputs**:
- Feature description (from discovery or argument)
- Discovery answers (if available)

**Outputs**:
- Complete spec: `docs/specs/{feature-name}.md`
- Updated state file

**Transitions to**: Plan phase

---

### 3. Planning

**When**: After spec writing completes

**Agent**: code-architect (Sonnet)

**Purpose**: Analyze codebase and create implementation roadmap

**Inputs**:
- Feature spec

**Outputs**:
- Implementation plan: `docs/specs/{feature-name}-plan.md`
- Task breakdown in state file
- Updated state file

**Transitions to**: Approval phase

---

### 4. User Approval (Manual)

**When**: After planning completes

**Interface**: Main command asks user to review and approve

**User sees**:
- Plan summary (files to create/modify, task count)
- Option to approve, revise, or cancel

**Options**:
- **Approve**: Proceed to implementation
- **Revise**: Re-run planning with feedback
- **Cancel**: Exit gracefully, keep state intact

**Transitions to**: Implementation (if approved)

---

### 5. Implementation

**When**: After user approves plan

**Agent**: code-architect (Sonnet, implementation mode)

**Purpose**: Autonomously implement all files according to plan

**Inputs**:
- Implementation plan
- Task list from state

**Outputs**:
- Created files (source code, configs)
- Modified files (integrations)
- Updated state (task progress)

**Progress tracking**:
- TodoWrite shows task completion
- State file updated after each major file
- `resumeContext` updated continuously

**Transitions to**: Test phase

---

### 6. Testing

**When**: After implementation completes

**Agent**: test-designer (Haiku)

**Purpose**: Create test structures for testable logic

**Inputs**:
- Spec (test strategy section)
- Implementation (to understand what was built)

**Outputs**:
- Test files with test cases
- Updated state file

**Skip if**: Feature has no testable logic (pure visual/UI)

**Transitions to**: Commit phase

---

### 7. Commit

**When**: After testing completes (or skips)

**Interface**: Main command handles git commit

**Purpose**: Create commit with descriptive message

**Outputs**:
- Git commit with:
  - Type: `feat:` for new features
  - Description from spec
  - Co-authored-by Claude
- State file deleted (feature complete)

**Transitions to**: Complete (workflow ends)

## State File Management

### State File Location

`.feature-state.json` in project root

### State File Structure

```json
{
  "currentFeature": {
    "name": "feature-kebab-name",
    "description": "Brief feature description",
    "phase": "current-phase",
    "specFile": "docs/specs/feature-name.md",
    "planFile": "docs/specs/feature-name-plan.md",
    "testFile": "tests/unit/feature-name.test.ts",
    "startedAt": "2025-11-29T10:00:00Z",
    "updatedAt": "2025-11-29T14:30:00Z"
  },
  "phases": {
    "discovery": "completed|in_progress|pending|skipped",
    "spec": "completed|in_progress|pending",
    "plan": "completed|in_progress|pending",
    "approval": "completed|in_progress|pending",
    "implementation": "completed|in_progress|pending",
    "test": "completed|in_progress|pending|skipped",
    "commit": "completed|in_progress|pending"
  },
  "tasks": [
    {
      "id": 1,
      "description": "Create OAuth provider interface",
      "status": "completed"
    },
    {
      "id": 2,
      "description": "Implement Google OAuth provider",
      "status": "in_progress"
    }
  ]
}
```

### State Updates

**When state updates**:
- After each agent completes (via SubagentStop hook)
- During implementation (task progress)
- Before context compaction (via PreCompact hook)
- On user approval/cancellation

**Who updates state**:
- state-manager agent (invoked by hooks)
- Main command (for approval phase)
- Agents directly (for task progress during implementation)

### State as Source of Truth

All components read state to determine:
- Current phase
- What files were created
- Which tasks are complete
- Where to resume

**Never rely on conversation context** - always read state file.

## Context Management

### Normal Operation

Agents run in separate contexts with own token budgets:
- Discovery, spec, plan phases: ~20K-40K tokens each
- Implementation phase: Can be large, but split across task updates

State file enables resumption if context fills.

### Approaching Context Limits

When main command detects context approaching limits (during implementation):

1. **Save comprehensive state**:
   - Current task and status
   - Last action completed
   - Next steps to take
   - Files in progress

2. **Add resumeContext**:
   ```json
   "resumeContext": {
     "lastAction": "Created OAuth provider in src/auth/oauth.ts:45",
     "currentTask": "Implement Google OAuth provider",
     "nextSteps": [
       "Complete Google OAuth provider implementation",
       "Add token storage mechanism",
       "Wire up OAuth routes"
     ],
     "filesInProgress": ["src/auth/google-oauth.ts"]
   }
   ```

3. **Instruct user**:
   ```
   ⚠️ Context limit approaching. Progress saved.

   Please run /clear to continue with fresh context.
   Then run /feature-dev-plus to resume.
   ```

4. **Exit gracefully**

### Resuming After /clear

When user runs `/feature-dev-plus` after `/clear`:

1. **Detect state file exists**
2. **Read resumeContext**
3. **Offer to resume**:
   ```
   📋 Found paused feature: {name}

   Progress:
   ✓ {Completed phases}
   ⚠️ {Current phase} (in_progress)

   Last action: {lastAction}
   Next: {nextSteps[0]}

   Resume from where you left off?
   ```

4. **If user confirms**:
   - Load state
   - Jump to current phase
   - Continue from current task
   - Full context restored from state

## Hooks Integration

### SessionStart Hook

**Trigger**: When new Claude Code session starts

**Logic**:
```bash
if [ -f ".feature-state.json" ]; then
  # State file exists, offer to resume
  echo "Found paused feature. Resume? /feature-dev-plus"
fi
```

### SubagentStop Hook

**Trigger**: After any feature-dev-plus agent completes

**Logic**:
- Launch state-manager agent with completion payload
- State-manager updates phase transition
- Silently exit (no user-facing output)

### PreCompact Hook

**Trigger**: Before Claude Code attempts context compaction

**Logic**:
- Launch state-manager agent with pause payload
- State-manager adds resumeContext and pausedAt
- Output clear user instructions
- Block compaction (return failure)

**Why block compaction**:
Compaction loses conversation context. Better to /clear and resume cleanly than compact mid-implementation.

## Phase Transitions

### Automatic Transitions

```
Discovery → Spec:
- discovery-guide completes
- SubagentStop hook updates state
- Next command invocation starts spec-writer

Spec → Plan:
- spec-writer completes
- SubagentStop hook updates state
- Next invocation starts code-architect

Plan → Approval:
- code-architect completes planning
- SubagentStop hook updates state
- Next invocation shows plan and waits for user

Implementation → Test:
- code-architect completes implementation
- SubagentStop hook updates state
- Next invocation starts test-designer

Test → Commit:
- test-designer completes (or skips)
- SubagentStop hook updates state
- Next invocation handles git commit
```

### Manual Transitions

**Approval → Implementation**:
- User explicitly approves plan
- Command updates state to "implementation"
- Launches code-architect in implementation mode

**User can cancel**:
- At approval phase
- State remains intact (no deletion)
- User can resume later or abandon

## Error Recovery

### Agent Failure

If agent fails mid-execution:
- State remains at current phase
- resumeContext preserved (if set)
- User can re-run command to retry
- Or manually fix and continue

### State File Corruption

If state file is corrupted:
- Command detects on read
- Prompts user to delete and restart
- No automatic recovery (user intervention required)

### User Wants Fresh Start

If user wants to abandon current feature:
```bash
# Delete state to start fresh
rm .feature-state.json

# Or rename to keep as backup
mv .feature-state.json .feature-state.backup.json
```

## Best Practices

### For Users

1. **Let workflow complete**: Trust automatic progression through discovery → spec → plan
2. **Review plans carefully**: This is the decision point before implementation
3. **Use /clear proactively**: If context feels full, clear before forced compaction
4. **Resume promptly**: After /clear, resume soon (state is fresher in your mind)

### For Plugin Developers

1. **Update state frequently**: After every significant action
2. **Keep resumeContext detailed**: Future Claude needs clear next steps
3. **Read state, don't assume**: Always check state file for current phase
4. **Exit after launching agents**: Don't wait or monitor, let hooks handle transitions
5. **Trust the state file**: It's the source of truth, not conversation context

## Workflow Variations

### Express Mode (with argument)

User provides clear feature description:
```bash
/feature-dev-plus "Add Google OAuth login"
```

**Workflow**:
```
Spec → Plan → Approval → Implementation → Test → Commit
(Discovery skipped)
```

### Discovery Mode (no argument)

User has vague idea:
```bash
/feature-dev-plus
```

**Workflow**:
```
Discovery → Spec → Plan → Approval → Implementation → Test → Commit
(Full workflow)
```

### Resumption Mode

User resumes after /clear:
```bash
/feature-dev-plus
```

**Workflow**:
```
[Read state] → Continue from current phase
```

## For More Details

See reference files:
- `references/state-schema.md` - Complete JSON schema for state file
- `references/workflow-diagram.md` - Visual flowchart of phases
- `references/hook-integration.md` - How hooks maintain state
