#!/bin/bash
FILE=/tmp/wallpaper.jpg
nbx w -o $FILE forest -r --general
feh --bg-scale $FILE
