#!/bin/bash

get_active_network() {
    nmcli connection show --active | grep -Ev "loopback|NAME" | tr -s " " | cut -d " " -f1
}


last=$(get_active_network)
echo "$last"

nmcli monitor 2>/dev/null | while read -r line; do
    new=$(get_active_network)

    if [[ "$last" != "$new" ]]; then
        echo "$new"
        last="$new"
    fi
done

