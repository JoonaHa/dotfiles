#!/usr/bin/env bash
#set -x

LOCKARGS=""
for OUTPUT in $(swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name')
do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o "$OUTPUT" "$IMAGE"
    convert "$IMAGE" -scale 10% -scale 1000% "$IMAGE"
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
    IMAGES="${IMAGES} ${IMAGE}"
done

#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
swaylock $LOCKARGS
rm $IMAGES
