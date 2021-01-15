#!/bin/sh

bluetooth_print() {
    bluetoothctl | while read -r; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" -a "$(bluetoothctl show | grep "Powered:" | cut -d ':' -f 2 | cut -d ' ' -f 2)" = "yes" ]; then
            # printf '#1'

            devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
            counter=0
            devices=""

            echo "$devices_paired" | while read -r line; do
                device_info=$(bluetoothctl info "$line")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

                    if [ $counter -gt 0 ]; then
                        devices="${devices}, $device_alias"
                        #printf ", %s" "$device_alias"
                    else
                        devices="$device_alias"
                        #printf " %s" "$device_alias"
                    fi

                    counter=$((counter + 1))
                fi

                if [ $counter -eq 0 ]; then
                    echo "%{F#ffffff}"
                else
                    echo "%{F#3B82F6} %{F#ffffff}$devices"
                fi

                # printf '\n'
                # printf "\%\{F#ffffff\} \%\{F#f0f0f0\}%s" "$devices"
            done
        else
            echo "%{F#787878}"
        fi
    done
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac