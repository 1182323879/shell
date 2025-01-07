#!/bin/bash


value=$(acpi -b | awk -F , '{ print $2 }' | tr -d "%" )

text=$(acpi -b | awk -F , '{ print $2 }')

state=$(acpi -b | awk -F : '{ print $2 }' | awk -F , '{print $1}' | tr -d " " )

case "state" in
	Charging)
if [ $value -lt 20 ] ; then
	icon="󰢟"
elif [ $value -lt 40 ] ; then
	icon="󱊤"
elif [ $value -lt 80 ] ; then
	icon="󱊥"
else 
	icon="󱊦"
fi
		;;
	*)
if [ $value -lt 20 ] ; then
	icon="󰂎"
elif [ $value -lt 40 ] ; then
	icon="󱊡"
elif [ $value -lt 80 ] ; then
	icon="󱊢"
else 
	icon="󱊣"
fi
		;;
esac


sed -i '/battery/d' ./bar

printf "export battery='%s %s'\n" $icon $text >>bar
