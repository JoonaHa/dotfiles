#!/bin/bash
# changeVolume

# Arbitrary but unique message tag
msgTag="volume"

#https://wiki.archlinux.org/title/Dunst#Using_dunstify_as_volume.2Fbrightness_level_indicator
# Query amixer for the current volume and whether or not the speaker is muted
volume="$(pamixer --get-volume)"
mute="$(pamixer --get-mute)"
if [[ $volume == 0 || "$mute" == "true" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
fi
# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
