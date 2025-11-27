#!/usr/bin/env bash
set -euo pipefail

# Red-Green TDD Framework Setup Script
# Copies templates to the current project's .claude/ directory

# Find where this script lives, then go up one level to the plugin root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$PLUGIN_DIR/templates"

TARGET_DIR="${PWD}/.claude"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Red-Green TDD Framework Setup${NC}"
echo "==============================="
echo ""

# Check if templates exist
if [[ ! -d "$TEMPLATE_DIR" ]]; then
    echo -e "${RED}Error: Template directory not found at ${TEMPLATE_DIR}${NC}"
    echo "Make sure red-green is installed via the marketplace."
    exit 1
fi

# Check if .claude already exists
if [[ -d "$TARGET_DIR" ]]; then
    echo -e "${YELLOW}Warning: .claude/ directory already exists${NC}"
    read -p "Merge templates? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# Create target directory
mkdir -p "$TARGET_DIR"

# Copy templates
echo "Copying templates..."
cp -rn "$TEMPLATE_DIR"/* "$TARGET_DIR"/ 2>/dev/null || cp -r "$TEMPLATE_DIR"/* "$TARGET_DIR"/

echo ""
echo -e "${GREEN}Red-Green TDD Framework installed!${NC}"
echo ""
echo "Created:"
find "$TARGET_DIR" -type f -name "*.md" -o -name "*.json" | while read -r file; do
    echo "  - ${file#$PWD/}"
done

echo ""
echo "Usage:"
echo "  1. 'Research...'  → Explore before planning"
echo "  2. 'Plan...'      → Break into stories"
echo "  3. 'Implement...' → Red → Green → Refactor"
echo "  4. 'Validate...'  → Verify and commit"
