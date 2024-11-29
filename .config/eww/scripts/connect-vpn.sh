#!/usr/bin/env bash

main() {
    local nord_countries="$(nordvpn countries | sed -Ee "s/\s/\n/g" | tr -s "\n" | grep "\w" )$(echo -e '\nDisconnect')"

    local country="$(echo "$nord_countries" | grep "\w" | fzf --tac)"

    if [[ -z $country ]]; then
        exit 0;
    fi

    if [[ $country == "Disconnect" ]]; then
        nordvpn set killswitch disabled
        nordvpn disconnect
        exit 0;
    fi

    local city=$(nordvpn cities $country | sed -Ee "s/\s/\n/g" | tr -s "\n" | grep "\w"| fzf )

    if [[ -z $city ]]; then
        exit 0;
    fi

    nordvpn connect $country $city

    if [[ $? -eq 1 ]]; then
        nordvpn set killswitch disabled
        nordvpn login
        sleep 30000
    else
        nordvpn set killswitch enabled
    fi
}

if [[ "$BASH_SOURCE" == "$0" ]]; then
    main "$@"
fi
