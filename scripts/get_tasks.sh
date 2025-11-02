#!/bin/bash
# ~/.config/eww/scripts/get_tasks.sh

TASKS_FILE="$HOME/.config/eww/data/todo.json"

# Create directory and file if they don't exist
mkdir -p "$(dirname "$TASKS_FILE")"
if [ ! -f "$TASKS_FILE" ]; then
    echo "[]" > "$TASKS_FILE"
fi

# Watch for changes and output tasks
while true; do
    # Output compact JSON on a single line so eww's deflisten can
    # parse values reliably (pretty-printed JSON would emit multiple
    # lines and confuse the listener).
    if command -v jq &> /dev/null; then
        jq -c . "$TASKS_FILE" || echo "[]"
    else
        # Fallback: remove newlines so the output is a single line
        tr -d '\n' < "$TASKS_FILE" || echo "[]"
    fi
    
    # Wait for file to change using inotifywait
    # If inotifywait is not available, fall back to sleep
    if command -v inotifywait &> /dev/null; then
        # Run inotifywait but silence any output to avoid emitting
        # non-JSON lines to eww's deflisten (some versions print
        # events even with -q). Redirect stdout/stderr.
        inotifywait -q -e modify,create "$TASKS_FILE" >/dev/null 2>&1 || true
    else
        sleep 1
    fi
done
