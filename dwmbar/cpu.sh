#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* 闲.*/\1/" | awk '{print 100 - $1"%"}')

cpu_temp=$(sensors | grep Tctl | awk '{printf "%d°C\n", $2}')

sed -i '/cpu/d' bar

printf "export cpu=' %s  %s'\n" "$cpu_usage" "$cpu_temp" >>bar
