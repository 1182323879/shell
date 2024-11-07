#!/bin/sh

case "$(date '+%I')" in
"01")
  icon=""
  ;;
"02")
  icon=""
  ;;
"03")
  icon=""
  ;;
"04")
  icon=""
  ;;
"05")
  icon=""
  ;;
"06")
  icon=""
  ;;
"07")
  icon=""
  ;;
"08")
  icon=""
  ;;
"09")
  icon=""
  ;;
"10")
  icon=""
  ;;
"11")
  icon=""
  ;;
"12")
  icon=""
  ;;
esac

date_time=$(date +" %m/%d $icon %H:%M")
sed -i '/date_time/d' bar
printf "export date_time='%s'\n" "$date_time" >>bar
