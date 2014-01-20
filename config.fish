alias vi vim
alias l "ls -la"
alias tmux "tmux -2"
alias ta "tmux attach"
alias dustinswan "mosh dustinswan@dustinswan.org"
set -x EDITOR "vim"
set -x TERM "screen-256color"
set -x BROWSER "open"

# PATH
set -x PATH /usr/local/bin /usr/local/sbin $PATH# Homebrew
set -x PATH $PATH $HOME/Library/Haskell/bin # Haskell
set -x PATH $PATH $HOME/dotfiles/bin # Dotfiles bin
set -x PATH $PATH /usr/local/share/npm/bin # npm
set -x NODE_PATH $NODE_PATH /usr/local/lib/node

# IOCOM stuff
set -x P4USER "dswan"
set -x P4PORT "humu.insors.net:1666"
set -x P4CONFIG "p4.cfg"
set -x P4EDITOR "vim"
alias visidev "ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias dswan "ssh root@dswan.insors.net"
alias webdev 'ssh -t root@webdev.insors.net "cd /var/www/html; /bin/bash -i"'

# TODO chruby fish

# GPG
~/dotfiles/bin/gpg-agent.sh
