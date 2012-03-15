# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Check for an interactive session
[ -z "$PS1" ] && return

PS1='[\u@\h \W]\$ '

# VCS stuff
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vi
export SVN_EDITOR=vi

export EDITOR=vim
export PATH="/usr/local/bin:$PATH"

export TERM="xterm-256color"

# alias ls='ls --color=auto'
alias vi='vim'

# sync visidev to latest Perforce
alias visidev="ssh root@visidev.iocom.com 'cd /; p4 sync'"
