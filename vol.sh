#!/bin/bash

sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
vol=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
mute=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no')

echo -n "$mute"

if [ "$mute" = "Mute: no" ]; then
  mute="󰕾 "
else
  mute="󰖁 "
fi

echo -n "$mute$vol%"
