#!/bin/bash
# Reminds to review tests after writing test files
# Part of the Red-Green-Refactor enforcement system

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-$1}"
FILENAME=$(basename "$FILE_PATH")
DIRPATH=$(dirname "$FILE_PATH")

# Check if this is a test file by directory patterns
IS_TEST=false
if [[ "$DIRPATH" == *"/test/"* ]] || [[ "$DIRPATH" == *"/tests/"* ]] || \
   [[ "$DIRPATH" == *"/spec/"* ]] || [[ "$DIRPATH" == *"/__tests__/"* ]] || \
   [[ "$DIRPATH" == *"/Test/"* ]] || [[ "$DIRPATH" == *"/Tests/"* ]]; then
    IS_TEST=true
fi

# Check if this is a test file by filename patterns
if [[ "$FILENAME" =~ ^test[_\.].*$ ]] || [[ "$FILENAME" =~ .*[_\.]test\..*$ ]] || \
   [[ "$FILENAME" =~ .*[_\.]spec\..*$ ]] || [[ "$FILENAME" =~ .*Tests\..*$ ]] || \
   [[ "$FILENAME" =~ .*Test\..*$ ]] || [[ "$FILENAME" =~ .*_test\..*$ ]] || \
   [[ "$FILENAME" =~ ^spec[_\.].*$ ]]; then
    IS_TEST=true
fi

if [[ "$IS_TEST" == true ]]; then
    cat << 'EOF'
{
  "continue": true,
  "systemMessage": "Test file modified. Before implementing (Green phase):\n\n1. Run the test - verify it FAILS (Red)\n2. Verify assertions are meaningful\n3. Only then proceed to implementation\n\nSuperficial tests that pass without real validation waste time later."
}
EOF
fi

exit 0
