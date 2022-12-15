#!/usr/bin/env bash

dir="$HOME/.config/rofi/launcher"
theme='style-single'

stacked='  Stacked'
tabbed='ﬓ Tabbed'
split='﩯 Splitted'

chosen=$(printf '%s;%s;%s\n' "$stacked" "$tabbed" "$split" \
    | rofi -theme ${dir}/${theme}.rasi \
           -dmenu \
           -sep ';' -p 'Layout: ')

case "$chosen" in
    "$stacked") action='stacked' ;;
    "$tabbed")  action='tabbed' ;;
    "$split")   action='toggle split' ;;
    *)          exit 1 ;;
esac

i3-msg layout $action



## Run
#rofi \
#    -show drun \
#    -theme ${dir}/${theme}.rasi
