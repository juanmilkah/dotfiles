#!/bin/bash
# Start notification daemon
mako &

# Start network manager applet
nm-applet --indicator &

# Set wallpaper (install hyprpaper first)
hyprpaper &
