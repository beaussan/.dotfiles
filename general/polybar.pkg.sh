#!/bin/bash
# https://github.com/jaagr/polybar/wiki/User-contributed-modules#archlinux-updates
pac=$(checkupdates 2>/dev/null | wc -l)
aur=$(checkupdates-aur 2>/dev/null | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#5b5b5b}%{F-} $aur"
else
    echo ""
fi
