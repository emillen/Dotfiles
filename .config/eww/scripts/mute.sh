#!/bin/bash

DEFAULT_SINK=$(pactl get-default-sink)

is_muted="$(pactl get-sink-mute "$DEFAULT_SINK" | tr  -d " " | cut -d : -f2)"

if [[ "$is_muted" == "no" ]]; then
    pactl set-sink-mute "$DEFAULT_SINK" 1
    $1 update volume-muted="yes"
else
    pactl set-sink-mute "$DEFAULT_SINK" 0
    $1 update volume-muted="no"
fi







