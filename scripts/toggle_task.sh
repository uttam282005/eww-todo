#!/bin/bash
# ~/.config/eww/scripts/toggle_task.sh

TASKS_FILE="$HOME/.config/eww/data/todo.json"
TASK_ID="$1"

# Exit if no ID provided
if [ -z "$TASK_ID" ]; then
    exit 0
fi

# Check if file exists
if [ ! -f "$TASKS_FILE" ]; then
    echo "[]" > "$TASKS_FILE"
    exit 0
fi

# Toggle completed status
UPDATED=$(jq --argjson id "$TASK_ID" \
  'map(if .id == $id then .completed = (.completed | not) else . end)' \
  "$TASKS_FILE")

# Save to file
echo "$UPDATED" > "$TASKS_FILE"

# Update eww
eww update tasks="$UPDATED"
