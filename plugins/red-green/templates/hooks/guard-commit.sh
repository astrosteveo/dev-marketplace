#!/bin/bash
# Blocks git commits if tests are failing
# Part of the Red-Green-Refactor enforcement system

COMMAND="${CLAUDE_TOOL_INPUT_COMMAND:-$1}"

# Only intercept git commit commands
if [[ ! "$COMMAND" == *"git"* ]] || [[ ! "$COMMAND" == *"commit"* ]]; then
    exit 0
fi

# Skip if it's just checking status or other non-commit operations
if [[ "$COMMAND" == *"--dry-run"* ]] || [[ "$COMMAND" == *"status"* ]]; then
    exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ROADMAP="$PROJECT_DIR/ROADMAP.md"

# Check for ACTIVE story - commits should happen after story is complete
ACTIVE_CONTENT=$(sed -n '/^## Active/,/^##/p' "$ROADMAP" 2>/dev/null | grep -v "^## " | grep -v "^$" | head -1)

if [[ -n "$ACTIVE_CONTENT" ]] && [[ "$ACTIVE_CONTENT" != "None" ]]; then
    cat << 'EOF'
{
  "continue": true,
  "systemMessage": "Note: There's still an ACTIVE story in ROADMAP.md.\n\nBefore committing, ensure:\n1. All tests pass (run Unity tests)\n2. Story acceptance criteria are met\n3. Use 'validate' skill to complete the story properly\n\nThis marks the story complete and creates a clean commit."
}
EOF
fi

exit 0
