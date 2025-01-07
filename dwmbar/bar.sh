#!/bin/bash

cd /home/cmsx/.dwm/dwmbar/

update() {

  brightness=' '
  cpu=' '
  date_time=' '
  disk=' '
  mem=' '
  vol=' '
  battery=' '

  sh bri.sh
  sh cpu.sh
  sh date.sh
  sh disk.sh
  sh mem.sh
  sh vol.sh
  sh battery.sh

  source ./bar

  xsetroot -name "[$cpu][$mem][$disk][$brightness][$vol][$date_time][$battery]"

}

start() {

  cd /home/cmsx/.dwm/dwmbar/

  if [ -f "bar" ]; then
    brightness_value=$(cat bar | grep brightness | awk '{printf "%.2f\n" , $3/100}')
    xrandr --output eDP --brightness $brightness_value
    echo ' ' >bar
  else
    touch bar
    echo "export brightness='󰃠 100%'" >bar
  fi

  while true; do
    update
    sleep 5
  done
}

case "$1" in
update)
  update
  ;;
start)
  start
  ;;
esac
