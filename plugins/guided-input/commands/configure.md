---
description: Configure which question types require AskUserQuestion
allowed-tools: Read, Write, AskUserQuestion
---

Configure guided-input plugin settings. By default, **all question types require AskUserQuestion**. This command lets you disable enforcement for specific types if needed.

## Instructions

1. First, check if a configuration file exists at `.claude/guided-input.local.md` in the current project directory.

2. If it exists, read the current settings and show which types are currently exempt.

3. Use AskUserQuestion to ask the user which question types to EXEMPT from enforcement:

```javascript
{
  question: "By default, all questions require AskUserQuestion. Which types would you like to EXEMPT from this requirement?",
  header: "Exempt types",
  options: [
    { label: "None (keep all)", description: "Keep enforcing for all question types (recommended)" },
    { label: "Clarification", description: "Allow plain-text clarification questions" },
    { label: "Decision", description: "Allow plain-text decision questions" },
    { label: "Confirmation", description: "Allow plain-text confirmation questions" }
  ],
  multiSelect: true
}
```

4. Based on the user's response, create or update `.claude/guided-input.local.md` with the following format:

```markdown
---
# true = enforce AskUserQuestion, false = exempt from enforcement
enforceTypes:
  clarification: true
  decision: true
  confirmation: true
---

# Guided Input Configuration

All question types require AskUserQuestion by default.
Set a type to `false` to exempt it from enforcement.
```

5. Set the selected types to `false` in the config (exempted types).

6. Confirm the settings were saved:
   - If no exemptions: "All question types will require AskUserQuestion (default behavior)."
   - If exemptions: "Exempted {types} from AskUserQuestion requirement. All other types still enforced."

## Notes

- The `.claude/guided-input.local.md` file should be added to `.gitignore` as it contains user preferences
- If user selects "None (keep all)", set all three boolean values to true
- Default behavior (no config file) = enforce for ALL question types
- This is an opt-OUT system: you only need to configure if you want to disable enforcement for certain types
