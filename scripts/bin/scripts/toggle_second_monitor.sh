#!/bin/bash
set -x

file=/tmp/second_mtr_toggle

if [[ ! -f "$file" ]]
then
    touch "$file"
fi

status=$(cat "$file")
# File empty turn off second monitor
if [[ -z "$status" ]]
then
  nvidia-settings --assign CurrentMetaMode='DP-0: 2560x1440_144 @2560x1440 +0+0 {ViewPortIn=2560x1440,\
    ViewPortOut=2560x1440+0+0}'
  cat <<< "1" > "$file";
# File not empty, turn second monitor back on 
else
  nvidia-settings --assign CurrentMetaMode='DP-0: 2560x1440_144 @2560x1440 +0+0 {ViewPortIn=2560x1440,\
    ViewPortOut=2560x1440+0+0}, HDMI-0: 1920x1080_60 @1920x1080 +2560+18 {ViewPortIn=1920x1080,\
    ViewPortOut=1920x1080+0+0}'
  cat /dev/null > "$file";
fi

