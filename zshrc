# Powerline
# Mac
[[ -s /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# Linux
[[ -s /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

bindkey -e

alias vi=vim
alias l="ls -la"
alias tmux="tmux -2"
alias ta="tmux attach -d"
alias dustinswan="mosh dustinswan@dustinswan.org"
alias kill_offlienimap="ps aux | grep offlineimap | awk '{ print $2 }' | xargs kill -9"
export EDITOR=vim
export TERM="screen-256color"
export MOSH_TITLE_NOPREFIX=1

export BROWSER=open
[[ -s luakit ]] && export BROWSER=luakit

#alias browser='open -a Firefox.app'
#[[ -s luakit ]] && alias browser='luakit'

# IOCOM stuff
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias p4vimdiff "set -x P4DIFF vimdiff; p4 diff"
alias visidev="ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias dswan="ssh root@dswan.insors.net"
alias webdev='ssh -t root@webdev.insors.net "cd /var/www/html; /bin/bash -i"'
alias er='rm -rf logs; unzip -o -P qt'

export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH # Postgres
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH # Haskell
export PATH=$HOME/dotfiles/bin:$PATH # Dotfiles bin
export PATH=/usr/local/share/npm/bin:$PATH # npm
export NODE_PATH=/usr/local/lib/node:/usr/local/share/npm/lib/node_modules
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# Chruby
if [[ -e /usr/local/share/chruby ]]; then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
fi
if [[ -e /usr/share/chruby ]]; then
    source /usr/share/chruby/chruby.sh
    source /usr/share/chruby/auto.sh
fi
chruby $(cat ~/.ruby-version)

# GPG
GPG_AGENT=$(which gpg-agent)
GPG_TTY=`tty`
export GPG_TTY

if [ -f ${GPG_AGENT} ]; then
    . ~/dotfiles/bin/gpg-agent.sh
fi

#autoload predict-on
#predict-on

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
