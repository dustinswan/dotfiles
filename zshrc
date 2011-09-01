HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

zstyle :compinstall filename '/home/dustinswan/.zshrc'

autoload -Uz compinit
compinit

alias vi=vim
# alias grep='grep --color=auto'
# alias ls='ls --color=auto'

export TERM="xterm-256color"

export EDITOR=vim
