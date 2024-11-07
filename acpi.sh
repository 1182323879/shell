#!/bin/bash

state=$(acpi -b | awk -F : '{ print $2 }' | awk -F , '{print $1}' | tr -d " " )
value=$(acpi -b | awk -F , '{ print $2 }' | tr -d "%" )

echo "$state"

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


echo "$percent$state$value%"
