# Preflight - Technical Foundation Planner

**Make all foundational technical decisions before coding to prevent mid-implementation chaos.**

## The Problem This Solves

You start building something. Mid-way through, you realize:
- "Wait, what database should I use?"
- "Should this be an actor pattern or just Arc/Mutex?"
- "How many players am I even targeting?"
- "Do I need WebSockets or would HTTP work?"

Now you're retrofitting decisions into half-built code. The project becomes a mess. You get frustrated and quit.

**Preflight prevents this.**

## How It Works

```bash
/preflight:plan [your project]
```

Preflight:
1. **Detects your project type** (multiplayer game, web app, CLI tool, etc.)
2. **Asks ALL critical technical questions** for that type
3. **Saves decisions as you go** to `ROADMAP.md` YAML frontmatter
4. **Creates complete ROADMAP.md** with:
   - All decisions documented
   - Actionable implementation phases with checkboxes
   - Exact `/feature-dev:feature-dev [phase]` commands to run
5. **Updates ROADMAP.md automatically** via hooks as you implement
6. **Creates CLAUDE.md** for session continuity

**Now you can code without surprises.**

---

## Complete Workflow (How This Fits with Other Tools)

### Step 1: Figure out WHAT to build
```bash
/mvp-planner:plan [idea]
```
Output: `plan.md` - Features, MVP scope

### Step 2: Figure out HOW to build it ← THIS PLUGIN
```bash
/preflight:plan [project-name]
```
Output: `ROADMAP.md` - All technical decisions + implementation roadmap with checkboxes

### Step 3: Build it
```bash
/feature-dev:feature-dev Set up initial project structure from ROADMAP.md Phase 1
```
Hooks automatically update ROADMAP.md checkboxes as you complete tasks!

---

## Example: Multiplayer Game

**Without preflight (chaos):**
```
You: "Build a multiplayer space game"
Claude: *starts coding*
You: *implement basic server*
Claude: "How many players?"
You: "1000"
Claude: "Oh... you need actor pattern then. Let me refactor everything."
You: *frustrated, project becomes messy*
```

**With preflight (smooth):**
```bash
/preflight:plan space-sim

━━━ Preflight Questionnaire ━━━

Detected: Multiplayer Game

Q1: How many concurrent players?
→ You answer: 1000

Q2: 2D or 3D?
→ You answer: 3D

Q3: Game engine?
→ You answer: Custom Rust engine

Q4: Multiplayer architecture?
→ Suggested: Actor pattern (for 1000 players)
→ You confirm

Q5: Network protocol?
→ Suggested: UDP with MessagePack
→ You confirm

Q6: State synchronization?
→ Suggested: AoI filtering + delta compression
→ You confirm

Q7: Network tick rate?
→ You answer: 20Hz

Q8: World size?
→ You answer: Infinite procedural

✓ All decisions made! (12/12)

Creating ROADMAP.md...

━━━ Technical Roadmap Ready ━━━

Project: space-sim
Type: Multiplayer Game
Scale: 1000 concurrent players

Architecture: Actor pattern with AoI filtering
Protocol: UDP with MessagePack binary
Network: 20Hz tick rate

ROADMAP.md created with 8 implementation phases:
1. Project Setup (6 tasks)
2. Core Server (8 tasks)
3. Game State System (9 tasks)
4. Physics/Movement (7 tasks)
5. Client Rendering (10 tasks)
6. State Synchronization (8 tasks)
7. Database Integration (6 tasks)
8. Deployment (7 tasks)

Next: /feature-dev:feature-dev Set up initial project structure from ROADMAP.md Phase 1
```

**Now when you implement:**
```bash
/feature-dev:feature-dev Set up initial project structure from ROADMAP.md Phase 1
```

It implements Phase 1. After completion, the **PostToolUse hook automatically**:
- ✅ Checks off completed tasks in ROADMAP.md
- ✅ Updates phase status in frontmatter
- ✅ Shows you what's next

No manual tracking. Just keep running phases.

---

## Project Types Supported

### ✅ Multiplayer Games
Questions about:
- Player count / scale
- 2D vs 3D
- Game engine
- Multiplayer architecture
- State synchronization
- Network protocol
- Physics engine
- Database
- Deployment

### ✅ Web Applications
Questions about:
- SPA / SSR / MPA
- Frontend framework
- Backend framework
- Database
- Authentication
- API design
- Deployment

### ✅ APIs / Backends
Questions about:
- Framework
- Database
- Authentication
- API design (REST / GraphQL / gRPC)
- Deployment

### ✅ CLI Tools
Questions about:
- Language
- Argument parsing
- Configuration approach
- Distribution method

### ✅ Scripts
Questions about:
- Language
- Dependencies
- Input/output handling

### ✅ Desktop Apps
Questions about:
- Framework (Electron / Tauri / Native)
- Target OS
- Storage / backend
- Distribution

### ✅ Mobile Apps
Questions about:
- Platform (iOS / Android / both)
- Framework (React Native / Flutter / Native)
- Backend approach
- Distribution

---

## Key Features

### 🎯 **Systematic Decision-Making**
Goes through EVERY critical question for your project type. Nothing forgotten.

### 💾 **Single Source of Truth**
- ROADMAP.md with YAML frontmatter for machine-parsing
- Human-readable checkboxes for tasks
- Git-tracked progress
- No separate state files to lose

### 🪝 **Automatic Progress Tracking**
- **PostToolUse hook** updates ROADMAP.md after work completes
- Automatically checks off completed tasks
- Updates phase status
- Shows what's next

