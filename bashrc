# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias vi='vim'
PS1='[\u@\h \W]\$ '
