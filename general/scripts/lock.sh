#!/bin/bash

img="/tmp/screenshot.png"

scrot -o $img
convert $img -scale 10% -scale 1000% $img
# convert $img -blur 0x5 $img
i3lock -b -i $img

