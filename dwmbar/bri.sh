#!/bin/bash

value=$(xrandr --verbose | grep -i brightness | awk '{printf "%.0f\n", $2*100 }')

case "$1" in
up)
  value=$(expr $value + 5)
  if [ $value -gt 100 ]; then
    value=100
  fi
  brightness_value=$(echo $value | awk '{printf "%.2f\n", $1/100 }')
  xrandr --output eDP --brightness $brightness_value
  cd /home/cmsx/.dwm/dwmbar
  sh /home/cmsx/.dwm/dwmbar/bar.sh update
  ;;
down)
  value=$(expr $value - 5)
  if [ $value -lt 5 ]; then
    value=5
  fi
  brightness_value=$(echo $value | awk '{printf "%.2f\n", $1/100 }')
  xrandr --output eDP --brightness $brightness_value
  cd /home/cmsx/.dwm/dwmbar
  sh /home/cmsx/.dwm/dwmbar/bar.sh update
  ;;
esac

text=$(xrandr --verbose | grep -i brightness | awk '{printf "%.0f%%\n", $2*100 }')

if [[ $value -le 50 ]]; then
  icon="󰃟 "
else
  icon="󰃠 "
fi

sed -i '/brightness/d' ./bar

printf "export brightness='%s %s'\n" $icon $text >>bar
