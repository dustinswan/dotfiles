# Start tmux... just trying it out
# if [ "$TMUX" = "" ]; then tmux; fi

# Powerline
[[ -s /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
[[ -s /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]] && . /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

alias vi=vim
alias tmux="tmux -2"
export EDITOR=vim
export BROWSER=open
[[ -s luakit ]] && export BROWSER=luakit

# VCS stuff
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
export SVN_EDITOR=vim

# IOCOM stuff
# sync visidev to latest Perforce
alias visidev="ssh root@visidev.iocom.com 'cd /; p4 sync'"
alias dswan="ssh root@dswan.insors.net"
alias webdev='ssh -t root@webdev.insors.net "cd /var/www/html; /bin/bash -i"'
alias sprites="pushd ~/smartsprites; ./smartsprites.sh --root-dir-path /opt/iocom/user/webclient/; popd; p4 edit /opt/iocom/user/webclient/css/iocom-sprite.css"
#export TERM="xterm-256color"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH # Postgres
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH # Haskell
export PATH=$HOME/dotfiles/bin:$PATH # Dotfiles bin
export PATH=$HOME/.rbenv/bin:$PATH # rbenv
eval "$(rbenv init -)"
