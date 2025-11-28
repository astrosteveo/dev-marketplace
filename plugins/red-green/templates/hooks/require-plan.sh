#!/usr/bin/env bash
# Blocks writing implementation code until a plan exists
# Part of red-green plugin - enforces "plan before code"

set -euo pipefail

FILE_PATH="${1:-}"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ROADMAP="$PROJECT_DIR/ROADMAP.md"

# Source extensions that count as "implementation code"
SOURCE_EXT="cs|js|ts|jsx|tsx|py|go|rs|java|cpp|c|h|hpp|rb|php|swift|kt|scala|vue|svelte"

# Skip if not a source file
if [[ ! "$FILE_PATH" =~ \.($SOURCE_EXT)$ ]]; then
    exit 0
fi

# Skip test files (always allowed - that's the "red" in red-green)
FILENAME=$(basename "$FILE_PATH")
DIRPATH=$(dirname "$FILE_PATH")

# Test directory patterns
if [[ "$DIRPATH" =~ /(tests?|spec|__tests__)/ ]]; then
    exit 0
fi

# Test filename patterns
if [[ "$FILENAME" =~ (test|spec|Test|_test)\. ]]; then
    exit 0
fi

# Check 1: ROADMAP.md must exist
if [[ ! -f "$ROADMAP" ]]; then
    cat << 'EOF'
{
  "decision": "block",
  "reason": "No ROADMAP.md found.\n\nBefore writing code, create a plan:\n1. Create ROADMAP.md in project root\n2. Add an '## Active' section with your current story\n\nExample ROADMAP.md:\n```\n## Active\nImplement user login validation\n\n## Backlog\n- Add password reset\n- Add 2FA\n```"
}
EOF
    exit 0
fi

# Check 2: Must have an active story
ACTIVE=$(sed -n '/^## Active/,/^##/p' "$ROADMAP" 2>/dev/null | grep -v "^##" | grep -v "^$" | head -1 || true)

if [[ -z "$ACTIVE" || "$ACTIVE" == "None" || "$ACTIVE" == "-" ]]; then
    cat << 'EOF'
{
  "decision": "block",
  "reason": "No active story in ROADMAP.md.\n\nBefore writing code:\n1. Open ROADMAP.md\n2. Add a story under '## Active'\n\nThis ensures we've discussed what we're building before coding."
}
EOF
    exit 0
fi

# All checks passed - allow the write
exit 0
