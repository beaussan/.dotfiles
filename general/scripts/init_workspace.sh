#!/bin/bash
set -x
# https://github.com/yedhink
# Feel free to share with your friends

# install wmctrl. Its a prerequisite to make this script work.

# Launch it in your i3 config file
# exec --no-startup-id ~/.config/i3/init_workspace.sh
#
# obviously, make it executable : # chmod +x init_workspace.sh
# HAVE FUN !


workspace1="1:"
#  Git"
workspace2="2:"
#  Web"
workspace3="3:"
#  term"
workspace4="4:"
#  Ide"
workspace5="5:" 
#  chat"
workspace6="6:"
#  random"
workspace7="7:"

# App you want to start :
apps=(
 "telegram-desktop"
 "obsidian"
 "google-chrome-stable"
 "slack"
)

# Which workspace to assign your wanted App :
workspaces=(
 $workspace1
 $workspace1
 $workspace2
 $workspace5
)

# counter of opened windows
owNB=-1

nativefier=$HOME/nativefier/bins

# add paths of apps to array
arr=()
arr+=(
    '/usr/bin/'
    '/usr/bin/'
    '/usr/bin/'
    '/usr/bin/'
)

for iwin in ${!apps[*]}
do
    while [ "$owNB" -lt "$iwin" ] # wait before start other programs
    do
        owNB=$(wmctrl -l | wc -l) # Get number of actual opened windows
        wait 5
    done
    i3-msg workspace ${workspaces[$iwin]} # move in wanted workspace
    ${arr[$iwin]}/${apps[$iwin]} & # start the wanted app
done

i3-msg workspace $workspace1
i3-msg move workspace to output left
i3-msg layout tabbed

i3-msg workspace $workspace5
i3-msg move workspace to output right
i3-msg move workspace to output right

i3-msg workspace $workspace2
i3-msg move workspace to output right
