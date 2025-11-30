# dev-marketplace

Development workflow plugins for Claude Code.

## Plugins

### iterate

TDD-enforced iterative development workflow with automatic ROADMAP.md management.

**Workflow**: `Explore → Plan → [Red → Green → Refactor] → Verify → Commit`

**Features**:
- Interactive planning that produces a living ROADMAP.md
- Hooks automatically update roadmap as you work
- TDD enforcement with configurable strictness (strict/warn/off)
- Integration with feature-dev for seamless development handoff
- Specialized agents for each workflow phase

**Command**: `/iterate`

## Installation

```bash
claude code plugin install dev-marketplace
```

## License

MIT
