# Dev Marketplace

A Claude Code plugin marketplace for development and testing.

## Installation

Add this marketplace to Claude Code:

```
/plugin marketplace add your-username/dev-marketplace
```

Or for local development:

```
/plugin marketplace add /path/to/dev-marketplace
```

## Available Plugins

| Plugin | Description |
|--------|-------------|
| `example-plugin` | An example plugin demonstrating marketplace structure |

## Installing Plugins

After adding the marketplace, install plugins with:

```
/plugin install example-plugin@dev-marketplace
```

## Marketplace Structure

```
dev-marketplace/
├── .claude-plugin/
│   └── marketplace.json     # Marketplace manifest
├── plugins/
│   └── example-plugin/
│       ├── .claude-plugin/
│       │   └── plugin.json  # Plugin manifest
│       ├── commands/        # Slash commands
│       │   └── hello.md
│       ├── skills/          # Agent skills
│       │   └── greeting/
│       │       └── SKILL.md
│       ├── agents/          # Custom agents
│       │   └── helper.md
│       └── hooks/           # Event hooks
│           └── hooks.json
└── README.md
```

## Creating New Plugins

1. Create a new directory under `plugins/`
2. Add `.claude-plugin/plugin.json` with plugin metadata
3. Add your commands, skills, agents, or hooks
4. Register the plugin in `.claude-plugin/marketplace.json`

## Plugin Components

### Commands (`commands/*.md`)

Custom slash commands with frontmatter description:

```markdown
---
description: Brief description of the command
---

# Command Name

Instructions for Claude when command is invoked.
```

### Skills (`skills/*/SKILL.md`)

Agent skills that Claude uses autonomously based on context.

### Agents (`agents/*.md`)

Specialized assistant configurations for specific tasks.

### Hooks (`hooks/hooks.json`)

Event-driven automation handlers.

## Management Commands

- `/plugin marketplace list` - List installed marketplaces
- `/plugin marketplace update dev-marketplace` - Update marketplace
- `/plugin marketplace remove dev-marketplace` - Remove marketplace
- `/plugin list` - List installed plugins
- `/plugin enable/disable <plugin>` - Toggle plugins

## License

MIT
