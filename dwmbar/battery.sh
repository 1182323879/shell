#!/bin/bash


value=$(acpi -b | awk -F , '{ print $2 }' | tr -d "%" )

text=$(acpi -b | awk -F , '{ print $2 }')

battery=$(acpi -b | awk -F : '{ print $2 }' | awk -F , '{print $1}' | tr -d " " )

plug=$(acpi -V | grep Adapter | awk '{print $3}' )

case "$plug" in
	on-line)
		plug_icon=
		;;
	off-line)
		plug_icon=󱐤
		;;
esac

case "$state" in
	Charging)
if [ $value -lt 20 ] ; then
	battery_icon="󰢟"
elif [ $value -lt 40 ] ; then
	battery_icon="󱊤"
elif [ $value -lt 80 ] ; then
	battery_icon="󱊥"
else 
	battery_icon="󱊦"
fi
		;;
	*)
if [ $value -lt 20 ] ; then
	battery_icon="󰂎"
elif [ $value -lt 40 ] ; then
	battery_icon="󱊡"
elif [ $value -lt 80 ] ; then
	battery_icon="󱊢"
else 
	battery_icon="󱊣"
fi
		;;
esac


sed -i '/battery/d' ./bar

printf "export battery='%s%s %s'\n" $plug_icon $battery_icon $text >>bar
