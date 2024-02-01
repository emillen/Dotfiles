#!/usr/bin/env bash

main () {
    local ssids="$(nmcli --fields ssid dev wifi list | tail -n +2 | sort | uniq)"
    local conns="$(nmcli --fields name conn | tail -n +2)"

    local ssid="$(echo "$ssids" |  fzf --tac | awk '{$1=$1};1')"

    if [[ -z $ssid ]]; then
        exit 0;
    fi

    if echo "$conns" | grep "$ssid" > /dev/null; then
        nmcli conn up "$ssid"
    else
        nmcli d wifi connect "$ssid" --ask
    fi

    if [[ $? -ne 0 ]]; then
        sleep 3;
    fi
}

if [[ "$BASH_SOURCE" == "$0" ]]; then
    main
fi
