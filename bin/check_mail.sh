#!/bin/bash
while true; do
    few -m; mbsync iocom; notmuch new
    sleep 45
done
