#!/bin/bash
# ~/.config/eww/scripts/remove_task.sh

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

# Remove task by ID
UPDATED=$(jq --argjson id "$TASK_ID" \
  'map(select(.id != $id))' \
  "$TASKS_FILE")

# Save to file
echo "$UPDATED" > "$TASKS_FILE"

# Update eww
eww update tasks="$UPDATED"
