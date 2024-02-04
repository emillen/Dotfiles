#!/usr/bin/env bash

print_vpn_connection_status () {
    status="$(nordvpn status)"
    settings="$(nordvpn settings)"

    connection="$(echo "$status" | grep "Status: " | cut -d ":" -f2 | tr -d " ")"
    killswitch_status="$(echo "$settings" | grep "Kill Switch: " | cut -d ":" -f2 | tr -d " ")"

    hostname="$(echo "$status" | grep "Hostname" | cut -d ":" -f2 | tr -d " " | sed -e "s/\.nordvpn\.com//")"

    if [[ $connection == "Disconnected" ]]; then
        echo "$connection (KS $killswitch_status)"
    else
        echo "$hostname (KS $killswitch_status)"
    fi
}

if [[ "$BASH_SOURCE" == "$0" ]]; then
    print_vpn_connection_status
fi
