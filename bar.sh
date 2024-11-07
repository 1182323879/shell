#!/bin/sh

# Define the functions to get the information
dwm_date () {
    date=$(date "+%Y-%m-%d %H:%M:%S")
    echo -n "$date"
}

dwm_cpu () {
    cpu=$(grep -o "^[^ ]*" /proc/loadavg)
    echo -n " $cpu"
}

dwm_mem () {
    mem=$(free -h |grep 内存 | awk '{print $3 "/" $2}')
    echo -n "󱤓 $mem"
}

dwm_disk () {
    disk=$(df -h / | awk '/\// {print $(NF-1)}')
    echo -n " $disk"
}

dwm_vol () {
sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
vol=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
mute=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no' | awk '{print $2}')

if [ "$mute" = no ] ; then
        mute="󰕾 "
else
        mute="󰖁 "
fi

echo -n "$mute$vol%"
}

dwm_battery () {
state=$(acpi -b | awk -F : '{ print $2 }' | awk -F , '{print $1}' | tr -d " " )
value=$(acpi -b | awk -F , '{ print $2 }' | tr -d "%" )

if [ "$state" = "Charging" ]; then
    state="󱐋"
else
    state="󰚦"
fi

if [ $value -lt 10 ] ; then
        percent="󰂃"
elif [ $value -lt 20 ] ; then
        percent="󰁺"
elif [ $value -lt 30 ] ; then
        percent="󰁻"
elif [ $value -lt 40 ] ; then
        percent="󰁼"
elif [ $value -lt 50 ] ; then
        percent="󰁽"
elif [ $value -lt 60 ] ; then
        percent="󰁾"
elif [ $value -lt 70 ] ; then
        percent="󰁿"
elif [ $value -lt 80 ] ; then
        percent="󰂀"
elif [ $value -lt 90 ] ; then
        percent="󰂁"
elif [ $value -lt 95 ] ; then
        percent="󰂂"
else
        percent="󰁹"
fi

echo -n "$percent$state$value%"
}

dwm_brightness () {
	value=$(cat ./brightness)

	if [ $value -lt 3 ] ; then
		icon="󰃞 "
	elif [ $value -lt 7 ] ; then
		icon="󰃟 "
	else
		icon="󰃠 "
	fi

	echo -n "$value"0%"$icon"
}




# Update the status bar every two seconds
while true
do
    # Append the results of each function to the bar string
    bar=""
    bar="$bar$(dwm_cpu)|"
    bar="$bar$(dwm_mem)|"
    bar="$bar$(dwm_disk)|"
    bar="$bar$(dwm_vol)|"
    bar="$bar$(dwm_brightness)|"
    bar="$bar$(dwm_battery)|"
    bar="$bar$(dwm_date)"

    # Set the root window name to the bar string
    xsetroot -name "$bar"
    sleep 1
done

