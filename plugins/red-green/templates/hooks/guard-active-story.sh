#!/bin/bash
# Blocks writing implementation code without an ACTIVE story in ROADMAP.md
# Part of the Red-Green-Refactor enforcement system

# Tool input comes via environment or we parse from context
FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-$1}"

# Skip if not a .cs file
if [[ ! "$FILE_PATH" == *.cs ]]; then
    exit 0
fi

# Skip test files - those are always allowed (Red phase)
if [[ "$FILE_PATH" == *"/Tests/"* ]] || [[ "$FILE_PATH" == *"Tests.cs" ]]; then
    exit 0
fi

# Skip if not in Assets/Scripts (allow other paths)
if [[ ! "$FILE_PATH" == *"Assets/Scripts/"* ]]; then
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
  "reason": "ROADMAP.md not found. Create it with an ACTIVE story before writing implementation code.\n\nWorkflow: Research -> Plan -> Add to ROADMAP.md -> Test (Red) -> Implement (Green)"
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
  "reason": "No ACTIVE story in ROADMAP.md. Cannot write implementation code without an active story.\n\nTo proceed:\n1. Use 'plan' skill to create stories\n2. Mark a story as ACTIVE in ROADMAP.md\n3. Use 'test-writer' skill to write failing tests first\n4. Then implement\n\nThis enforces: Research -> Plan -> Red -> Green -> Refactor -> Validate"
}
EOF
    exit 0
fi

# Active story exists, allow the write
exit 0
