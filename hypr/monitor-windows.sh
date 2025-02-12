#!/bin/bash

# Listen for window close events
socat - UNIX-CONNECT:/tmp/hypr/.socket2.sock | while read -r line; do
    if echo "$line" | grep -q "closewindow"; then
        # Trigger reindexing script
        ~/.config/hypr/reindex-workspaces.sh
    fi
done
