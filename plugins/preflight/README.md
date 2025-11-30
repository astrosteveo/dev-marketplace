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
3. **Saves decisions as you go** (survives interruptions)
4. **Creates foundation.md** with everything documented
5. **Creates CLAUDE.md** for session continuity

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
Output: `foundation.md` - All technical decisions made

### Step 3: Build it
```bash
/feature-dev:feature-dev [feature]
```
Or just start coding - foundation.md has everything decided.

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
→ You answer: 2D

Q3: Game engine?
→ You answer: Custom Rust + Godot client

Q4: Multiplayer architecture?
→ Suggested: Actor pattern (for 1000 players)
→ You confirm

Q5: Network protocol?
→ Suggested: MessagePack binary
→ You confirm

Q6: State synchronization?
→ Suggested: AoI filtering (10km radius)
→ You confirm

Q7: Network tick rate?
→ You answer: 20Hz

Q8: World size?
→ You answer: 50km open world

✓ All decisions made!

Creating foundation.md...
Creating CLAUDE.md...

━━━ Technical Foundation Summary ━━━

Project: space-sim
Type: Multiplayer Game
Scale: 1000 concurrent players

Architecture: Actor pattern with AoI filtering
Protocol: MessagePack binary
Network: 20Hz tick rate
Concurrency: tokio with mpsc channels

RATIONALE: Actor pattern required for 1000+ concurrent
connections. AoI filtering prevents bandwidth explosion.

Next steps:
1. Review foundation.md (all decisions documented)
2. Initialize git
3. Create project structure
4. Start implementing

Everything is decided. No surprises.
```

**Now when you use feature-dev:**
```bash
/feature-dev:feature-dev WebSocket server with actor pattern
```

It implements exactly what's in `foundation.md`. No stopping mid-way to ask about architecture.

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
- Tick rate

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

### 💾 **State Persistence**
- Saves after each decision
- Survives session interruptions
- Auto-resumes where you left off

### 📋 **Context Continuity**
- Creates `foundation.md` - Full technical contract
- Creates `CLAUDE.md` - Auto-loaded context for future sessions
- Follows [Claude best practices](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) for long-running projects

### 🚫 **Prevents Compaction**
Hook blocks context compaction during planning, instructs you to `/clear` and resume.

### 🎓 **Educational**
Explains WHY each decision matters and suggests answers based on your scale/needs.

---

## Output Files

### `foundation.md`
Complete technical specification:
- All decisions with rationale
- Architecture description
- Technology stack
- Project structure
- Next steps
- Common commands
- Warnings & gotchas

**This is your technical contract.** Commit to git. Reference during implementation.

### `CLAUDE.md`
Auto-loaded context file:
- Project type and stack
- Architecture pattern
- Common commands
- Project structure
- Code style guidelines
- Important files
- Gotchas

Claude reads this automatically in future sessions.

### `.preflight-state.json`
State file for resumption:
- Project info
- Completed decisions
- Current phase

Delete after foundation is created (or keep for reference).

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

Automatically resumes if `.preflight-state.json` exists.

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
- ❌ Tiny throwaway scripts
- ❌ "Just trying something out for 5 minutes"
- ❌ When you're 100% sure of every technical decision

---

## Integration with Other Plugins

### Works well with:
- **mvp-planner** - Use it first to decide WHAT to build
- **feature-dev** - Use after preflight to implement features
- Any implementation workflow

### Flow Example:
```bash
# 1. Figure out product (mvp-planner)
/mvp-planner:plan Build a recipe manager

# 2. Figure out tech (preflight)
/preflight:plan recipe-manager

# 3. Implement (feature-dev or manual)
/feature-dev:feature-dev Recipe CRUD with Postgres
```

---

## Best Practices

1. **Run preflight BEFORE any coding**
2. **Commit foundation.md to git** immediately
3. **Reference foundation.md** when making implementation choices
4. **Update foundation.md** if major decisions change
5. **Start new sessions by reading CLAUDE.md** (automatic)

---

## Troubleshooting

**Preflight asks too many questions:**
- That's intentional. Each question prevents a later problem.
- Answer honestly based on your actual needs, not hypothetical scale.

**I don't know the answer to a question:**
- Preflight suggests answers based on your project needs
- Pick the suggested option if unsure
- You can always change later (but foundation.md tracks the decision)

**Session got interrupted:**
- Just run `/preflight:plan` again
- It auto-resumes from `.preflight-state.json`

**I want to start over:**
- Delete `.preflight-state.json`
- Run `/preflight:plan` again

---

## Examples

See `foundation.md` examples in this repo:
- `examples/multiplayer-game-foundation.md`
- `examples/web-app-foundation.md`
- `examples/cli-tool-foundation.md`

---

## License

MIT

## Author

AstroSteveo (stevengmjr@gmail.com)
