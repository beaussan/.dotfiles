#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
    echo $(nordvpn status | grep IP | tr -d ' ' | cut -d ':' -f2) @ $(nordvpn status | grep Country | tr -d ' ' | cut -d ':' -f2)-$(nordvpn status | grep City | tr -d ' ' | cut -d ':' -f2)
else
    echo ""
fi