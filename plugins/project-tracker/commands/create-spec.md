---
name: create-spec
description: Create a detailed spec for a feature
argument-hint: "<feature name or description>"
allowed-tools:
  - Read
  - Write
  - Edit
  - Task
  - SlashCommand
  - AskUserQuestion
---

# Create Spec

Create a detailed specification for a feature, either from the backlog or from a new idea.

## Process

### Step 1: Identify the Feature

If argument provided:
- Check if it matches a feature in ROADMAP.md Backlog
- If match found, use that as the basis
- If no match, treat as a new feature description

If no argument:
- Read ROADMAP.md
- Show Backlog items and ask which to spec out

### Step 2: Gather Context

Read relevant context:
- ROADMAP.md (for dependencies, related features)
- Existing specs in .claude/specs/ (for consistency and dependencies)
- Any existing code that relates to this feature

### Step 3: Create the Spec

Use the spec-creator agent to generate a detailed spec:

```
Launch spec-creator agent with:
- Feature name/description
- Context from ROADMAP.md
- Any existing related specs
```

The agent will create a spec with:
- Overview (what and why)
- Acceptance Criteria (ordered, 1-4 hour chunks)
- Technical Notes (approach, dependencies, constraints)
- Progress Log (initialized with creation date)

### Step 4: Save the Spec

Create spec file at `.claude/specs/{feature-name-kebab-case}.md`

Example: "Basic Ship & Movement" → `.claude/specs/basic-ship-movement.md`

### Step 5: Update ROADMAP.md

1. If feature was in Backlog:
   - Move it to Active section
   - Update format to show it's now a full spec

2. If feature is new:
   - Add it directly to Active section

3. Update .claude/project-tracker.local.md:
   - Set active_story to the feature name
   - Clear last_task
   - Update last_session timestamp

Active section format:
```markdown
## Active

### Story: {Feature Name}
{One-line description}

{Acceptance criteria copied from spec, as checklist}

📋 Spec: `.claude/specs/{feature-name}.md`
```

### Step 6: Offer Next Steps

> **Spec created!**
>
> 📋 `.claude/specs/{feature-name}.md`

Then use AskUserQuestion: "What would you like to do next?"
- Options:
  - "Start implementing" - Begin working on this feature
  - "Review the spec" - Read through and potentially adjust acceptance criteria
  - "Done for now" - End here

If user selects "Start implementing":
- Use SlashCommand to run `/feature-dev:feature-dev Implement {Feature Name} per spec in .claude/specs/{feature-name}.md`

If user selects "Review the spec":
- Read and display the spec file, then ask if they'd like to make any adjustments

## Edge Cases

**No ROADMAP.md exists:**
> "No ROADMAP.md found."

Then use AskUserQuestion: "Would you like to initialize project-tracker first?"
- Options: "Yes, initialize" / "No"
- If yes, use SlashCommand to run `/project-tracker:tracker-init`

**Feature already has a spec:**
Ask if user wants to:
- View existing spec
- Replace it (backup old one)
- Create a new version

**Feature depends on incomplete features:**
Note this clearly:
> "This feature depends on {X} which isn't complete yet. You can still create the spec, but implementation should wait until dependencies are done."

**Very large feature:**
If AC list exceeds 10 items, suggest breaking into smaller features:
> "This feature has {N} acceptance criteria. Consider breaking it into 2-3 smaller features for easier tracking."
