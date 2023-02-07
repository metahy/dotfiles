#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

m_count=$(xrandr -q | grep -wc connected)
pri="eDP-1-1"
gpu_mode=$(optimus-manager --print-mode | awk '{print $5}')
if [[ $gpu_mode == "integrated" ]]; then
    pri="eDP-1"
fi
if [[ $m_count == 2 ]]; then
    MONITOR=$pri polybar pri_top 2>&1 | tee -a /tmp/polybar_pri_top.log & disown

    sec=$(xrandr -q | grep -w connected | grep -v $pri | awk '{print $1}')
    MONITOR=$sec polybar sec_top 2>&1 | tee -a /tmp/polybar_sec_top.log & disown
else
    MONITOR=$pri polybar single_top 2>&1 | tee -a /tmp/polybar_single_top.log & disown
fi

echo "Bars launched..."
