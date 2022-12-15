#!/usr/bin/env sh
#
# Rofi powered menu to check i3 keybindings.
# Uses: awk i3-msg rofi rofi-utils

dir="$HOME/.config/rofi/launcher"
theme='style-single'

list=$(i3-msg -t get_config \
    | awk -v pre_mode="<span bgcolor='#282B31FF' fgcolor='#FFFFFFFF' weight='heavy'> " \
          -v post_mode=' </span> ' \
          -v pre_keybinding="<span fgcolor='#98C379FF' weight='heavy'>" \
          -v post_keybinding='</span>' \
          -v separator=' ' '
$1 == "#" {
    # Strip down the indent characters.
    gsub(/^\s+/, "", $0);

    comment = substr($0, 3);
}

match($0, /^[^\s]+mode ".+"/) != 0 {
    mode = pre_mode toupper(substr($2, 2, length($2)-2)) post_mode;
}

match($0, /^}/) != 0 {
    mode = "";
}

$1 == "bindsym" {
    # Strip down the $ character from variables such as $Mod.
    gsub(/\$/, "", $2)

    line = pre_keybinding $2 post_keybinding separator comment;

    # Replace $num in the comment by the number found in the keybinding.
    if (index(comment, "$num")) {
        gsub(/\$num/, substr($2, match($2, /([[:digit:]]+)$/), length($2)), line);
    }

    print mode line;
}')

printf '%s\n' "$list" \
    | rofi -theme ${dir}/${theme}.rasi \
           -p 'i3 Keybindings' \
           -dmenu \
           -markup-rows \
           -i > /dev/null
