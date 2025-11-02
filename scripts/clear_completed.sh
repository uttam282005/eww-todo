#!/bin/bash
# ~/.config/eww/scripts/clear_completed.sh

TASKS_FILE="$HOME/.config/eww/data/todo.json"

# Check if file exists
if [ ! -f "$TASKS_FILE" ]; then
    echo "[]" > "$TASKS_FILE"
    exit 0
fi

# Remove all completed tasks
UPDATED=$(jq 'map(select(.completed == false))' "$TASKS_FILE")

# Save to file
echo "$UPDATED" > "$TASKS_FILE"

# Update eww
eww update tasks="$UPDATED"
