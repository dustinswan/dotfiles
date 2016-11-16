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
alias e='emacsclient -a "" -t -nw'
alias weather='curl http://wttr.in'

export EDITOR=nvim
export BROWSER=open

# IOCOM stuff
export P4USER=dswan
export P4PORT="humu.iocom.com:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias er='rm -rf logs; unzip -o'

# PATH
export PATH=$HOME/.local/bin:$PATH # Stack
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=$HOME/.npm-packages/bin:$PATH

# nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
# export OPENSSL_X509_CERT_FILE=${HOME}/.nix-profile/etc/ssl/certs/ca-bundle.crt
# export OPENSSL_X509_CERT_FILE=~/.ssh/cacert.pem
# export GIT_SSL_CAINFO=${OPENSSL_X509_CERT_FILE}
# export CURL_CA_BUNDLE=${OPENSSL_X509_CERT_FILE}
# export SSL_CERT_FILE=${OPENSSL_X509_CERT_FILE}

# Keychain
export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1" # Take this out when keychain fixes this bug
eval `keychain --eval --inherit any --agents gpg,ssh --quiet id_rsa 2B3A6377`

# Homebrew Github Token
alias brew='[[ $HOMEBREW_GITHUB_API_TOKEN ]] || export HOMEBREW_GITHUB_API_TOKEN=`gpg -d ~/.homebrew@github-password.gpg`; brew'

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Colored Man
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
