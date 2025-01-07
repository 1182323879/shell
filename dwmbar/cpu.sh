#!/bin/bash

cpu_usage=$(top -b -n1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

cpu_temp=$(sensors | grep Tctl | awk '{printf "%d°C\n", $2}')

sed -i '/cpu/d' bar

printf "export cpu=' %s  %s'\n" "$cpu_usage" "$cpu_temp" >>bar
