---
# MVP Planner Configuration
# Copy this file to .claude/mvp-planner.local.md to customize plugin behavior

# Default guidance mode: beginner | balanced | speed
# - beginner: Heavy guidance, lots of questions (for vague ideas)
# - balanced: Moderate guidance, key questions only (default)
# - speed: Minimal questions, fast execution (for detailed ideas)
default_mode: balanced

# Spec template: minimal | structured | agile | custom
# - minimal: Lightweight checklist format
# - structured: Balanced detail with user stories (default)
# - agile: Jira-ready with epics and acceptance criteria
# - custom: Use template below
spec_template: structured

# Spec output location (relative to project root)
spec_file: mvp-spec.md

# Auto-resume on state detection: true | false
# If true, automatically resume from .mvp-state.json on fresh sessions
auto_resume: true

# Prioritization framework: simple | moscow | rice
# - simple: "Is this essential for core value?" (recommended)
# - moscow: Must/Should/Could/Won't categorization
# - rice: Reach/Impact/Confidence/Effort scoring
prioritization_framework: simple
---

# Custom Spec Template

If you set `spec_template: custom` above, define your template here.

Use these placeholders in your template:
- `{{project_name}}` - Name of the project
- `{{problem}}` - Problem statement from discovery
- `{{users}}` - Target users
- `{{value}}` - Value proposition
- `{{mvp_features}}` - List of MVP features
- `{{post_mvp_features}}` - List of Post-MVP features
- `{{feature_dev_commands}}` - Ready-to-use commands

Example custom template:

```markdown
# Project: {{project_name}}

## The Problem
{{problem}}

## Who It's For
{{users}}

## Why They'll Use It
{{value}}

## What We're Building (MVP)
{{mvp_features}}

## What We're NOT Building (Yet)
{{post_mvp_features}}

## Let's Build It
{{feature_dev_commands}}
```

---

## Notes

- Settings are optional - plugin works with defaults if this file doesn't exist
- Changes take effect on next `/mvp-planner:plan` invocation
- Delete this file to revert to defaults
- This file is ignored by git (listed in .gitignore)
