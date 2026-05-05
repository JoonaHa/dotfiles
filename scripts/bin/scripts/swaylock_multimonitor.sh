#!/usr/bin/env bash
#set -x

MONITOR_DATA=$(wlr-randr | awk '
  /^[^[:space:]]/ {
    monitor = $1
    enabled = 0; w = ""; h = ""; x = ""; y = ""
  }
  /Enabled: yes/ { enabled = 1 }
  /current\)/    { w = $1; sub(/x/, " ", w); split(w, res, " "); w = res[1]; h = res[2] }
  /Position:/    { split($2, pos, ","); x = pos[1]; y = pos[2] }
  enabled && w != "" && x != "" {
    print monitor, x, y, w, h
    enabled = 0; w = ""; h = ""; x = ""; y = ""
  }
')

NORM=""
LOCKARGS=""
while read -r monitor _ _ _ _; do
    IMAGE=/tmp/$monitor-lock.png
    grim -o "$monitor" "$IMAGE"
    if [ -f $IMAGE ]
    then 
      convert "$IMAGE" -scale 10% -scale 1000% "$IMAGE"
      LOCKARGS="${LOCKARGS} --image ${monitor}:${IMAGE}"
      IMAGES="${IMAGES} ${IMAGE}"
    else
      LOCKARGS="-c 000000"
      NORM=1
done <<< "$MONITOR_DATA"


#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
swaylock -f $LOCKARGS
if [ -z  "$NORM" ]
then
    rm $IMAGES
fi
