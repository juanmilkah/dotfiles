#!/bin/bash
# Enable sticky keys
xkbset accessx sticky
xkbset exp 1 =accessx =sticky
# Keep sticky keys on (prevents timeout)
while true; do
    xkbset sticky
    sleep 30
done
