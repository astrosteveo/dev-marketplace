#!/bin/bash
# Reminds to review tests after writing test files
# Part of the Red-Green-Refactor enforcement system

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-$1}"

# Only trigger for test files
if [[ "$FILE_PATH" == *"/Tests/"* ]] || [[ "$FILE_PATH" == *"Tests.cs" ]]; then
    cat << 'EOF'
{
  "continue": true,
  "systemMessage": "Test file modified. Before implementing (Green phase):\n\n1. Run the test - verify it FAILS (Red)\n2. Consider using 'test-reviewer' skill to verify assertions are meaningful\n3. Only then proceed to implementation\n\nSuperficial tests that pass without real validation waste time later."
}
EOF
fi

exit 0
