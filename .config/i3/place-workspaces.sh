#!/usr/bin/env bash

get_displays() {
    xrandr --listmonitors |\
        tail -n +2 |\
        sed -e 's/.*\/.*\///g' |\
        sed -e 's/+/ /g' |\
        sort -k 2 -n |\
        sort -k 3 -n |\
        awk '{print $4}'
}

place_workspaces () {
    local displays="$(get_displays)"
    local initial_workspace="$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name' )"

    local current=1
    while read -r display; do
        i3-msg "workspace $current; move workspace to output $display" > /dev/null
        i3-msg "workspace $(($current + 1)); move workspace to output $display" > /dev/null
        local current=$((current + 2))
    done < <(echo "$displays")

    i3-msg "workspace $initial_workspace" > /dev/null
}

if [[ "$0" == "$BASH_SOURCE" ]]; then
    place_workspaces
fi
