#!/usr/bin/env bash
#set -x

LOCKARGS=""
NORM=""
for OUTPUT in $(swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name')

do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o "$OUTPUT" "$IMAGE"
    if [ -f $IMAGE ]
    then 
        convert "$IMAGE" -scale 10% -scale 1000% "$IMAGE"
        LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
        IMAGES="${IMAGES} ${IMAGE}"
    else
        LOCKARGS="-c 000000"
        NORM=1
    fi
done

#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
swaylock -f $LOCKARGS

if [ -z  "$NORM" ]
then
    rm $IMAGES
fi
