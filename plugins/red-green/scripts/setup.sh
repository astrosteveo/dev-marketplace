#!/usr/bin/env bash
set -euo pipefail

# Red-Green Setup - Enables "plan before code" enforcement for this project

# Find plugin directory (this script lives in plugins/red-green/scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES="$PLUGIN_DIR/templates"

# Target is current working directory
PROJECT="$PWD"
CLAUDE_DIR="$PROJECT/.claude"

echo "Red-Green TDD Setup"
echo "==================="
echo ""

# Verify templates exist
if [[ ! -d "$TEMPLATES" ]]; then
    echo "Error: Templates not found at $TEMPLATES"
    exit 1
fi

# Create .claude directory
mkdir -p "$CLAUDE_DIR/hooks"

# Copy hook
cp "$TEMPLATES/hooks/require-plan.sh" "$CLAUDE_DIR/hooks/"
chmod +x "$CLAUDE_DIR/hooks/require-plan.sh"

# Copy or merge settings.local.json
if [[ -f "$CLAUDE_DIR/settings.local.json" ]]; then
    echo "Warning: .claude/settings.local.json already exists"
    echo "You may need to manually merge the hooks configuration."
    echo ""
    echo "Add this to your existing hooks config:"
    cat "$TEMPLATES/settings.local.json"
    echo ""
else
    cp "$TEMPLATES/settings.local.json" "$CLAUDE_DIR/"
fi

# Create ROADMAP.md if it doesn't exist
if [[ ! -f "$PROJECT/ROADMAP.md" ]]; then
    cp "$TEMPLATES/ROADMAP.md" "$PROJECT/"
    echo "Created: ROADMAP.md"
fi

# Create CLAUDE.md if it doesn't exist
if [[ ! -f "$PROJECT/CLAUDE.md" ]]; then
    cp "$TEMPLATES/CLAUDE.md" "$PROJECT/"
    echo "Created: CLAUDE.md"
fi

echo ""
echo "Done! Red-Green is now active for this project."
echo ""
echo "How it works:"
echo "  - Claude will be blocked from writing code until ROADMAP.md has an active story"
echo "  - Test files are always allowed (that's the 'red' in red-green)"
echo ""
echo "To start:"
echo "  1. Discuss what you want to build"
echo "  2. Add a story to '## Active' in ROADMAP.md"
echo "  3. Write tests first, then implement"
