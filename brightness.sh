#!/bin/bash

value=$(cat brightness)

case $1 in
up)
	value=$(expr $value + 1 );;
down)
	value=$(expr $value - 1 );;
esac
	
if [ $value -gt 10 ]
then
	value=10

elif [ $value -lt 1 ]
then
	value=1
fi
	echo $value > brightness

	
case $value in
10)
	xrandr --output eDP --brightness 1.0;;
9)
	xrandr --output eDP --brightness 0.9;;
8)
	xrandr --output eDP --brightness 0.8;;
7)
	xrandr --output eDP --brightness 0.7;;
6)
	xrandr --output eDP --brightness 0.6;;
5)
	xrandr --output eDP --brightness 0.5;;
4)
	xrandr --output eDP --brightness 0.4;;
3)
	xrandr --output eDP --brightness 0.3;;
2)
	xrandr --output eDP --brightness 0.2;;
1)
	xrandr --output eDP --brightness 0.1;;
esac
