#!/bin/bash
FILE=/tmp/wallpaper.jpg
wallhaven forest --no-people --no-anime -r -o $FILE
feh --bg-scale $FILE
