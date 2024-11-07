#!/bin/bash

cd /home/cmsx/.dwm/dwmbar/

if [ -f "bar" ]; then
  brightness_value=$(cat bar | grep brightness | awk '{printf "%.2f\n" , $3/100}')
  xrandr --output eDP --brightness $brightness_value
  echo ' ' >bar
else
  touch bar
  echo "export brightness='󰃠 100%'" >bar
fi

update() {

  brightness=' '
  cpu=' '
  date_time=' '
  disk=' '
  mem=' '
  vol=' '

  sh bri.sh
  sh cpu.sh
  sh date.sh
  sh disk.sh
  sh mem.sh
  sh vol.sh

  source ./bar

  xsetroot -name "$cpu|$mem|$disk|$brightness|$vol|$date_time"

}

while true; do
  update
  sleep 5
done
