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
    local current_workspace=1

    # fill all displays with workspaces
    local workspaces_per_display=$((4 / ($(echo "$displays" | wc -l) - 1)))
    while read -r display; do
        for _ in $(seq 1 $workspaces_per_display); do
            i3-msg "workspace $current_workspace; move workspace to output $display" > /dev/null
            local current_workspace=$((current_workspace + 1))
        done
    done < <(echo "$displays")

    # fill out the last display with remaining workspaces
    local last_display="$(echo "$displays" | tail -n 1)"
    for _ in $(seq $current_workspace 9); do
        i3-msg "workspace $current_workspace; move workspace to output $last_display" > /dev/null
        local current_workspace=$((current_workspace + 1))
    done

    i3-msg "workspace $initial_workspace" > /dev/null
}

if [[ "$0" == "$BASH_SOURCE" ]]; then
    place_workspaces
fi
