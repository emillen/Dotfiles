#!/usr/bin/env bash

list_connected_devices() {
    local connected_devices="$(bluetoothctl devices Connected )"
    for device in "$connected_devices"; do
        local alias=$(echo "$device"| cut -d ' ' -f 3-)
        echo "$alias"
    done
}

print_connected_devices() {

    local connected_devices=$(list_connected_devices)

    local count=0
    local max=$(echo "$connected_devices" | wc -l)

    if [[ "$connected_devices" == "" ]]; then
        exit 0
    fi

    while read -r device; do
        local count=$((count + 1))
        echo -n "$device"
        if [ "$count" -lt "$max" ]; then
            echo -n ", "
        fi
    done < <(echo "$connected_devices")
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
        --list-devices) print_connected_devices
            ;;
        *) echo "$help_text"
            ;;
    esac

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
