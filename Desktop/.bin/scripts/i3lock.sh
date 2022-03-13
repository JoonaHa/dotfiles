#!/bin/bash

TEMPDIR=/tmp

sh $HOME/.bin/scripts/induvidual_scrot.sh
convert $TEMPDIR/head_0.png -scale 10% -scale 1000% $TEMPDIR/head_0.png
#[[ -f $HOME/Kuvat/dotfiles/qY1nKlP.png ]] && convert $TEMPDIR/head_0.png $HOME/Kuvat/dotfiles/qY1nKlP.png -gravity center -composite -matte $TEMPDIR/head_0.png
if [ -e $TEMPDIR/head_1.png ]; then
  convert $TEMPDIR/head_1.png -scale 10% -scale 1000% $TEMPDIR/head_1.png
#  [[ -f $HOME/Kuvat/dotfiles/qY1nKlP.png ]] && convert $TEMPDIR/head_1.png $HOME/Kuvat/dotfiles/qY1nKlP.png -gravity center -composite -matte $TEMPDIR/head_1.png
  #convert $TEMPDIR/head_0.png $TEMPDIR/head_1.png +append $TEMPDIR/screen.png
  convert +append -gravity center $TEMPDIR/head_0.png $TEMPDIR/head_1.png $TEMPDIR/screen.png
else
  mv $TEMPDIR/head_0.png $TEMPDIR/screen.png
fi
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -i $TEMPDIR/screen.png -p default

