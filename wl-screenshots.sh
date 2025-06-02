#!/bin/bash

# Directory to save screenshots
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Generate filename with date and time
FILENAME="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"

# Function for notifications
notify() {
    notify-send "Screenshot" "$1" -i camera-photo
}

# Take screenshot of the entire screen
if [ "$1" = "full" ]; then
    grim "$FILENAME"
    notify "Full screenshot saved to $FILENAME"
    
# Take screenshot of selected area
elif [ "$1" = "area" ]; then
    grim -g "$(slurp)" "$FILENAME" 
    notify "Area screenshot saved to $FILENAME"
    
# Take screenshot of selected area to clipboard
elif [ "$1" = "area-clipboard" ]; then
    grim -g "$(slurp)" - | wl-copy
    notify "Area screenshot copied to clipboard"
    
# Take screenshot of entire screen to clipboard
elif [ "$1" = "full-clipboard" ]; then
    grim - | wl-copy
    notify "Full screenshot copied to clipboard"
    
# Take screenshot of the active window
elif [ "$1" = "window" ]; then
    WINDOW=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    grim -g "$WINDOW" "$FILENAME"
    notify "Window screenshot saved to $FILENAME"
    
# Take screenshot of the active window to clipboard
elif [ "$1" = "window-clipboard" ]; then
    WINDOW=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    grim -g "$WINDOW" - | wl-copy
    notify "Window screenshot copied to clipboard"
fi

