#!/bin/bash
while true; do
    afew -m; mbsync -a; notmuch new
    sleep 45
done
