#!/bin/bash

THRESHOLD=20
ALERTED=0

get_battery_percent() {
    BAT0=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {gsub("%",""); print $2}')
    BAT1=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/percentage/ {gsub("%",""); print $2}')
    
    # Handle case where one battery might be missing
    [ -z "$BAT0" ] && BAT0=0
    [ -z "$BAT1" ] && BAT1=0

    # return average of the batteries
    AVG=(($BAT0 + $BAT1) / 2)
    echo "$AVG"
}

while true; do
    PERCENT=$(get_battery_percent)

    if [ "$PERCENT" -le "$THRESHOLD" ] && [ "$ALERTED" = false ]; then
        notify-send "Battery Low" "Battery is at ${PERCENT}%!" --urgency=critical
        ALERTED=1
    elif [ "$PERCENT" -gt "$THRESHOLD" ]; then
        ALERTED=0
    fi

    sleep 60
done
