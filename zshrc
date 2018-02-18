# source ~/dotfiles/antigen.zsh
source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
# antigen theme S1cK94/minimal minimal
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship
antigen apply

autoload -U select-word-style
select-word-style bash

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

bindkey -e

alias l="ls -la"
alias ta="tmux attach -d"
alias e='emacsclient -a "" -t -nw'
alias emacs='emacs -q' # typing 'emacs' should not load any config
alias weather='curl http://wttr.in'

# nvim
if [ -x "$(command -v nvim)" ]; then
    alias vi=nvim
    alias vim=nvim
    export EDITOR=nvim
else
    alias vi=vim
    export EDITOR=vim
fi

# Mac only
[ -x "$(command -v open)" ] && export BROWSER=open

# IOCOM stuff
alias er='rm -rf logs; unzip -o'
if [ -x "$(command -v p4)" ]; then
    export P4USER=dswan
    export P4PORT="humu.iocom.com:1666"
    export P4CONFIG=p4.cfg
    export P4EDITOR=vim
    export P4IGNORE=.ignore
fi

# PATH
[ -e ~/dotfiles/bin ] && export PATH=$HOME/dotfiles/bin:$PATH
[ -e ~/.local/bin ] && export PATH=$HOME/.local/bin:$PATH # Stack
[ -e ~/.npm-packages/bin ] && export PATH=$HOME/.npm-packages/bin:$PATH # NPM

# Keychain
if [ -x "$(command -v keychain)" ]; then
    export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1" # Take this out when keychain fixes this bug
    eval `keychain --eval --inherit any --agents gpg,ssh --quiet id_rsa 2B3A6377`
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm2
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

# Chruby
[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ] && source /usr/local/opt/chruby/share/chruby/chruby.sh
[ -f /usr/local/opt/chruby/share/chruby/auto.sh ] && source /usr/local/opt/chruby/share/chruby/auto.sh

# Colored Man Pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}
