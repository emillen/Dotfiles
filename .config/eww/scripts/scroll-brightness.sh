#!/usr/bin/env bash

CURRENT="$($(dirname "$0")/get-brightness.sh)"

if [[ "$CURRENT" -le 100 ]] && [[ "$1" == "up" ]]; then
    brightnessctl set "+1%"
elif [[ "$CURRENT" -ge 10 ]] && [[ "$1" == "down" ]]; then
    brightnessctl set "1%-"
fi

NEW="$($(dirname "$0")/get-brightness.sh)"

$2 update brightness=$NEW
