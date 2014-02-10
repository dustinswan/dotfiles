alias vi vim
alias l "ls -la"
alias tmux "tmux -2"
alias ta "tmux attach -d"
alias dustinswan "mosh dustinswan@dustinswan.org"
set -x EDITOR "vim"
set -x TERM "screen-256color"
# TODO fix this for linux
set -x BROWSER "open"
alias browser "eval $BROWSER"
set -x MOSH_TITLE_NOPREFIX 1

# PATH
set -x PATH /usr/local/bin /usr/local/sbin $PATH # Homebrew
set -x PATH $PATH $HOME/Library/Haskell/bin # Haskell
set -x PATH $PATH $HOME/dotfiles/bin # Dotfiles bin
set -x PATH $PATH /usr/local/share/npm/bin # npm
set -x NODE_PATH $NODE_PATH /usr/local/lib/node
set -x PYTHONPATH $PYTHONPATH /usr/local/lib/python2.7/site-packages

# IOCOM stuff
set -x P4USER "dswan"
set -x P4PORT "humu.insors.net:1666"
set -x P4CONFIG "p4.cfg"
set -x P4EDITOR "vim"
alias visidev "ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias dswan "ssh root@dswan.insors.net"
alias webdev 'ssh -t root@webdev.insors.net "cd /var/www/html; /bin/bash -i"'

# chruby-fish: https://github.com/JeanMertz/chruby-fish
. /usr/local/share/chruby/chruby.fish
# source /usr/local/share/chruby/auto.fish # SERIOUSY BROKEN

# GPG
~/dotfiles/bin/gpg-agent.sh
