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

function wait_for_window {
    local window_title="$1"
    local window_id=""
    
    while [ -z "$window_id" ]; do
        sleep 1
        window_id=$(wmctrl -l | grep "$window_title" | cut -d ' ' -f 1)
    done
    
    return 0
}

function wait_for_network {
    local start_time=$(date +%s)
    
    # Wait for network to be online
    while true; do
        if ping -c 1 google.com &>/dev/null; then
            return 0
        fi
        
        # Check if timeout has been reached
        local end_time=$(date +%s)
        local elapsed=$((end_time - start_time))
        if [ $elapsed -gt 30 ]; then
            echo "Timed out waiting for network to be online"
            return 1
        fi
        
        sleep 1
    done
}


# Workspace 1 content
i3-msg workspace $workspace1
i3-msg move workspace to output primary
i3-msg move workspace to output left

"$(ls /home/beaussan/bin/*beeper*)" & wait_for_window "Beeper"
# /usr/bin/telegram-desktop & wait_for_window "Telegram"
/usr/bin/obsidian & wait_for_window "Obsidian"
i3-msg layout tabbed

if wait_for_network && sleep 1 && wait_for_network && sleep 1; then

    # Workspace 5 content
    i3-msg workspace $workspace5
    i3-msg move workspace to output primary
    i3-msg move workspace to output right
    /usr/bin/slack & wait_for_window "Slack"

    # Workspace 2
    i3-msg workspace $workspace2
    i3-msg move workspace to output primary

    # Network is online, continue script
    /usr/bin/google-chrome-stable &
else
    # Network is offline, handle error
    notify-send -u critical "Network is offline, cannot continue script."
    exit 1
fi
