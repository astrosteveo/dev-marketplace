---
description: Initialize TDD framework in the current project
---

# TDD Framework Initialization

Initialize a Test-Driven Development framework in the current project by scaffolding the `.claude/` directory with TDD-specific skills, commands, and hooks.

## Your Task

1. **Detect the project context**:
   - Identify the programming language(s) used (check for package.json, requirements.txt, go.mod, Cargo.toml, etc.)
   - Identify the existing test framework if any (Jest, pytest, Go testing, etc.)
   - Note the project structure

2. **Create the `.claude/` directory structure**:
   ```
   .claude/
   ├── settings.json
   ├── commands/
   │   ├── test.md
   │   └── coverage.md
   ├── skills/
   │   ├── red/
   │   │   └── SKILL.md
   │   ├── green/
   │   │   └── SKILL.md
   │   └── refactor/
   │       └── SKILL.md
   └── CLAUDE.md
   ```

3. **Create `.claude/CLAUDE.md`** with TDD workflow instructions:
   - Explain the Red-Green-Refactor cycle
   - Set expectations that tests come before implementation
   - Define the natural language triggers for each phase

4. **Create the Red skill** (`.claude/skills/red/SKILL.md`):
   - Activated when user says "write tests for...", "test...", or "red phase"
   - Writes failing tests first
   - Tests should be comprehensive but focused
   - Must verify tests actually fail before proceeding

5. **Create the Green skill** (`.claude/skills/green/SKILL.md`):
   - Activated when user says "implement...", "make it pass", or "green phase"
   - Writes minimal code to make tests pass
   - No over-engineering - just enough to pass
   - Run tests to verify they pass

6. **Create the Refactor skill** (`.claude/skills/refactor/SKILL.md`):
   - Activated when user says "refactor...", "clean up", or "refactor phase"
   - Improve code quality without changing behavior
   - Tests must still pass after refactoring

7. **Create `/test` command** (`.claude/commands/test.md`):
   - Runs the project's test suite
   - Reports pass/fail status clearly

8. **Create `/coverage` command** (`.claude/commands/coverage.md`):
   - Runs tests with coverage reporting
   - Highlights untested code paths

9. **Create `.claude/settings.json`** if needed for any project-specific configuration

## Adaptation Guidelines

- Adapt test commands to the detected framework (npm test, pytest, go test, cargo test, etc.)
- Use idioms appropriate to the language
- If no test framework exists, suggest one appropriate for the project

## Output

After scaffolding, provide a brief summary:
- What was created
- How to use the TDD workflow
- Example: "Say 'write tests for user authentication' to start the red phase"
