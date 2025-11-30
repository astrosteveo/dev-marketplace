---
description: Start or continue iterative development workflow (Foundation -> Explore -> Plan -> Red -> Green -> Verify -> Commit)
argument-hint: Optional feature description, "new project", or "continue"
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, Task, TodoWrite, AskUserQuestion
---

<!--
/iterate - One command to master them all
Usage:
  /iterate                    - Check state and continue or start
  /iterate [feature desc]     - Start new feature with description
  /iterate new project [desc] - Start brand new project (Foundation phase)
  /iterate continue           - Resume from ROADMAP.md
-->

You are initiating the **iterate** workflow:

```
[Foundation] → Explore → Plan → [Red → Green → Refactor] → Verify → Commit
      ↑
      Only for new projects
```

## Step 1: Determine Project State

Check for existing project indicators:

```bash
# Check for ROADMAP.md
test -f ROADMAP.md && echo "ROADMAP_EXISTS" || echo "ROADMAP_MISSING"

# Check for FOUNDATION.md
test -f FOUNDATION.md && echo "FOUNDATION_EXISTS" || echo "FOUNDATION_MISSING"

# Check if this looks like an existing project (has src/, package.json, Cargo.toml, etc.)
ls -la | head -20
```

## Step 2: Route Based on State

### Route A: NEW PROJECT (no FOUNDATION.md, minimal/no code)

**Indicators of new project:**
- User said "new project" in arguments
- No FOUNDATION.md exists
- No significant source code directories
- No package.json, Cargo.toml, pyproject.toml, etc.

**Action**: Start with **Foundation phase**:

1. Launch the **foundation** agent
2. Guide user through tech stack selection
3. Create FOUNDATION.md with all decisions
4. Create initial ROADMAP.md with Foundation phase complete
5. Transition to Explore phase

### Route B: EXISTING PROJECT, NEW FEATURE (has code, no current feature)

**Indicators:**
- Has FOUNDATION.md OR significant existing code
- ROADMAP.md missing OR no current feature in progress
- User provided feature description

**Action**: Start with **Explore phase**:

1. Ask user what feature they want to build (unless in $ARGUMENTS)
2. Create/update ROADMAP.md with feature in "Explore" phase
3. Launch **explorer** agent to understand codebase
4. Continue through workflow phases

### Route C: CONTINUE EXISTING WORK (ROADMAP.md has current feature)

**Indicators:**
- ROADMAP.md exists with current feature in progress
- User said "continue" OR gave no arguments

**Action**: Resume from current phase:

1. Read ROADMAP.md to determine current phase
2. Launch appropriate agent:
   - **Foundation**: foundation agent (rare - only if interrupted)
   - **Explore**: explorer agent
   - **Plan**: planner agent
   - **Red**: red-phase agent
   - **Green**: green-phase agent
   - **Verify**: verifier agent
   - **Commit**: committer agent
3. Update ROADMAP.md after agent completes
4. Transition to next phase

## ROADMAP.md Format

```markdown
# ROADMAP

## Project Foundation
See FOUNDATION.md for tech stack and architectural decisions.

## Current Feature: [Feature Name]

### Phase: [Phase Name]

- [ ] **Foundation**: Tech stack and architecture (new projects only)
- [ ] **Explore**: [Summary of exploration goals/findings]
- [ ] **Plan**: [Summary of architecture/approach]
- [ ] **Red**: Write failing tests
  - [ ] Unit: `[test file path]`
  - [ ] Integration: `[test file path]`
- [ ] **Green**: Implement to pass tests
- [ ] **Verify**: All tests pass, code reviewed
- [ ] **Commit**: Merged to main

**Test Status**: Unit [status] | Integration [status]

**Notes**:
- [Important notes, blockers, decisions]

---

## Backlog
- [ ] [Future feature 1]
- [ ] [Future feature 2]

## Completed
- [x] [Previous feature] (Unit [status] | Integration [status])
```

## Phase Indicators

| Phase | Header |
|-------|--------|
| Foundation | `### Phase: Foundation (Tech Stack)` |
| Explore | `### Phase: Exploring` |
| Plan | `### Phase: Planning` |
| Red | `### Phase: Red (Writing Tests)` |
| Green | `### Phase: Green (Implementing)` |
| Refactor | `### Phase: Refactoring` |
| Verify | `### Phase: Verifying` |
| Commit | `### Phase: Committing` |

## Phase Transition Rules

1. **Foundation -> Explore**: When tech stack documented in FOUNDATION.md
2. **Explore -> Plan**: When codebase understanding is sufficient
3. **Plan -> Red**: When architecture and test strategy defined
4. **Red -> Green**: When ALL tests exist and FAIL
5. **Green -> Refactor**: When all tests PASS (optional)
6. **Refactor -> Verify**: When code clean AND tests pass
7. **Verify -> Commit**: When verification confirms quality
8. **Commit -> Complete**: Move to Completed, start next from Backlog

## TDD Enforcement

The iterate plugin enforces TDD via hooks:
- **strict**: Block implementation without tests
- **warn**: Allow but log violations
- **off**: No enforcement

Check `.claude/iterate.local.md` for strictness setting.

## Feature-Dev Integration

After Plan phase completion:

1. Summarize feature context
2. Ask: "Ready to start implementation? I can launch /feature-dev:feature-dev with this context."
3. If yes, invoke feature-dev with prepared context

## Agent Usage

Launch agents via Task tool:
- `foundation`: Tech stack selection (new projects)
- `explorer`: Deep codebase exploration
- `planner`: Architecture and test strategy
- `red-phase`: Write failing tests
- `green-phase`: Minimal implementation
- `verifier`: Verify quality
- `committer`: Context-aware commits

Always update ROADMAP.md after each agent completes.
