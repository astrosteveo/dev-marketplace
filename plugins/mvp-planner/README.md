# MVP Planner

Transform vague ideas into concrete MVP specifications with guided discovery, feature brainstorming, and intelligent prioritization.

## Problem

You have an idea, but you don't know:
- What features you actually need
- What should be in the MVP vs. later
- How to break it down into actionable tasks

`/feature-dev:feature-dev` is great for implementing features—but what if you don't know what features to build yet?

## Solution

**mvp-planner** bridges the gap between "I have an idea" and "I have a concrete plan." It guides you through a structured workflow:

1. **Discovery** - Explore and clarify your idea
2. **Feature Brainstorming** - Identify potential features/systems needed
3. **MVP Prioritization** - Decide what's truly minimal vs. nice-to-have
4. **Spec Generation** - Create actionable specification document

## For Everyone

- **Beginners:** "I have a vague idea, help me figure out what I need"
- **Intermediate:** "I know roughly what I want, help me refine and prioritize"
- **Experts:** "I know exactly what I want, just generate the spec fast"

The plugin **auto-detects** how much guidance you need based on your input specificity.

## Who This Is For

**This plugin is for builders who think in iterations, not one-shots.**

### ✅ You should use this if:
- You're building a **long-lasting, persistent project** you'll iterate on
- You want to **validate core value** before adding bells and whistles
- You're willing to **ship small, learn, then expand**
- You understand MVPs are **learning tools**, not finished products
- You're building something you'll **maintain and grow over time**

### ❌ This is NOT for:
- **Vibecoders** trying to prompt-engineer a complete product in one session
- One-shot "build me a full SaaS in 30 minutes" attempts
- Projects you'll abandon after the first version
- People who think MVP means "barely functional prototype"
- Weekend hackathons where you just need something working NOW

**The philosophy:** This plugin helps you build the *right* thing by starting small and learning. If you're trying to build everything at once, you're doing it wrong—and this plugin will slow you down (intentionally).

## Usage

### Basic Usage

```bash
/mvp-planner:plan Build a recipe manager app
```

The plugin will:
- Detect your experience level from input specificity
- Guide you through discovery and feature brainstorming
- Help you prioritize what's MVP vs post-MVP
- Generate a structured specification document
- Provide ready-to-use `/feature-dev:feature-dev` commands

### With Detailed Input (Speed Mode)

```bash
/mvp-planner:plan Build a CLI Docker container manager with TUI interface,
container listing, log streaming, and exec support. MVP excludes image
management and networking config.
```

Plugin response:
```
Detected detailed input. Generating spec in speed mode...
✓ Problem identified
✓ MVP features identified
✓ Post-MVP identified
✓ Spec created: mvp-spec.md

Ready to implement:
- /feature-dev:feature-dev TUI interface with container listing
- /feature-dev:feature-dev Log streaming viewer
- /feature-dev:feature-dev Container exec support
```

### Resume After Interruption

If your session gets too long, the plugin will:
1. Automatically save progress to `.mvp-state.json`
2. Block context compaction
3. Instruct you to run `/clear` or `/new`
4. Auto-resume where you left off when you run `/mvp-planner:plan` again

## Features

### Adaptive Guidance Modes

- **Beginner Mode:** Heavy guidance, lots of questions
- **Balanced Mode:** Moderate guidance, key questions only
- **Speed Mode:** Minimal questions, fast execution

Mode is **auto-detected** from your input specificity.

### State Persistence

- Survives session restarts
- Prevents context compaction from losing progress
- Automatic resume on fresh sessions
- State stored in `.mvp-state.json`

### Flexible Spec Formats

- **Minimal:** Problem + MVP checklist
- **Structured:** Problem statement, user stories, technical approach (default)
- **Agile:** Full epics, acceptance criteria, Jira-ready

Configurable via `.claude/mvp-planner.local.md`

### Smart Prioritization

Uses simple question-based framework:
- "Is this essential for core value?"
- Helps avoid over-engineering
- Balances minimal vs. viable

## Configuration

Create `.claude/mvp-planner.local.md` to customize:

```markdown
---
# Default guidance mode: beginner | balanced | speed
default_mode: balanced

# Spec template: minimal | structured | agile | custom
spec_template: structured

# Spec output location
spec_file: mvp-spec.md

# Auto-resume on state detection: true | false
auto_resume: true

# Prioritization framework: simple | moscow | rice
prioritization_framework: simple
---

# Custom Spec Template (optional)

If you set `spec_template: custom`, define your template here...
```

## Components

### Commands
- `/mvp-planner:plan [idea]` - Main entry point for MVP planning

### Agents
- `discovery-guide` - Explores and clarifies the initial idea
- `feature-brainstorm` - Identifies features and systems needed
- `mvp-scoper` - Prioritizes features into MVP vs post-MVP
- `spec-writer` - Generates the final specification document

### Skills
- `mvp-methodology` - Teaches what makes something truly MVP
- `spec-writing` - Spec templates and best practices

### Hooks
- `PreCompact` - Prevents context loss by blocking compaction and saving state
- `SubagentStop` - Auto-saves progress after each workflow phase

## Output

After completion, you'll have:

1. **`mvp-spec.md`** - Complete specification document
2. **Ready-to-use commands** - Copy/paste `/feature-dev:feature-dev` commands
3. **`.mvp-state.json`** - State file (for resumption)

## Example Workflow

```bash
# Start with vague idea
/mvp-planner:plan I want to build something for managing my recipes

# Plugin guides you through:
# 1. Discovery: What problem does this solve? Who uses it?
# 2. Brainstorming: Recipe CRUD, search, categories, sharing, meal planning...
# 3. Prioritization: MVP = CRUD + search. Post-MVP = sharing, meal planning
# 4. Spec generation: Creates mvp-spec.md

# Output:
✓ Spec created: mvp-spec.md

Ready to implement:
- /feature-dev:feature-dev Recipe CRUD operations
- /feature-dev:feature-dev Recipe search and filtering
```

## Integration with feature-dev

This plugin is designed to **feed into** the official `/feature-dev:feature-dev` plugin:

1. Use `mvp-planner` to define WHAT to build
2. Use `feature-dev` to implement each feature

Perfect handoff between planning and implementation.

## License

MIT

## Author

AstroSteveo (stevengmjr@gmail.com)
