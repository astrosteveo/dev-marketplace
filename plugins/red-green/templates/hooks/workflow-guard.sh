#!/bin/bash
# Master workflow guard - provides context-aware guidance
# Part of the Red-Green-Refactor enforcement system

# This hook runs on user prompt submission to guide workflow

PROMPT="${CLAUDE_USER_PROMPT:-$1}"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ROADMAP="$PROJECT_DIR/ROADMAP.md"

# Convert to lowercase for matching
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')

# Check current state
ACTIVE_CONTENT=""
if [[ -f "$ROADMAP" ]]; then
    ACTIVE_CONTENT=$(sed -n '/^## Active/,/^##/p' "$ROADMAP" | grep -v "^## " | grep -v "^$" | head -1)
fi

HAS_ACTIVE_STORY=false
if [[ -n "$ACTIVE_CONTENT" ]] && [[ "$ACTIVE_CONTENT" != "None" ]]; then
    HAS_ACTIVE_STORY=true
fi

# Detect intent from prompt
WANTS_CODE=false
if [[ "$PROMPT_LOWER" == *"implement"* ]] || \
   [[ "$PROMPT_LOWER" == *"write code"* ]] || \
   [[ "$PROMPT_LOWER" == *"add a"* ]] || \
   [[ "$PROMPT_LOWER" == *"create a"* ]] || \
   [[ "$PROMPT_LOWER" == *"build"* ]] || \
   [[ "$PROMPT_LOWER" == *"code"* ]]; then
    WANTS_CODE=true
fi

# If user wants to code but no active story, guide them
if [[ "$WANTS_CODE" == true ]] && [[ "$HAS_ACTIVE_STORY" == false ]]; then
    cat << 'EOF'
{
  "continue": true,
  "systemMessage": "Workflow Check: You want to write code but there's no ACTIVE story.\n\nRed-Green-Refactor workflow:\n1. Research - Understand the problem (use 'research' skill)\n2. Plan - Break into stories, add to ROADMAP.md (use 'plan' skill)\n3. Red - Write failing test (use 'test-writer' skill)\n4. Green - Minimal implementation (use 'implement' skill)\n5. Refactor - Improve code (use 'refactor' skill)\n6. Validate - Verify and commit (use 'validate' skill)\n\nStart with 'research' or 'plan' to create an ACTIVE story first."
}
EOF
fi

exit 0
