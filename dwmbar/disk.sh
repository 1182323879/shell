#!/bin/bash

disk_usage=$(df -h / | awk '/\// {print $(NF-1)}')

disk_over=$(df -h / | awk '/\// {print $(NF-2)}')

sed -i '/disk/d' bar

#printf "export disk='%s %s'\n" $disk_over $disk_usage >>bar
printf "export disk=' %s'\n" $disk_over >>bar
