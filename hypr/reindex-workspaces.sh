#!/bin/bash

# Get the list of active workspaces
workspaces=$(hyprctl workspaces -j | jq -r '.[] | .id' | sort -n)

# Reindex workspaces
new_index=1
for ws in $workspaces; do
    if [ "$ws" -ne "$new_index" ]; then
        hyprctl dispatch workspace $ws
        hyprctl dispatch renameworkspace $ws $new_index
    fi
    new_index=$((new_index + 1))
done
