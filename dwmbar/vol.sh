#!/bin/bash

case "$1" in
up)
  pactl set-sink-volume @DEFAULT_SINK@ +5%
  cd /home/cmsx/.dwm/dwmbar
  sh /home/cmsx/.dwm/dwmbar/bar.sh update
  ;;
down)
  pactl set-sink-volume @DEFAULT_SINK@ -5%
  cd /home/cmsx/.dwm/dwmbar
  sh /home/cmsx/.dwm/dwmbar/bar.sh update
  ;;
mute)
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  cd /home/cmsx/.dwm/dwmbar
  sh /home/cmsx/.dwm/dwmbar/bar.sh update
  ;;
esac

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
