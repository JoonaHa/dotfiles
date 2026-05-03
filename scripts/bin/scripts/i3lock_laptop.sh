#!/bin/bash

TEMPDIR=/tmp

xdpyinfo -ext XINERAMA | sed '/^  head #/!d;s///' |
while IFS=' :x@,' read i w h x y; do
    grim -c -g "$x,$y ${w}x$h" /tmp/head_$i.png
#    import -window root -crop ${w}x$h+$x+$y /tmp/head_$i.png
done
convert $TEMPDIR/head_0.png -scale 10% -scale 1000% $TEMPDIR/head_0.png
[[ -f $HOME/.bin/scripts/lock.png ]] && convert $TEMPDIR/head_0.png $HOME/.bin/scripts/lock.png  -gravity center -composite -matte $TEMPDIR/head_0.png
if [ -e $TEMPDIR/head_1.png ]; then
  convert $TEMPDIR/head_1.png -scale 10% -scale 1000% $TEMPDIR/head_1.png
  [[ -f $HOME/.bin/scripts/lock.png  ]] && convert $TEMPDIR/head_1.png $HOME/.bin/scripts/lock.png  -gravity center -composite -matte $TEMPDIR/head_1.png
  convert $TEMPDIR/head_0.png $TEMPDIR/head_1.png +append $TEMPDIR/screen.png
else
  mv $TEMPDIR/head_0.png $TEMPDIR/screen.png
fi
#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
swaylock -i $TEMPDIR/screen.png -f

