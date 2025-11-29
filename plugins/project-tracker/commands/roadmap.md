---
name: roadmap
description: View and manage your project roadmap
argument-hint: "[view|add|move|done]"
allowed-tools:
  - Read
  - Write
  - Edit
---

# Roadmap Management

View and manage your project roadmap. Supports multiple actions.

## Actions

### `/roadmap` or `/roadmap view`

Display current roadmap status in a compact format:

1. Read ROADMAP.md
2. Display summary:

```
📊 **Project Roadmap**

**Active:**
→ {Story Name} - {X}/{Y} tasks complete
  Currently: {last_task from .local.md or "Not started"}

**Done:** {N} stories completed
**Backlog:** {M} stories planned

Use `/roadmap add`, `/roadmap move`, or `/roadmap done` to update.
```

If no active story:
```
📊 **Project Roadmap**

**Active:** None

**Done:** {N} stories completed
**Backlog:** {M} stories planned
  • {First backlog item}
  • {Second backlog item}
  • ...

Use `/create-spec <feature>` to start working on a backlog item.
```

### `/roadmap add`

Add a new item to the backlog.

1. Ask what to add (if not provided inline):
   - "What feature would you like to add to the backlog?"

2. Ask for brief description:
   - "Give me a one-line description."

3. Append to Backlog section of ROADMAP.md:

```markdown
### {Feature Name}
{Description}
- {Rough AC hint 1}
- {Rough AC hint 2}
```

4. Confirm:
> Added **{Feature Name}** to backlog. Use `/create-spec {Feature Name}` when ready to detail it.

### `/roadmap move`

Move an item between sections (Backlog ↔ Active, Active → Done).

1. Show current items and ask what to move:
   - "What would you like to move?"
   - "Where should it go? (active/backlog/done)"

2. Edit ROADMAP.md to relocate the section

3. If moving to Active:
   - Check if spec exists, if not recommend `/create-spec`
   - Update .claude/project-tracker.local.md

4. If moving to Done:
   - Add completion marker (✓)
   - Add completion date

5. Confirm the move

### `/roadmap done`

Mark the current active story as complete.

1. Read current active story from ROADMAP.md or .local.md

2. If no active story:
   > "No active story to mark done. Use `/roadmap view` to see status."

3. If active story exists:
   - Ask for confirmation: "Mark **{Story Name}** as complete?"

4. On confirmation:
   - Move from Active to Done in ROADMAP.md
   - Add ✓ marker and completion date
   - Clear active_story in .local.md
   - Check all AC boxes in the Done entry

5. If there are backlog items:
   > **{Story Name}** marked complete! 🎉
   >
   > **Next up from backlog:**
   > • {Next backlog item}
   >
   > Use `/create-spec {Next item}` to continue.

6. If backlog is empty:
   > **{Story Name}** marked complete! 🎉
   >
   > Backlog is empty. Use `/discover` to plan more features or `/roadmap add` to add individual items.

## ROADMAP.md Format Reference

```markdown
# Project Roadmap

## Active

### Story: {Name}
{Description}

- [x] Completed task
- [x] Another completed task
- [ ] Current task ← working on this
- [ ] Upcoming task

📋 Spec: `.claude/specs/{name}.md`

## Done

### Story: {Name} ✓
{Description}

- [x] All tasks
- [x] Marked complete

_Completed: 2024-01-20_

## Backlog

### {Feature Name}
{Description}
- {AC hint}
- {AC hint}
```

## Edge Cases

**ROADMAP.md doesn't exist:**
> "No ROADMAP.md found. Run `/tracker-init` to set up project-tracker."

**Multiple active stories:**
This shouldn't happen, but if it does:
> "Found multiple active stories. Which one are you working on?"
Then update .local.md with the answer.

**User wants to move completed story back:**
Allow it, but confirm:
> "Move **{Story}** back to Active? This will unmark it as complete."
