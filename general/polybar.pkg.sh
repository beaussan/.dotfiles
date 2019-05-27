#!/bin/bash
# https://github.com/jaagr/polybar/wiki/User-contributed-modules#archlinux-updates
pac=$(checkupdates-aur | wc -l)
aur=$(cower -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#5b5b5b}%{F-} $aur"
fi
