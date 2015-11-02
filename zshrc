source ~/dotfiles/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen theme S1cK94/minimal minimal
export ZSH_THEME="minimal"

autoload -U select-word-style
select-word-style bash

bindkey -e

alias vi=nvim
alias vim=nvim
alias l="ls -la"
alias ta="tmux attach -d"
alias dustinswan="ssh dustinswan@dustinswan.com"
alias kill_offlineimap="ps aux | grep offlineimap | awk '{ print $2 }' | xargs kill -9"
alias e='emacsclient -a "" -t'
export EDITOR=nvim
export TERM="screen-256color"
export MOSH_TITLE_NOPREFIX=1

export BROWSER=open
[[ -s luakit ]] && export BROWSER=luakit

# IOCOM stuff
alias dswan="ssh root@dswan.insors.net"
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias er='rm -rf logs; unzip -o'

# PATH
export PATH=/usr/texbin:$PATH # Basictex
export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/lib/node:/usr/local/share/npm/lib/node_modules
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

# Keychain
eval `keychain --eval id_rsa`

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
