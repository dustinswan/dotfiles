#!/bin/sh
tmux split-window -l 5 check_mail.sh
tmux select-pane -U
tmux rename-window ✉
alot
