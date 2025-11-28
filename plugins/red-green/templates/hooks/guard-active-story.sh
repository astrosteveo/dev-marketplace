#!/bin/bash
# Blocks writing implementation code without an ACTIVE story in ROADMAP.md
# Part of the Red-Green-Refactor enforcement system
# Use --force flag to override (for non-testable code like visual/UI work)

# Tool input comes via environment or we parse from context
FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-$1}"

# Check for --force flag to override the guard
if [[ "$*" == *"--force"* ]] || [[ "${CLAUDE_HOOK_FORCE:-}" == "true" ]]; then
    exit 0
fi

# Source code extensions to check (implementation files)
SOURCE_EXTENSIONS="cs|js|ts|jsx|tsx|py|go|rs|java|cpp|c|h|hpp|rb|php|swift|kt|scala|ex|exs|clj|hs|ml|fs|vue|svelte"

# Skip non-source files (configs, docs, etc.)
if [[ ! "$FILE_PATH" =~ \.($SOURCE_EXTENSIONS)$ ]]; then
    exit 0
fi

# Skip test files - those are always allowed (Red phase)
# Common test patterns across languages
FILENAME=$(basename "$FILE_PATH")
DIRPATH=$(dirname "$FILE_PATH")

# Check directory patterns
if [[ "$DIRPATH" == *"/test/"* ]] || [[ "$DIRPATH" == *"/tests/"* ]] || \
   [[ "$DIRPATH" == *"/spec/"* ]] || [[ "$DIRPATH" == *"/__tests__/"* ]] || \
   [[ "$DIRPATH" == *"/Test/"* ]] || [[ "$DIRPATH" == *"/Tests/"* ]]; then
    exit 0
fi

# Check filename patterns
if [[ "$FILENAME" =~ ^test[_\.].*$ ]] || [[ "$FILENAME" =~ .*[_\.]test\..*$ ]] || \
   [[ "$FILENAME" =~ .*[_\.]spec\..*$ ]] || [[ "$FILENAME" =~ .*Tests\..*$ ]] || \
   [[ "$FILENAME" =~ .*Test\..*$ ]] || [[ "$FILENAME" =~ .*_test\..*$ ]] || \
   [[ "$FILENAME" =~ ^spec[_\.].*$ ]]; then
    exit 0
fi

# Find project root
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ROADMAP="$PROJECT_DIR/ROADMAP.md"

# Check if ROADMAP.md exists
if [[ ! -f "$ROADMAP" ]]; then
    cat << 'EOF'
{
  "decision": "block",
  "reason": "ROADMAP.md not found. Create it with an ACTIVE story before writing implementation code.\n\nWorkflow: Research -> Plan -> Add to ROADMAP.md -> Test (Red) -> Implement (Green)\n\nIf this is non-testable code (visual/UI), ask the user to approve using --force to override."
}
EOF
    exit 0
fi

# Check for ACTIVE section content
# Format is: ## Active\n\n[story or None]
ACTIVE_CONTENT=$(sed -n '/^## Active/,/^##/p' "$ROADMAP" | grep -v "^## " | grep -v "^$" | head -1)

# Check if ACTIVE is "None" or empty
if [[ -z "$ACTIVE_CONTENT" ]] || [[ "$ACTIVE_CONTENT" == "None" ]]; then
    cat << 'EOF'
{
  "decision": "block",
  "reason": "No ACTIVE story in ROADMAP.md. Cannot write implementation code without an active story.\n\nTo proceed:\n1. Plan and add stories to ROADMAP.md\n2. Mark a story as ACTIVE in ROADMAP.md\n3. Write failing tests first (Red phase)\n4. Then implement (Green phase)\n\nIf this is non-testable code (visual/UI), ask the user to approve using --force to override."
}
EOF
    exit 0
fi

# Active story exists, allow the write
exit 0
