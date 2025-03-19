#!/bin/bash

# Check if waybar is running
if pgrep -x "waybar" > /dev/null; then
    # If it's running, kill it
    killall waybar
    notify-send "Waybar" "Waybar has been hidden" -a "System" -t 2000
else
    # If it's not running, start it
    # You may need to adjust this command based on your setup
    waybar &
    notify-send "Waybar" "Waybar has been shown" -a "System" -t 2000
fi
