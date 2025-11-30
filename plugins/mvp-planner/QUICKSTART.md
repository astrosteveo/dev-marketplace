# MVP Planner - Quick Start Guide

## Installation

The plugin is already registered in the dev-marketplace. To use it:

```bash
# Run Claude Code with the dev-marketplace
cc --plugin-dir /home/astrosteveo/workspace/dev-marketplace
```

## Basic Usage

### Scenario 1: "I have a vague idea"

```bash
/mvp-planner:plan Build a recipe manager
```

The plugin will:
1. Ask questions to understand your idea (beginner mode)
2. Help identify features needed
3. Prioritize what's MVP vs Post-MVP
4. Generate a specification document

### Scenario 2: "I know exactly what I want"

```bash
/mvp-planner:plan Build a CLI Docker manager with TUI, container listing,
log streaming, and exec. MVP excludes image management.
```

The plugin will:
1. Detect your detailed input (speed mode)
2. Quickly validate understanding
3. Fast-track through prioritization
4. Generate spec in under 2 minutes

### Scenario 3: "Resume interrupted session"

If your session gets interrupted:

```bash
/mvp-planner:plan
```

The plugin automatically:
1. Detects existing `.mvp-state.json`
2. Shows where you left off
3. Continues from that phase

## Output Files

After completion, you'll have:

1. **`mvp-spec.md`** - Your specification document
   - Problem statement
   - MVP features with rationale
   - Post-MVP features with why deferred
   - Ready-to-use `/feature-dev:feature-dev` commands

2. **`.mvp-state.json`** - State file for resumption
   - Current workflow phase
   - All planning decisions
   - Can be deleted after completion

## Customization

Create `.claude/mvp-planner.local.md` to customize:

```yaml
---
# Guidance mode: beginner | balanced | speed
default_mode: balanced

# Spec format: minimal | structured | agile
spec_template: structured

# Output location
spec_file: mvp-spec.md

# Auto-resume behavior
auto_resume: true

# Prioritization: simple | moscow | rice
prioritization_framework: simple
---
```

See `settings-template.md` for full options.

## Workflow Phases

The plugin guides you through 4 phases:

1. **Discovery** (discovery-guide agent)
   - Clarifies the idea
   - Identifies problem, users, value

2. **Feature Brainstorming** (feature-brainstorm agent)
   - Lists potential features
   - Identifies technical requirements

3. **MVP Scoping** (mvp-scoper agent)
   - Prioritizes features
   - Decides MVP vs Post-MVP

4. **Spec Writing** (spec-writer agent)
   - Generates specification document
   - Creates ready-to-use commands

## Common Questions

**Q: How long does it take?**
- Beginner mode: 10-20 minutes (lots of questions)
- Balanced mode: 5-10 minutes (key questions)
- Speed mode: 2-5 minutes (minimal questions)

**Q: Can I change my answers?**
- Yes! The state file is just JSON. Edit `.mvp-state.json` and re-run.

**Q: What if I want a different spec format?**
- Update `.claude/mvp-planner.local.md` with your preferred template
- Or use `spec_template: custom` and define your own

**Q: How do I start over?**
- Delete `.mvp-state.json` and run `/mvp-planner:plan` again

**Q: Can I use this with existing projects?**
- Yes! It generates planning docs that complement existing code

## Integration with feature-dev

After planning, use the generated commands:

```bash
# From mvp-spec.md, copy/paste the ready-to-use commands:
/feature-dev:feature-dev Recipe CRUD with title, ingredients, instructions
/feature-dev:feature-dev Recipe search and filtering by name and ingredient
```

Each feature is now ready for implementation with the official feature-dev plugin!

## Troubleshooting

**Command not found:**
- Verify plugin is loaded: `/help` should show `/mvp-planner:plan`
- Check marketplace.json includes mvp-planner

**State not resuming:**
- Verify `.mvp-state.json` exists in project root
- Check `auto_resume: true` in settings

**Wrong guidance mode:**
- Explicitly set `default_mode` in `.claude/mvp-planner.local.md`
- Or provide more/less detail in initial idea

## Next Steps After Spec Creation

1. **Review the spec** - Read `mvp-spec.md`, make sure it's accurate
2. **Adjust if needed** - Edit the spec document directly
3. **Start implementing** - Use the `/feature-dev:feature-dev` commands
4. **Iterate** - Build MVP, validate, add Post-MVP features based on learning

---

Happy planning! 🚀
