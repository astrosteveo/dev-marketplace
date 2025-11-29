---
description: Configure which question types require AskUserQuestion
allowed-tools: Read, Write, AskUserQuestion
---

Configure guided-input plugin settings by asking the user which question types should enforce the use of AskUserQuestion tool.

## Instructions

1. First, check if a configuration file exists at `.claude/guided-input.local.md` in the current project directory.

2. If it exists, read the current settings and present them to the user.

3. Use AskUserQuestion to ask the user which question types should require structured input:

```javascript
{
  question: "Which question types should require the AskUserQuestion tool?",
  header: "Question types",
  options: [
    { label: "Clarification", description: "Questions that clarify requirements or understanding" },
    { label: "Decision", description: "Questions asking the user to choose between options" },
    { label: "Confirmation", description: "Questions seeking approval before proceeding" },
    { label: "All types", description: "Enforce for all questions requiring user input" }
  ],
  multiSelect: true
}
```

4. Based on the user's response, create or update `.claude/guided-input.local.md` with the following format:

```markdown
---
enforceTypes:
  clarification: true
  decision: true
  confirmation: true
---

# Guided Input Configuration

This file configures which question types require the AskUserQuestion tool.
```

5. Confirm the settings were saved by showing the user their current configuration.

## Notes

- The `.claude/guided-input.local.md` file should be added to `.gitignore` as it contains user preferences
- If the user selects "All types", set all three boolean values to true
- Default behavior (no config file) is to enforce for all question types
