#!/bin/bash

get_active_network() {
    nmcli --terse connection show --active                   \
        | grep               --extended-regexp "wireless"    \
        | cut                --delimiter ":" --fields 1      \
        | tr "\n" ","                                        \
        | sed                --expression 's/,$//g'
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
