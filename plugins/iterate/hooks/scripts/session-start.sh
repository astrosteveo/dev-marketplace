#!/bin/bash
# Session start hook for iterate plugin
# Loads ROADMAP.md state and provides context to Claude

set -euo pipefail

# Read hook input
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // "."')

# Check if ROADMAP.md exists
ROADMAP_FILE="$cwd/ROADMAP.md"
CONFIG_FILE="$cwd/.claude/iterate.local.md"

# Build system message
system_message=""

if [ -f "$ROADMAP_FILE" ]; then
    # Extract current phase from ROADMAP.md
    current_phase=$(grep -E "^### Phase:" "$ROADMAP_FILE" | head -1 | sed 's/### Phase: //' || echo "Unknown")
    current_feature=$(grep -E "^## Current Feature:" "$ROADMAP_FILE" | head -1 | sed 's/## Current Feature: //' || echo "None")

    system_message="[iterate] ROADMAP.md detected. Current feature: $current_feature | Phase: $current_phase"

    # Check test status
    unit_status=$(grep -E "Unit:.*\`" "$ROADMAP_FILE" | grep -oE "(Pass|Fail|Pending|N/A)" | head -1 || echo "Unknown")
    integration_status=$(grep -E "Integration:.*\`" "$ROADMAP_FILE" | grep -oE "(Pass|Fail|Pending|N/A)" | head -1 || echo "Unknown")

    if [ "$unit_status" != "Unknown" ] || [ "$integration_status" != "Unknown" ]; then
        system_message="$system_message | Tests: Unit=$unit_status Integration=$integration_status"
    fi
else
    system_message="[iterate] No ROADMAP.md found. Use /iterate to start iterative workflow."
fi

# Check strictness setting
strictness="warn"
if [ -f "$CONFIG_FILE" ]; then
    extracted=$(grep -E "^strictness:" "$CONFIG_FILE" | head -1 | awk '{print $2}' || echo "")
    if [ -n "$extracted" ]; then
        strictness="$extracted"
    fi
    system_message="$system_message | TDD Strictness: $strictness"
fi

# Output JSON response
echo "{\"systemMessage\": \"$system_message\"}"
