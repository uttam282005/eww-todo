# EWW Todo Widget - Complete Setup Guide

## 📁 Project Structure

```
~/.config/eww/
├── eww.yuck              # Main configuration
├── eww.scss              # Styles
├── data/
│   └── todo.json         # Tasks storage (auto-created)
└── scripts/
    ├── add_task.sh       # Add new task
    ├── remove_task.sh    # Remove task
    ├── get_tasks.sh      # Watch and load tasks
    ├── toggle_task.sh    # Toggle completion
    └── clear_completed.sh # Clear completed tasks
```

## 🚀 Installation Steps

### 1. Create Directory Structure

```bash
mkdir -p ~/.config/eww/scripts
mkdir -p ~/.config/eww/data
```

### 2. Copy All Files

Copy each script from the artifacts above into the correct location:

```bash
# Copy scripts (make sure to create each file with the content provided)
touch ~/.config/eww/scripts/{add_task.sh,remove_task.sh,get_tasks.sh,toggle_task.sh,clear_completed.sh}
```

### 3. Make Scripts Executable

```bash
chmod +x ~/.config/eww/scripts/*.sh
```

### 4. Install Dependencies

```bash
# Install jq (JSON processor) - required!
sudo pacman -S jq

# Install inotify-tools (optional, for better performance)
sudo pacman -S inotify-tools
```

### 5. Initialize Tasks File

```bash
echo "[]" > ~/.config/eww/data/todo.json
```

## 🎨 Usage

### Start the Todo Window

```bash
eww open todo-window
```

### Close the Todo Window

```bash
eww close todo-window
```

### Reload After Changes

```bash
eww reload
```

## ⌨️ Hyprland Integration

Add to your `~/.config/hypr/hyprland.conf`:

```conf
# Toggle todo window
bind = SUPER, T, exec, eww open todo-window || eww close todo-window

# Or use a more sophisticated toggle script
bind = SUPER, T, exec, ~/.config/eww/scripts/toggle_todo.sh
```

### Toggle Script (Optional)

Create `~/.config/eww/scripts/toggle_todo.sh`:

```bash
#!/bin/bash

if eww windows | grep -q "*todo-window"; then
    eww close todo-window
else
    eww open todo-window
fi
```

Make it executable:
```bash
chmod +x ~/.config/eww/scripts/toggle_todo.sh
```

## 🎯 Features

- ✅ Add tasks with text input
- ✅ Mark tasks as completed
- ✅ Remove individual tasks
- ✅ Clear all completed tasks
- ✅ Persistent storage (survives restarts)
- ✅ Real-time updates
- ✅ Task counter
- ✅ Smooth animations
- ✅ Catppuccin Mocha theme

## 🐛 Troubleshooting

### Tasks not showing up?

```bash
# Check if file exists and has correct format
cat ~/.config/eww/data/todo.json

# Should show: [] or [{"id": 123, "text": "Task", "completed": false}]
```

### Scripts not working?

```bash
# Test individual scripts
bash ~/.config/eww/scripts/add_task.sh "Test task"
cat ~/.config/eww/data/todo.json
```

### Check eww logs

```bash
eww logs
```

### Restart eww daemon

```bash
eww kill
eww daemon
eww open todo-window
```

## 🎨 Customization

### Change Colors

Edit `~/.config/eww/eww.scss` and modify the color values:

```scss
// Primary color (blue)
#89b4fa → your color

// Background
rgba(30, 30, 46, 0.95) → your color

// Completed color (green)
#a6e3a1 → your color
```

### Change Position

Edit window geometry in `eww.yuck`:

```yuck
:geometry (geometry 
  :x "20px"        # Distance from edge
  :y "50px"        # Distance from top
  :width "320px"   # Window width
  :height "450px"  # Window height
  :anchor "top right")  # Corner to anchor to
```

### Change Font

Edit in `eww.scss`:

```scss
font-family: "JetBrainsMono Nerd Font", monospace;
```

## 📚 Learning Resources

- [EWW Documentation](https://elkowar.github.io/eww/)
- [jq Manual](https://jqlang.github.io/jq/manual/)
- [Hyprland Wiki](https://wiki.hyprland.org/)

---

**Pro tip**: Back up your todo.json file regularly:

```bash
cp ~/.config/eww/data/todo.json ~/.config/eww/data/todo.json.backup
```
