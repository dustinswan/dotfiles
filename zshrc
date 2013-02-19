PROMPT="%~ > "

alias vi=vim
alias tmux="tmux -2"
export EDITOR=vim
export BROWSER=luakit

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

export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH # Postgres
export PATH=$HOME/Library/Haskell/bin:$PATH # Haskell
export PATH=$HOME/dotfiles/bin:$PATH # Dotfiles bin
export PATH=$HOME/.rbenv/bin:$PATH # rbenv
eval "$(rbenv init -)"
