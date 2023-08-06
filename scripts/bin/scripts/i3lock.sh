#!/usr/bin/env bash

TEMPDIR=/tmp

while IFS=' :x@,' read i w h x y; do
    import -window root -crop ${w}x$h+$x+$y $TEMPDIR/head_$i.png
    convert $TEMPDIR/head_$i.png -scale 5% -scale 2000% $TEMPDIR/head_$i.png
    picture_paths=" $picture_paths $TEMPDIR/head_$i.png"
done <<< "$(xdpyinfo -ext XINERAMA | sed '/^  head #/!d;s///')"
# If theres more than one image. Combine them
if [ -e $TEMPDIR/head_1.png ]; then
  convert +append -gravity center $picture_paths $TEMPDIR/screen.png
else
  mv $TEMPDIR/head_0.png $TEMPDIR/screen.png
fi
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -i $TEMPDIR/screen.png -p default

