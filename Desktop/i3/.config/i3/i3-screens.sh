#!/usr/bin/env bash
# Set scaling
#for output in $(xrandr --prop | grep -E -o -i "^[A-Z\-]+-[0-9]+"); do xrandr --output "$output" --set "scaling mode" "Full aspect"; done
xrandr --output DisplayPort-0 --primary --mode 2560x1440 --rate 144 --pos 0x0 --rotate normal \
    --set "scaling mode" "Full aspect" --auto --output HDMI-A-1 --set "scaling mode" "Full aspect" --mode 1920x1080 --rate 60 --pos 2560x180 \
    --rotate normal --auto --output HDMI-A-0 --off --output DisplayPort-1 --off
