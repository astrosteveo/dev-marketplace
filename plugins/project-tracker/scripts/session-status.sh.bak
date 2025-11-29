#!/bin/bash
# Session status script for project-tracker
# Outputs brief project state on session start
# Designed to be token-efficient (50-100 words max)

set -euo pipefail

# Check if ROADMAP.md exists
if [ ! -f "ROADMAP.md" ]; then
    # No roadmap, exit silently (don't clutter sessions for non-tracked projects)
    exit 0
fi

# Initialize variables
active_story=""
completed=0
total=0
last_task=""
spec_file=""

# Extract active story from ROADMAP.md
# Look for "### Story:" in Active section
in_active=false
while IFS= read -r line; do
    if [[ "$line" == "## Active"* ]]; then
        in_active=true
        continue
    fi
    if [[ "$line" == "## Done"* ]] || [[ "$line" == "## Backlog"* ]]; then
        in_active=false
        continue
    fi
    if $in_active; then
        # Extract story name
        if [[ "$line" =~ ^###[[:space:]]*Story:[[:space:]]*(.+)$ ]]; then
            active_story="${BASH_REMATCH[1]}"
        fi
        # Count checkboxes
        if [[ "$line" =~ ^\-[[:space:]]*\[x\] ]]; then
            ((completed++))
            ((total++))
        elif [[ "$line" =~ ^\-[[:space:]]*\[[[:space:]]\] ]]; then
            ((total++))
            # Capture first incomplete task as "current"
            if [ -z "$last_task" ]; then
                last_task=$(echo "$line" | sed 's/^- \[ \] //')
            fi
        fi
        # Extract spec file reference
        if [[ "$line" =~ Spec:[[:space:]]*\`([^\`]+)\` ]]; then
            spec_file="${BASH_REMATCH[1]}"
        fi
    fi
done < ROADMAP.md

# Check .claude/project-tracker.local.md for additional context
local_file=".claude/project-tracker.local.md"
if [ -f "$local_file" ]; then
    # Try to extract last_task from local file if not found in roadmap
    local_task=$(grep -E "^last_task:" "$local_file" 2>/dev/null | sed 's/last_task:[[:space:]]*//' | sed 's/"//g' || true)
    if [ -n "$local_task" ] && [ "$local_task" != "null" ]; then
        last_task="$local_task"
    fi
fi

# Output summary
if [ -n "$active_story" ]; then
    echo "📍 **Session Resume**"
    echo ""
    echo "**Active:** $active_story"
    echo "**Progress:** $completed/$total tasks complete"
    if [ -n "$last_task" ]; then
        echo "**Current task:** $last_task"
    fi
    if [ -n "$spec_file" ]; then
        echo ""
        echo "Spec: \`$spec_file\`"
    fi
else
    # Count backlog items
    backlog_count=$(grep -c "^### " ROADMAP.md 2>/dev/null || echo "0")
    # Subtract active stories (already counted)

    echo "📍 **Session Resume**"
    echo ""
    echo "No active story."
    if [ "$backlog_count" -gt 0 ]; then
        echo "Backlog has items waiting."
        echo ""
        echo "Use \`/roadmap view\` to see options or \`/create-spec\` to start one."
    else
        echo ""
        echo "Use \`/discover\` to plan features or \`/roadmap add\` to add items."
    fi
fi
