---
specDirectory: "docs/specs"
testDirectory: "tests"
alwaysCreateTests: false
stateFilePath: ".feature-state.json"
defaultWorkflow: "spec-driven"
---

# Feature Dev Plus Settings

This file configures the feature-dev-plus plugin for your project.

To use these settings, copy this file to `.claude/feature-dev-plus.local.md` in your project root.

## Configuration Options

### specDirectory

**Type**: `string`
**Default**: `"docs/specs"`

Where to create feature specification files.

**Examples**:
- `"docs/specs"` - Standard location
- `"specs"` - Top-level specs directory
- `"docs/features"` - Alternative naming

### testDirectory

**Type**: `string`
**Default**: `"tests"`

Where to create test files.

**Examples**:
- `"tests"` - Standard location
- `"test"` - Singular form
- `"__tests__"` - Jest convention
- `"src/__tests__"` - Colocated with source

### alwaysCreateTests

**Type**: `boolean`
**Default**: `false`

Whether to always create test files, even for non-testable features (visual/UI).

**Recommended**: Keep as `false` to skip tests for purely visual features.

### stateFilePath

**Type**: `string`
**Default**: `".feature-state.json"`

Location of the state file that tracks feature development progress.

**Examples**:
- `".feature-state.json"` - Project root (default)
- `".claude/feature-state.json"` - Inside .claude directory
- `"state/current-feature.json"` - Custom location

**Note**: If you change this, make sure to update your `.gitignore`.

### defaultWorkflow

**Type**: `"spec-driven" | "test-driven"`
**Default**: `"spec-driven"`

The default workflow methodology to use.

**Options**:
- `"spec-driven"`: Write spec first, then implement, then add tests for testable logic
- `"test-driven"`: Write tests first, then implement to pass tests (classic TDD)

**Note**: The plugin automatically skips tests for non-testable features regardless of this setting.

## Example Configurations

### Minimal Configuration (Use Defaults)

```markdown
---
---

# Feature Dev Plus Settings

Using all default settings.
```

### Frontend React Project

```markdown
---
specDirectory: "docs/features"
testDirectory: "src/__tests__"
alwaysCreateTests: false
stateFilePath: ".feature-state.json"
defaultWorkflow: "spec-driven"
---

# Feature Dev Plus Settings

Configured for React project with Jest tests colocated in src/__tests__.
```

### Backend API Project

```markdown
---
specDirectory: "docs/api-specs"
testDirectory: "tests"
alwaysCreateTests: true
stateFilePath: ".feature-state.json"
defaultWorkflow: "test-driven"
---

# Feature Dev Plus Settings

Configured for backend API with comprehensive test coverage.
Always create tests since most backend logic is testable.
```

### Game Development Project

```markdown
---
specDirectory: "design-docs"
testDirectory: "tests"
alwaysCreateTests: false
stateFilePath: ".feature-state.json"
defaultWorkflow: "spec-driven"
---

# Feature Dev Plus Settings

Configured for game development.
Tests are created only for game logic (physics, AI, etc.),
not for rendering or visual elements.
```

## Project-Specific Notes

You can add project-specific notes and guidelines below the frontmatter:

```markdown
---
specDirectory: "docs/specs"
testDirectory: "tests"
---

# Feature Dev Plus Settings

## Project Guidelines

- All features must have security review section in spec
- Include performance benchmarks for data-intensive features
- Reference existing API patterns in specs

## Team Conventions

- Specs reviewed by product manager before implementation
- Tests required for all business logic
- E2E tests optional, added on case-by-case basis
```

## Troubleshooting

### Settings Not Loading

1. Ensure file is at `.claude/feature-dev-plus.local.md` (exact path)
2. Check YAML frontmatter syntax (must have `---` delimiters)
3. Verify field names match exactly (case-sensitive)
4. Look for YAML syntax errors (quote strings with special chars)

### Wrong Directories Used

If the plugin creates files in wrong directories:
1. Check your settings file path
2. Verify directory paths in settings (relative to project root)
3. Ensure directories exist (plugin may not create missing dirs)

### State File Issues

If you want to change state file location:
1. Update `stateFilePath` in settings
2. Update your `.gitignore` to ignore new location
3. If changing mid-feature, manually move existing `.feature-state.json`
