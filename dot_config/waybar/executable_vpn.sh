#!/bin/bash

if mullvad_status=$(mullvad status); then
    if echo "$mullvad_status" | grep -q Connected; then
        location=$(echo "$mullvad_status" | awk -F 'in' '{print $2}' | xargs)
        output="  $location"
		    color="#CF9A08"
        tooltip="Connected to Mullvad VPN in $location"
        class=""
    else
        output="  Disconnected"
		    color="#A5351D"
        tooltip="Not connected to Mullvad VPN"
        class="disconnected"
    fi
else
    output="ERR"
    tooltip="Error getting Mullvad status"
    class="error"
fi

echo "{\"text\":\"${output}\", \"tooltip\":\"${tooltip}\", \"class\":\"${class}\"}"

