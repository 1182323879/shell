#!/bin/bash

value=$(xrandr --verbose | grep -i brightness | awk '{printf "%.0f\n", $2*100 }')
text=$(xrandr --verbose | grep -i brightness | awk '{printf "%.0f%%\n", $2*100 }')

if [[ $value -le 50 ]]; then
  icon="󰃟 "
else
  icon="󰃠 "
fi

sed -i '/brightness/d' ./bar

printf "export brightness='%s %s'\n" $icon $text >>bar
