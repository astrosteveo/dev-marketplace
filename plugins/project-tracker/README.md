# Project Tracker

A Claude Code plugin for project planning and tracking that integrates with the feature-dev workflow.

## Overview

Project Tracker helps you go from vague idea to shipped features:

```
Idea → /project-tracker:discover → Feature Breakdown → /project-tracker:create-spec → /feature-dev:feature-dev → Done
```

## Features

- **Project Discovery**: Break down project ideas into prioritized, actionable features
- **Spec Creation**: Generate detailed specs with acceptance criteria
- **Session Continuity**: Resume where you left off between sessions
- **Roadmap Management**: Track Active/Done/Backlog status

## Commands

| Command | Description |
|---------|-------------|
| `/project-tracker:tracker-init` | Initialize project-tracker in current project |
| `/project-tracker:discover` | Decompose a project idea into features |
| `/project-tracker:create-spec <feature>` | Create detailed spec for a feature |
| `/project-tracker:roadmap [view\|add\|move\|done]` | Manage your roadmap |

## Quick Start

1. Initialize in your project:
   ```
   /project-tracker:tracker-init
   ```

2. Discover features for your idea:
   ```
   /project-tracker:discover I want to build a space simulation game
   ```

3. Create a spec for the first feature:
   ```
   /project-tracker:create-spec Basic Ship & Movement
   ```

4. Build it with feature-dev:
   ```
   /feature-dev:feature-dev Implement Basic Ship & Movement per spec
   ```

## File Structure

After initialization, your project will have:

```
your-project/
├── ROADMAP.md                    # Kanban overview (Active/Done/Backlog)
└── .claude/
    ├── specs/                    # Detailed spec files
    │   └── basic-ship-movement.md
    └── project-tracker.local.md  # Session state (gitignored)
```

## Integration with feature-dev

Project Tracker is designed to complement the [feature-dev plugin](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev):

1. **Before feature-dev**: Use `/project-tracker:discover` and `/project-tracker:create-spec` to define what to build
2. **During feature-dev:feature-dev**: Spec file provides context and acceptance criteria
3. **After feature-dev:feature-dev**: Automatically prompts to run `/project-tracker:roadmap done` when Phase 7 (Summary) completes

### Auto-completion Hook

When `/feature-dev:feature-dev` completes its workflow (Phase 7), a SubagentStop hook automatically detects completion and triggers `/project-tracker:roadmap done`. This marks the active story as complete and prompts you to start the next backlog item - keeping your workflow smooth and continuous.

## Session Continuity

On each session start, Project Tracker automatically loads your current context:
- What story is active
- What task you were working on
- Any session notes

This means you can close Claude Code and return later without losing context.

## License

MIT
