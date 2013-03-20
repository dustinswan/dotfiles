# Start tmux... just trying it out
# if [ "$TMUX" = "" ]; then tmux; fi

# powerline-shell
function powerline_precmd() {
  export PS1="$(~/dotfiles/powerline-shell/powerline-shell.py $? --shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

install_powerline_precmd

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

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
alias sprites="pushd ~/smartsprites; ./smartsprites.sh --root-dir-path /opt/iocom/user/webclient/; popd; p4 edit /opt/iocom/user/webclient/css/iocom-sprite.css"
#export TERM="xterm-256color"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH # Postgres
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH # Haskell
export PATH=$HOME/dotfiles/bin:$PATH # Dotfiles bin
export PATH=$HOME/.rbenv/bin:$PATH # rbenv
eval "$(rbenv init -)"
