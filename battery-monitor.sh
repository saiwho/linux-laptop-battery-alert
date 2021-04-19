#!/bin/bash
while true
do
    battery_percentage=$((acpi -b | grep -P -o '[0-9]+(?=%)') | sort |  tail  -1)
    charger_online=$(acpi -b | grep -c "Charging")
    if [[ $charger_online -eq 1 && $battery_percentage -gt 85 ]]
    then
        export DISPLAY=:0.0
        notify-send -i "$PWD/battery_full.png" "Battery CHARGED" "Level: ${battery_percentage}%";
        espeak "85% Charged, Please remove the adapter" -s 150
    fi

    if [[ $charger_online -eq 0 && $battery_percentage -lt 35 ]]
    then
        export DISPLAY=:0.0
        notify-send -i "$PWD/battery_low.png" "Battery LOW" "Level: ${battery_percentage}%";
        espeak "Battery Low, Please Connect the Adapter" -s 150
    fi

    sleep 60 # (1 minutes)
done
