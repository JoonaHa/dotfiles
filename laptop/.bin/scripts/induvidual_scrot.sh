#!/bin/sh
xdpyinfo -ext XINERAMA | sed '/^  head #/!d;s///' |
while IFS=' :x@,' read i w h x y; do
    grim -c -g "$x,$y ${w}x$h" /tmp/head_$i.png
#    import -window root -crop ${w}x$h+$x+$y /tmp/head_$i.png
done

