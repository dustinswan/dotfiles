#!/bin/sh

for id in `xinput --list|grep 'Logitech Gaming Mouse G502'|perl -ne 'while (m/id=(\d+)/g){print "$1\n";}'`; do
    xinput set-prop $id "Device Accel Velocity Scaling" 1
    xinput set-prop $id "Device Accel Constant Deceleration" 1.2
    xinput set-button-map $id 1 2 3 5 4 # "natural" scrolling
done
