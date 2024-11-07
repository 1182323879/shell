#!/bin/bash

sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
value=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
mute=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | awk '{print $2}')

if [ "$mute" = "no" ]; then
  icon="󰕾 "
else
  icon="󰖁 "
fi

sed -i '/vol/d' bar

printf "export vol='%s %s'\n" $icon $value >>bar
