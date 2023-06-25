#!/usr/bin/env bash
DEFAULT_SINK=$(pactl get-default-sink)
pactl get-sink-volume "$DEFAULT_SINK" | cut -d "/" -f4 | head -n 1 | tr -d " " | tr -d "%"

if [[ "$1" == "up" ]]; then
    pactl set-sink-volume "$DEFAULT_SINK" +1%
elif [[ "$1" == "down" ]]; then
    pactl set-sink-volume "$DEFAULT_SINK" -1%
fi

$2 update volume=$(pactl get-sink-volume $(pactl get-default-sink)| cut -d '/' -f4 | head -n 1 | tr -d ' ' | tr -d '%')
