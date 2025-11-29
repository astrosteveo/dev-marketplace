---
name: tracker-init
description: Initialize project-tracker in current project
allowed-tools:
  - Write
  - Bash
  - Read
---

# Initialize Project Tracker

Set up project-tracker in the current project by creating the necessary files and directories.

## Steps

1. Check if ROADMAP.md already exists:
   - If exists, ask user if they want to keep it or replace it
   - If replacing, backup to ROADMAP.md.bak

2. Create ROADMAP.md with this template:

```markdown
# Project Roadmap

## Active

_No active stories. Use `/create-spec` to create one, or `/discover` to plan your project._

## Done

_Completed stories will appear here._

## Backlog

_Future ideas and planned features._
```

3. Create .claude/specs/ directory if it doesn't exist:
```bash
mkdir -p .claude/specs
```

4. Create .claude/project-tracker.local.md template:

```markdown
---
active_story: null
last_task: null
last_session: null
---

## Session Notes

_Notes from current work session._
```

5. Add to .gitignore (create if doesn't exist, append if does):
```
.claude/*.local.md
```

6. Confirm success:

> **Project Tracker initialized!**
>
> Created:
> - `ROADMAP.md` - Your project roadmap
> - `.claude/specs/` - Directory for detailed specs
> - `.claude/project-tracker.local.md` - Session state tracking
>
> **Next steps:**
> - `/discover` - Break down your project idea into features
> - `/create-spec <feature>` - Create a spec for a specific feature
> - `/roadmap` - View your roadmap
