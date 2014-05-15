#!/bin/bash
~/dotfiles/bin/notmuch_osx_menubar_count.rb &
while true; do
    afew -m; offlineimap; notmuch new
    sleep 45
done