### 📋 **Context Continuity**
- `ROADMAP.md` - Complete technical contract + implementation tracking
- `CLAUDE.md` - Auto-loaded context for future sessions
- Follows [Claude best practices](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

### 🚫 **Prevents Compaction**
PreCompact hook blocks context compaction during planning, instructs you to `/clear` and resume.

### 🎓 **Educational**
Explains WHY each decision matters and suggests answers based on your scale/needs.

---

## Output Files

### `ROADMAP.md`
Complete technical roadmap with YAML frontmatter:

```markdown
---
project: space-sim
created: 2025-11-30
type: multiplayer-game
phase: implementation
decisions:
  - question: "How many concurrent players?"
    answer: "100-500"
    rationale: "Mid-scale MMO"
  # ... all decisions
roadmap_status:
  - phase: 1
    name: "Project Setup"
    status: complete
  - phase: 2
    name: "Core Server"
    status: in_progress
  # ... all phases
---

# space-sim - Technical Roadmap

## Overview
[Project description and technical approach]

## Technical Decisions
[All decisions with rationale]

## Architecture
[Architecture diagram and patterns]

## Project Structure
[Folder structure]

## Implementation Roadmap

### Phase 1: Project Setup ✅ COMPLETE
- [x] Initialize Cargo workspace
- [x] Create shared/server/client crates
- [x] Set up dependencies
...

### Phase 2: Core Server ⚙️ IN PROGRESS
- [x] Implement tokio UDP server
- [x] Add MessagePack serialization
- [ ] Create player connection handling
- [ ] Implement heartbeat system
...
```

**This is your single source of truth.** Commit to git. Update checkboxes as you work. Hooks do it automatically.

### `CLAUDE.md`
Auto-loaded context file:
- Current phase and progress
- Tech stack quick reference
- Common commands
- Project structure
- Next action to take

Claude reads this automatically in future sessions.

---

## Usage

### Basic Usage
```bash
/preflight:plan my-project
```

Preflight will ask what you're building if not obvious from name.

### With Description
```bash
/preflight:plan "Multiplayer space trading game"
```

Helps preflight detect project type faster.

### Resume After Interruption
```bash
/preflight:plan
```

Automatically resumes from ROADMAP.md frontmatter if planning incomplete.

### Check Progress During Implementation
```bash
cat ROADMAP.md | grep "^- \[[ x]\]"
```

Shows all tasks and their completion status.

---

## Configuration

Optional: Create `.claude/preflight.local.md` for custom settings:

```markdown
---
# Auto-detect project type or always ask
auto_detect: true

# Default suggestions based on scale
suggest_answers: true

# Create CLAUDE.md automatically
create_claude_md: true
---
```

---

## Philosophy

**This plugin intentionally slows you down to speed you up.**

5-15 minutes of planning prevents hours of refactoring later.

**For:**
- ✅ Long-term projects you'll iterate on
- ✅ Projects with any complexity
- ✅ Learning proper architecture patterns
- ✅ Preventing the "oh shit I forgot X" problem

**Not for:**
- ❌ Tiny throwaway scripts (unless you want the practice)
- ❌ "Just trying something out for 5 minutes"
- ❌ When you're 100% sure of every technical decision

---

## Integration with Other Plugins

### Works well with:
- **mvp-planner** - Use it first to decide WHAT to build
- **feature-dev** - Use after preflight to implement roadmap phases
- Any implementation workflow

### Flow Example:
```bash
# 1. Figure out product (mvp-planner)
/mvp-planner:plan Build a recipe manager

# 2. Figure out tech (preflight)
/preflight:plan recipe-manager

# 3. Implement phases sequentially
/feature-dev:feature-dev Set up initial project structure from ROADMAP.md Phase 1
/feature-dev:feature-dev Build database schema from ROADMAP.md Phase 2
/feature-dev:feature-dev Create API backend from ROADMAP.md Phase 3
# ... hooks update ROADMAP.md automatically as you go
```

---

## Best Practices

1. **Run preflight BEFORE any coding**
2. **Commit ROADMAP.md to git** immediately after creation
3. **Let hooks update checkboxes** automatically as you work
4. **Review ROADMAP.md** to see current progress
5. **Update ROADMAP.md** if major decisions change (update frontmatter + content)
6. **Start new sessions by reading CLAUDE.md** (automatic)

---

## Troubleshooting

**Preflight asks too many questions:**
- That's intentional. Each question prevents a later problem.
- Answer honestly based on your actual needs, not hypothetical scale.

**I don't know the answer to a question:**
- Preflight suggests answers based on your project needs
- Pick the suggested option if unsure
- You can always change later (update ROADMAP.md)

**Session got interrupted:**
- Just run `/preflight:plan` again
- It auto-resumes from ROADMAP.md frontmatter

**I want to start over:**
- Delete `ROADMAP.md`
- Run `/preflight:plan` again

**Checkboxes aren't updating automatically:**
- Ensure hooks are enabled
- Check `ROADMAP.md` frontmatter has `phase: implementation`
- PostToolUse hook should trigger after feature-dev completes

**I want to manually update progress:**
- Edit ROADMAP.md directly
- Change `- [ ]` to `- [x]` for completed tasks
- Update `roadmap_status` in frontmatter
- Commit changes

---

## How Hooks Work

### PreCompact Hook
- Triggers before context compaction
- Checks if ROADMAP.md exists with `phase: planning`
- Blocks compaction and tells you to `/clear` and resume
- Prevents losing planning decisions

### PostToolUse Hook
- Triggers after Write/Edit/Task tools complete
- Checks if ROADMAP.md exists with `phase: implementation`
- Reads what work was just done
- Updates appropriate checkboxes
- Updates phase status in frontmatter
- Reports progress to you

**Result:** You don't manually track progress. Just work. Hooks handle it.

---

## License

MIT

## Author

AstroSteveo (stevengmjr@gmail.com)
