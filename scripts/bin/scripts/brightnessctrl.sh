#!/bin/bash
set -x

file=/tmp/brightness
percent=$1 

if [ ! -f "$file" ]
then
    touch "$file"
fi

old=$(cat "$file")

if [ -z "$old" ] && [ ! -z "$percent" ]
then
    BRIGHT=$(brightnessctl -c backlight get); 
    brightnessctl -c backlight set "$percent"%;
    cat <<< "$BRIGHT" > "$file";
else
    brightnessctl -c backlight set "$old";
    cat /dev/null > /tmp/brightness;
fi
