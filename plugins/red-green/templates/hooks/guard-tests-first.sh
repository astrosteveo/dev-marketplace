#!/bin/bash
# Warns when writing implementation without corresponding tests
# Part of the Red-Green-Refactor enforcement system

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-$1}"

# Source code extensions to check
SOURCE_EXTENSIONS="cs|js|ts|jsx|tsx|py|go|rs|java|cpp|c|rb|php|swift|kt|scala|ex|exs|clj|hs|ml|fs|vue|svelte"

# Skip non-source files
if [[ ! "$FILE_PATH" =~ \.($SOURCE_EXTENSIONS)$ ]]; then
    exit 0
fi

# Get filename and directory
FILENAME=$(basename "$FILE_PATH")
DIRPATH=$(dirname "$FILE_PATH")

# Skip test files - check directory patterns
if [[ "$DIRPATH" == *"/test/"* ]] || [[ "$DIRPATH" == *"/tests/"* ]] || \
   [[ "$DIRPATH" == *"/spec/"* ]] || [[ "$DIRPATH" == *"/__tests__/"* ]] || \
   [[ "$DIRPATH" == *"/Test/"* ]] || [[ "$DIRPATH" == *"/Tests/"* ]]; then
    exit 0
fi

# Skip test files - check filename patterns
if [[ "$FILENAME" =~ ^test[_\.].*$ ]] || [[ "$FILENAME" =~ .*[_\.]test\..*$ ]] || \
   [[ "$FILENAME" =~ .*[_\.]spec\..*$ ]] || [[ "$FILENAME" =~ .*Tests\..*$ ]] || \
   [[ "$FILENAME" =~ .*Test\..*$ ]] || [[ "$FILENAME" =~ .*_test\..*$ ]] || \
   [[ "$FILENAME" =~ ^spec[_\.].*$ ]]; then
    exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Extract base name without extension
BASENAME="${FILENAME%.*}"
EXT="${FILENAME##*.}"

# Look for corresponding test files with common patterns
TEST_FOUND=false
for test_dir in "test" "tests" "spec" "__tests__" "Test" "Tests"; do
    if [[ -d "$PROJECT_DIR/$test_dir" ]]; then
        # Check various test naming conventions
        for pattern in "${BASENAME}Test" "${BASENAME}Tests" "${BASENAME}.test" "${BASENAME}.spec" "${BASENAME}_test" "test_${BASENAME}"; do
            if find "$PROJECT_DIR/$test_dir" -name "${pattern}.*" 2>/dev/null | grep -q .; then
                TEST_FOUND=true
                break 2
            fi
        done
    fi
done

# Also check for test file in same directory or sibling test directory
if [[ "$TEST_FOUND" == false ]]; then
    for pattern in "${BASENAME}Test" "${BASENAME}Tests" "${BASENAME}.test" "${BASENAME}.spec" "${BASENAME}_test" "test_${BASENAME}"; do
        if find "$DIRPATH" -maxdepth 2 -name "${pattern}.*" 2>/dev/null | grep -q .; then
            TEST_FOUND=true
            break
        fi
    done
fi

if [[ "$TEST_FOUND" == false ]]; then
    cat << 'EOF'
{
  "continue": true,
  "systemMessage": "Warning: No test file found for this implementation.\n\nRed-Green workflow requires tests FIRST:\n1. Write failing test (Red phase)\n2. Then write minimal implementation (Green phase)\n\nConsider writing tests before implementing."
}
EOF
fi

exit 0
