#!/bin/bash

INTERFACE=en0
OUI="$HOME/dotfiles/bin/oui.txt"
OUI_LEN=19004

R=$(((RANDOM % ${OUI_LEN})+1))
PREFIX=`head -$R $OUI | tail -1`
CMD="sudo ifconfig ${INTERFACE} ether ${PREFIX}:"
for i in `seq 1 6`; do
    R=$(((RANDOM % 15)+1))
    C=`echo "obase=16; $R" | bc`
    CMD="$CMD$C"
    if [ $((i % 2)) = 0 ] && [ $i != 6 ]; then
        CMD="$CMD:"
    fi
done
RESULT=`$CMD`
echo $CMD
