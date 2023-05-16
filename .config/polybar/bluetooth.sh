#!/usr/bin/env bash

list_connected_devices() {
    local connected_devieds=$(bluetoothctl paired-devices | awk '{print $2}')
    local count=0
    local max=$(echo "$connected_devieds" | wc -l)
    for device in $connected_devieds; do
        local info=$(bluetoothctl info "$device")

        if echo "$info" | grep -q "Connected: yes"; then
            local alias=$(echo "$info" | grep "Alias" | cut -d ' ' -f 2-)
            local count=$((count + 1))

            echo -n "$alias"
            if [ "$count" -lt "$max" ]; then
                echo -n ", "
            fi
        fi
    done
}

main() {
    local help_text=$(cat <<EOF
Usage: bluetooth.sh [OPTION]...
List connected bluetooth devices.

--list-devices  list connected devices
--help          display this help and exit"

EOF
    )
    case "$1" in
        --list-devices) list_connected_devices
            ;;
        *) echo "$help_text"
            ;;
    esac

}

main "$@"
