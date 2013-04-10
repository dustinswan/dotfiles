#!/bin/sh

#screen
SCRH=`xrandr | awk '/current/ { print $8 }'`
SCRW=`xrandr | awk '/current/ { print $10 }' | sed 's/,//'`
#SCRW=${SCRW%\.}

#gif
IMGHW=`gifsicle --info $1 | awk '/logical/ { print $3 }'`
IMGH=${IMGHW%x*}
IMGW=${IMGHW#*x}

#position
POSH=$((($SCRH/2)-($IMGH/2)))
POSW=$((($SCRW/2)-($IMGW/2)))

xwinwrap -g ${IMGHW}+${POSH}+${POSW} -ov -ni -s -nf -- gifview -w WID $1 -a
