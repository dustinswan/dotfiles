#!/bin/bash
while true; do
    few -m; mbsync -a; notmuch new
    sleep 45
done
