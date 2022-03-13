#!/usr/bin/env bash
#PS4='$LINENO: '
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar
echo "---" >> tee -a /tmp/polybar.log

if type xrandr > /dev/null; then
  PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
  OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

  export TRAY_POSITION=right
  MONITOR=$PRIMARY polybar -r bottom >>/tmp/polybar.log 2>&1 & disown

  for m in $OTHERS; do
    export TRAY_POSITION=none
    MONITOR=$m polybar -r bottom >>/tmp/polybar.log 2>&1 & disown
  done

else
  polybar -r bottom >>/tmp/polybar.log 2>&1 & disown
fi
