#!/usr/bin/env bash

toggle_killswitch () {
    settings="$(nordvpn settings)"

    killswitch_status="$(echo "$settings" | grep "Kill Switch: " | cut -d ":" -f2 | tr -d " ")"
    echo "$killswitch_status"

    if [[ $killswitch_status == "enabled" ]]; then
        echo disabling
        nordvpn set killswitch disabled
    elif [[ "$killswitch_status" == "disabled" ]]; then
        echo enabling
        nordvpn set killswitch enabled
    fi
}

if [[ "$BASH_SOURCE" == "$0" ]]; then
    toggle_killswitch
fi
