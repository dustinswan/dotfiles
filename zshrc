source ~/dotfiles/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen theme S1cK94/minimal minimal
antigen apply

autoload -U select-word-style
select-word-style bash

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

bindkey -e

alias vi=nvim
alias vim=nvim
alias l="ls -la"
alias ta="tmux attach -d"
alias dustinswan="ssh dustinswan@dustinswan.com"
alias kill_offlineimap="ps aux | grep offlineimap | awk '{ print $2 }' | xargs kill -9"
alias e='emacsclient -a "" -t -nw'
alias weather='curl http://wttr.in'

export EDITOR=nvim
export MOSH_TITLE_NOPREFIX=1

export BROWSER=open

# IOCOM stuff
alias dswan="ssh root@dswan.insors.net"
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias er='rm -rf logs; unzip -o'

# PATH
export PATH=$HOME/.local/bin:$PATH # Stack
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=$HOME/.npm-packages/bin:$PATH
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

# Keychain
eval `keychain --eval id_rsa`

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
