#!/usr/bin/env bash

set -euo pipefail

# Compare two displays, return 0 if they should be swapped
comp_displays() {
    local left="$1"
    local right="$2"

    local left_x_size="$(echo "$left" | awk '{print $1}')"
    local left_y_size="$(echo "$left" | awk '{print $2}')"
    local left_x_pos="$(echo "$left" | awk '{print $3}')"
    local left_y_pos="$(echo "$left" | awk '{print $4}')"
    local left_y_max="$((left_y_pos + left_y_size))"
    local left_x_max="$((left_x_pos + left_x_size))"

    local right_x_size="$(echo "$right" | awk '{print $1}')"
    local right_y_size="$(echo "$right" | awk '{print $2}')"
    local right_x_pos="$(echo "$right" | awk '{print $3}')"
    local right_y_pos="$(echo "$right" | awk '{print $4}')"
    local right_y_max="$((right_y_pos + right_y_size))"
    local right_x_max="$((right_x_pos + right_x_size))"

    # Swap if is fully to the left
    if [[ "$right_x_pos" -gt "$left_x_max" ]]; then
        return 0
    fi

    # Swap if is fully below below
    if [[ "$right_y_pos" -gt "$left_y_max" ]]; then
        return 0
    fi

    # Swap if left hand side is more to the left
    if [[ "$left_x_pos" -gt "$right_x_pos" ]]; then
        return 0
    fi

    # Swap if top is more to the top
    if [[ "$left_y_pos" -gt "$right_y_pos" ]]; then
        return 0
    fi
    
    # Dont swap
    return 1
}

# Sort the displays
sort_displays() {
    local displays="$1"
    readarray -t displays <<< "$displays"

    local amount_of_displays="${#displays[@]}"

    for ((i = 0; i < amount_of_displays; i++)); do
        for ((j = 0; j < amount_of_displays - i - 1; j++)); do
            local current_display="$(echo "${displays[$j]}")"
            local next_display="$(echo "${displays[$j + 1]}")"

            if comp_displays "$current_display" "$next_display"; then
                local temp="${displays[$j]}"
                displays[$j]="${displays[$j + 1]}"
                displays[$j + 1]="$temp"
            fi
        done
    done

    for display in "${displays[@]}"; do
        echo "$display"
    done
}

# get the display names in the order i want them
get_displays() {
    local displays="$( \
        xrandr --listmonitors |\
        tail -n +2 |                                 # 0: +*eDP 1920/309x1080/174+821+1440  eDP \
        awk '{$1=""; $2=""; sub("  ", ""); print}' | # 1920/309x1080/174+821+1440  eDP          \
        sed -E -e 's/\/[0-9]*x/ /g' |                # 1920 1080/174+821+1440  eDP              \
        sed -E -e 's/\/[0-9]*\+/ /g' |               # 1920 1080 821+1440  eDP                  \
        sed -e 's/+/ /g')"                           # 1920 1080 821 1440  edp


    sort_displays "$displays" | awk '{print $5}'
}

# Place the workspaces in the order i want them
place_workspaces () {
    local displays="$(get_displays)"
    local visible_workspaces="$( i3-msg -t get_workspaces | jq -r '.[] | select(.visible == true).name' )"
    local focused_workspace="$(  i3-msg -t get_workspaces  | jq -r '.[] | select(.focused == true).name' )"

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


    # Show the visible workspaces from before
    while read -r workspace; do
        i3-msg "workspace $workspace" > /dev/null
    done < <(echo "$visible_workspaces")

    # Focus on the focused workspace from before
    i3-msg "workspace $focused_workspace" > /dev/null
}

if [[ "$0" == "$BASH_SOURCE" ]]; then
    place_workspaces
fi
