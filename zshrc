# Powerline
# Mac
[[ -s /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# Linux
[[ -s /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

bindkey -e

alias vi=vim
alias l="ls -la"
alias tmux="tmux -2"
alias dustinswan="mosh dustinswan@dustinswan.org"
export EDITOR=vim
export TERM="screen-256color"

export BROWSER=open
[[ -s luakit ]] && export BROWSER=luakit

alias browse='open'
[[ -s luakit ]] && alias browse='luakit'

# IOCOM stuff
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias visidev="ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias dswan="ssh root@dswan.insors.net"
alias webdev='ssh -t root@webdev.insors.net "cd /var/www/html; /bin/bash -i"'

export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH # Postgres
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH # Haskell
export PATH=$HOME/dotfiles/bin:$PATH # Dotfiles bin
export PATH=/usr/local/share/npm/bin:$PATH # npm
export NODE_PATH=/usr/local/lib/node

# Chruby
if [[ -e /usr/local/share/chruby ]]; then
    source '/usr/local/share/chruby/chruby.sh'
    source '/usr/local/share/chruby/auto.sh'
fi
if [[ -e /usr/share/chruby ]]; then
    source /usr/share/chruby/chruby.sh
    source /usr/share/chruby/auto.sh
fi
chruby $(cat ~/.ruby-version)

# GPG
~/dotfiles/bin/gpg-agent.sh
