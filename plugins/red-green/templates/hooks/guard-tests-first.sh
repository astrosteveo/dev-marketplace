#!/bin/bash
# Warns when writing implementation without corresponding tests
# Part of the Red-Green-Refactor enforcement system

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-$1}"

# Skip if not a .cs file
if [[ ! "$FILE_PATH" == *.cs ]]; then
    exit 0
fi

# Skip test files
if [[ "$FILE_PATH" == *"/Tests/"* ]] || [[ "$FILE_PATH" == *"Tests.cs" ]]; then
    exit 0
fi

# Skip if not implementation code
if [[ ! "$FILE_PATH" == *"Assets/Scripts/"* ]]; then
    exit 0
fi

# Extract the class name from the file path
FILENAME=$(basename "$FILE_PATH" .cs)
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Look for corresponding test file
TEST_FILE=$(find "$PROJECT_DIR/Assets/Tests" -name "${FILENAME}Tests.cs" 2>/dev/null | head -1)

if [[ -z "$TEST_FILE" ]]; then
    cat << 'EOF'
{
  "continue": true,
  "systemMessage": "Warning: No test file found for this implementation.\n\nRed-Green workflow requires tests FIRST:\n1. Write failing test (Red phase)\n2. Then write minimal implementation (Green phase)\n\nConsider using 'test-writer' skill before implementing."
}
EOF
fi

exit 0
