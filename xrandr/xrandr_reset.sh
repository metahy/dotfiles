#!/usr/bin/env bash
m_count=$(xrandr -q | grep -wc connected)
if [[ $m_count == 2 ]]; then
   pri="eDP-1-1"
   sec=$(xrandr -q | grep -w connected | grep -v $pri | awk '{print $1}')
   xrandr --output "$pri" --primary --auto --scale 1.0x1.0 --output "$sec" --right-of "$pri" --auto --scale 1.0x1.0
else
   xrandr --output "$pri" --primary --auto --scale 1.0x1.0 "$(xrandr -q | awk '/ disconnected/ {print "--output", $1, "--off"}' | paste -sd ' ')"
fi