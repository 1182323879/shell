#!/bin/bash

mem_text=$(free -h | grep 内存 | awk '{print $3 "/" $2"\n" }')

mem_usage=$(free | grep 内存 | awk '{printf "%d%%\n" , ($3/$2)*100 }')

sed -i '/mem/d' bar

printf "export mem=' %s'\n" $mem_usage >>bar
