#!/bin/bash
# ~/.config/eww/scripts/add_task.sh

TASKS_FILE="$HOME/.config/eww/data/todo.json"
NEW_TASK="$1"

# Exit if task is empty
if [ -z "$NEW_TASK" ]; then
    exit 0
fi

# Create directory and file if they don't exist
mkdir -p "$(dirname "$TASKS_FILE")"
if [ ! -f "$TASKS_FILE" ]; then
    echo "[]" > "$TASKS_FILE"
fi

# Generate unique ID using timestamp and random number
NEW_ID=$(date +%s)$RANDOM

# Add new task with jq
UPDATED=$(jq --arg text "$NEW_TASK" --argjson id "$NEW_ID" \
  '. += [{"id": $id, "text": $text, "completed": false}]' \
  "$TASKS_FILE")

# Save to file
echo "$UPDATED" > "$TASKS_FILE"

# Update eww
eww update tasks="$UPDATED"
