#!/bin/bash

# 获取电池路径
battery_path=$(upower -e | grep 'BAT')

# 如果找到电池设备
if [ -n "$battery_path" ]; then
  battery_info=$(upower -i "$battery_path")
  state=$(echo "$battery_info" | grep 'state' | awk '{print $2}')
  capacity=$(echo "$battery_info" | grep 'percentage' | awk '{print $2}' | tr -d '%')
  time_to_full=$(echo "$battery_info" | grep 'time to full' | awk '{print $4, $5}')
  time_to_empty=$(echo "$battery_info" | grep 'time to empty' | awk '{print $4, $5}')

  if [ "$state" == "charging" ]; then
    ICON="🔋"
  elif [ "$capacity" -le 25 ]; then
    ICON="⚠️"
  else
    ICON="🔋"
  fi

  echo "$ICON $capacity% ($state)"
else
  echo "找不到电池设备。"
fi
