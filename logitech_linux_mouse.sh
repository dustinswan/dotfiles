#!/bin/sh

for id in `xinput --list|grep 'MX Master 2S'|perl -ne 'while (m/id=(\d+)/g){print "$1\n";}'`; do
    xinput set-prop $id "Device Accel Velocity Scaling" 1
    xinput set-prop $id "Device Accel Constant Deceleration" 0.8
    xinput set-button-map $id 1 2 3 5 4 # "natural" scrolling
done
