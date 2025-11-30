# Feature Dev Plus

Enhanced feature development workflow plugin that improves upon the standard `feature-dev` plugin with discovery mode, spec-driven development, intelligent state persistence, and seamless session resumption.

## Features

### 🎯 Flexible Entry Points
- **With argument**: Jump directly into feature development for clear requirements
- **Without argument**: Guided discovery mode helps articulate vague ideas

### 📋 Spec-Driven Workflow
- Automatic spec generation in `docs/specs/`
- Comprehensive planning with implementation roadmap
- Test strategy for testable vs non-testable logic

### 💾 State Persistence
- Survives `/new` and `/clear` commands
- Detailed progress tracking in `.feature-state.json`
- Context-aware resumption picks up exactly where you left off

### 🧠 Context Management
- Proactive context limit detection
- Graceful pause before compaction
- Seamless resume with full context restoration

### ⚡ Token Efficient
- Aggressive subagent usage (separate token budgets)
- Lean skills with progressive disclosure
- Targeted codebase exploration
- Smart model selection (Haiku for simple tasks, Sonnet for complex reasoning)

## Installation

### From Dev Marketplace

```bash
# Plugin is in the dev-marketplace, should auto-load
cc --marketplace dev-marketplace
```

### Manual Installation

```bash
# Copy to your plugins directory
cp -r plugins/feature-dev-plus ~/.claude/plugins/

# Or use directly
cc --plugin-dir /path/to/feature-dev-plus
```

## Usage

### Start New Feature (with clear idea)

```bash
/feature-dev-plus "Add OAuth2 social authentication"
```

This will:
1. Create spec in `docs/specs/oauth-authentication.md`
2. Generate implementation plan
3. Pause for your approval
4. Implement autonomously when approved

### Start New Feature (need help clarifying)

```bash
/feature-dev-plus
```

This will:
1. Launch discovery mode
2. Ask targeted questions about your idea
3. Help articulate requirements
4. Create spec from your answers
5. Continue to planning and implementation

### Resume Paused Feature

```bash
/feature-dev-plus
```

If a `.feature-state.json` exists, you'll be prompted:
```
📋 Found paused feature: user-authentication

Progress:
✓ Discovery, spec, and plan phases completed
⚠️ Implementation in progress (task 2 of 5)

Resume from where you left off? [Yes/No]
```

### Context Limit Handling

When approaching context limits:
```
⚠️ Context limit approaching. Progress saved to .feature-state.json

Current phase: implementation (in_progress)
Last completed: OAuth provider integration
In progress: Token storage mechanism

Please run /clear to continue with fresh context.
When ready, run /feature-dev-plus to resume.
```

## Workflow Phases

1. **Discovery** (if no argument) - Guided requirement gathering
2. **Spec** - Comprehensive specification writing
3. **Plan** - Implementation roadmap creation
4. **👤 User Approval** - Review and approve plan
5. **Implementation** - Autonomous code generation
6. **Test** - Test creation for testable logic
7. **Commit** - Git commit with descriptive message

## Configuration

Create `.claude/feature-dev-plus.local.md` to customize:

```markdown
---
specDirectory: "docs/specs"
testDirectory: "tests"
alwaysCreateTests: false
stateFilePath: ".feature-state.json"
defaultWorkflow: "spec-driven"
---

# Feature Dev Plus Settings

Custom settings for your project.
```

### Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `specDirectory` | `"docs/specs"` | Where to create spec files |
| `testDirectory` | `"tests"` | Where to create test files |
| `alwaysCreateTests` | `false` | Generate tests even for non-testable features |
| `stateFilePath` | `".feature-state.json"` | State file location |
| `defaultWorkflow` | `"spec-driven"` | Workflow methodology |

## State File Structure

`.feature-state.json` tracks all progress:

```json
{
  "currentFeature": {
    "name": "user-authentication",
    "description": "Add OAuth2 authentication system",
    "phase": "implementation",
    "specFile": "docs/specs/user-authentication.md",
    "testFile": "tests/unit/auth.test.ts",
    "startedAt": "2025-11-29T10:00:00Z",
    "updatedAt": "2025-11-29T14:30:00Z"
  },
  "phases": {
    "discovery": "completed",
    "spec": "completed",
    "plan": "completed",
    "implementation": "in_progress",
    "test": "pending",
    "commit": "pending"
  },
  "tasks": [
    {"id": 1, "description": "Implement OAuth provider", "status": "completed"},
    {"id": 2, "description": "Add token storage", "status": "in_progress"}
  ],
  "resumeContext": {
    "lastAction": "Created OAuth provider in src/auth/oauth.ts:45",
    "nextSteps": ["Complete token storage", "Add session management"],
    "filesInProgress": ["src/auth/token-store.ts"]
  }
}
```

## Token Efficiency

This plugin is optimized for long-running development:

- **Subagents**: Heavy work offloaded to separate token budgets
- **Lean Skills**: Core guidance only, details in reference files
- **Targeted Reads**: Grep/Glob instead of reading entire files
- **State Files**: Important data persisted, not kept in context
- **Model Selection**: Haiku for simple tasks, Sonnet for complex reasoning
- **Parallel Operations**: Batch operations when possible

## Components

### Command
- `/feature-dev-plus [feature-description]` - Main entry point

### Agents
- `discovery-guide` (Haiku) - Guided requirement gathering
- `spec-writer` (Sonnet) - Comprehensive spec generation
- `code-architect` (Sonnet) - Implementation planning
- `test-designer` (Haiku) - Test structure generation
- `state-manager` (Haiku) - State file management

### Skills
- `spec-writing` - Effective spec patterns
- `test-driven-development` - TDD best practices
- `workflow-orchestration` - State and phase management

### Hooks
- `SessionStart` - Check for paused features
- `SubagentStop` - Update state after agent completion
- `PreCompact` - Save state before context compaction

## Troubleshooting

### Plugin not loading
```bash
# Verify plugin structure
ls -la plugins/feature-dev-plus/.claude-plugin/plugin.json

# Check Claude Code recognizes it
cc --help | grep feature-dev-plus
```

### State file issues
```bash
# View current state
cat .feature-state.json | jq

# Reset state (caution: loses progress)
rm .feature-state.json
```

### Resume not working
- Ensure `.feature-state.json` exists in project root
- Check `currentFeature` field is populated
- Verify `phase` is not "completed"

## Examples

### Example 1: Game Feature

```bash
/feature-dev-plus "Add player inventory system"
```

**Output:**
- Spec: `docs/specs/player-inventory.md`
- Plan: Implementation roadmap
- Tests: Skips UI/visual, tests inventory logic only
- Implementation: Autonomous creation of inventory classes

### Example 2: API Endpoint

```bash
/feature-dev-plus "Add REST endpoint for user profiles"
```

**Output:**
- Spec: API contract, validation rules
- Plan: Route, controller, service, tests
- Tests: Full test coverage for business logic
- Implementation: Complete endpoint with error handling

### Example 3: Vague Idea

```bash
/feature-dev-plus
```

**Discovery Questions:**
1. What problem are you trying to solve?
2. Who will use this feature?
3. What should the outcome be?
4. Any constraints or requirements?

**Output:**
- Structured spec from answers
- Clear implementation plan
- Testable acceptance criteria

## Credits

Inspired by the original [feature-dev](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) plugin, with enhancements for:
- Discovery mode
- State persistence
- Context management
- Token efficiency

## License

MIT
