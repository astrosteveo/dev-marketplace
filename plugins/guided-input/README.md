# Guided Input Plugin

Enforces structured question-asking using the `AskUserQuestion` tool with prefilled options to reduce cognitive load and help users who may feel overwhelmed or unsure how to articulate their thoughts.

## Features

- **Stop Hook**: Blocks Claude from asking questions without using `AskUserQuestion`
- **Skill**: Guidance on crafting 3-4 thoughtful prefilled options
- **Command**: `/guided-input:configure` to customize which question types enforce this behavior

## How It Works

When Claude attempts to complete a response that contains questions directed at the user (like "What would you prefer?" or "Should I proceed?"), the Stop hook checks if the `AskUserQuestion` tool was used. If not, the response is blocked and Claude is prompted to reformulate using structured options.

### Question Types

The plugin recognizes three types of questions:

1. **Clarification Questions**: When Claude needs to understand requirements better
2. **Decision Questions**: When Claude offers choices between approaches
3. **Confirmation Questions**: When Claude seeks approval to proceed

## Installation

Copy this plugin to your Claude Code plugins directory or reference it via the marketplace.

## Configuration

Run `/guided-input:configure` to customize which question types require `AskUserQuestion`. Settings are stored in `.claude/guided-input.local.md`.

### Default Behavior

By default, all question types require the `AskUserQuestion` tool.

### Configuration File Format

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

## Usage Example

Instead of Claude asking:

> "What authentication method would you prefer?"

Claude will use the AskUserQuestion tool with options like:

- **JWT tokens** - Stateless, scalable, good for APIs
- **Session-based** - Server-side state, simpler setup
- **OAuth 2.0** - Third-party auth, social logins

Users can select a prefilled option or choose "Other" to provide custom input.

## Components

| Component | Location | Purpose |
|-----------|----------|---------|
| Hook | `hooks/hooks.json` | Stop event to enforce AskUserQuestion usage |
| Skill | `skills/guided-input/SKILL.md` | Guidance on crafting good options |
| Command | `commands/configure.md` | Configure enforcement settings |

## Best Practices

The skill teaches Claude to:

1. Provide 3-4 options per question
2. Write practical descriptions explaining trade-offs
3. Use short headers (max 12 characters)
4. Consider `multiSelect` for non-exclusive options
5. Group related questions (max 4 per call)
