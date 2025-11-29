#!/bin/bash
# Capture session state to .local.md on graceful exit
# This hook updates the last_session timestamp for session continuity tracking

LOCAL_FILE=".claude/project-tracker.local.md"

# Only proceed if using project-tracker (both files must exist)
if [ ! -f "ROADMAP.md" ] || [ ! -f "$LOCAL_FILE" ]; then
  exit 0
fi

# Update last_session timestamp in frontmatter
TIMESTAMP=$(date -Iseconds)

# Use sed to update frontmatter field (if it exists)
if grep -q "^last_session:" "$LOCAL_FILE"; then
  sed -i "s/^last_session:.*/last_session: $TIMESTAMP/" "$LOCAL_FILE"
fi

exit 0
