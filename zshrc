bindkey -e

alias vi=vim
alias l="ls -la"
alias tmux="tmux -2"
alias ta="tmux attach -d"
alias dustinswan="mosh dustinswan@dustinswan.org"
alias kill_offlineimap="ps aux | grep offlineimap | awk '{ print $2 }' | xargs kill -9"
alias em='emacsclient -a "" -t'
export EDITOR="emacsclient -a "" -t"
export TERM="screen-256color"
export MOSH_TITLE_NOPREFIX=1

export BROWSER=open
[[ -s luakit ]] && export BROWSER=luakit

# IOCOM stuff
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias p4vimdiff "set -x P4DIFF vimdiff; p4 diff"
alias visidev="ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias dswan="ssh root@dswan.insors.net"
alias er='rm -rf logs; unzip -o'

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=~/.cabal/bin:$PATH
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/lib/node:/usr/local/share/npm/lib/node_modules
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# Nix
. $HOME/.nix-profile/etc/profile.d/nix.sh

# Chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
#chruby $(cat ~/.ruby-version)

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

#autoload predict-on
#predict-on

eval `keychain --eval id_rsa`

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
