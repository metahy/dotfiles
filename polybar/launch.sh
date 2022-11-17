#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

m_count=$(xrandr -q | grep -wc connected)
if [[ $m_count == 2 ]]; then
    polybar pri_top 2>&1 | tee -a /tmp/polybar_pri_top.log & disown

    pri="eDP-1-1"
    sec=$(xrandr -q | grep -w connected | grep -v $pri | awk '{print $1}')
    MONITOR=$sec polybar sec_top 2>&1 | tee -a /tmp/polybar_sec_top.log & disown
else
    polybar single_top 2>&1 | tee -a /tmp/polybar_single_top.log & disown
fi

echo "Bars launched..."
