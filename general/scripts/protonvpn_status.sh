#!/bin/sh

STATUS=$(protonvpn status)


getItemByLabel() {
    echo "$STATUS" | grep "$1" | xargs | cut -d ' ' -f 2-
}


CONNECTED=$(getItemByLabel Status)

if [ "$CONNECTED" = "Connected" ]; then
    IP=$(getItemByLabel IP)
    COUNTRY=$(getItemByLabel Country)
    CITY=$(getItemByLabel City)
    echo $IP @ "$CITY,$COUNTRY"
else
    echo ""
fi