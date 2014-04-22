#!/bin/sh
tmux split-window -l 5 mopidy
tmux select-pane -U
tmux rename-window ♫
ncmpcpp
