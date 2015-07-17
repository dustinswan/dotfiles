source ~/dotfiles/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen theme S1cK94/minimal minimal
export ZSH_THEME="minimal"

bindkey -e

alias vi=nvim
alias vim=nvim
alias l="ls -la"
alias ta="tmux attach -d"
alias dustinswan="mosh dustinswan@dustinswan.org"
alias kill_offlineimap="ps aux | grep offlineimap | awk '{ print $2 }' | xargs kill -9"
alias e='emacsclient -a "" -t'
export EDITOR=nvim
export TERM="screen-256color"
export MOSH_TITLE_NOPREFIX=1

export BROWSER=open
[[ -s luakit ]] && export BROWSER=luakit

# IOCOM stuff
export P4USER=dswan
export P4PORT="humu.insors.net:1666"
export P4CONFIG=p4.cfg
export P4EDITOR=vim
alias p4diffv="export P4DIFF=vimdiff; set -x P4DIFF vimdiff; p4 diff"
alias p4diffi="export P4DIFF=icdiff; set -x P4DIFF icdiff; p4 diff"
alias visidev="ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias er='rm -rf logs; unzip -o'

# PATH

# building webrtc
export PATH=$HOME/depot_tools:$PATH
export GYP_CROSSCOMPILE=1
export GYP_GENERATORS=ninja
## arm64
#export GYP_DEFINES="OS=ios target_arch=arm64 target_subarch=arm64 build_with_chromium=0 include_tests=0 enable_video=0 clang_xcode=1 clang=1"
#export GYP_GENERATOR_FLAGS="output_dir=out_ios64"
# armv7
# export GYP_DEFINES="OS=ios target_arch=arm arm_version=7 build_with_chromium=0 include_tests=0 enable_video=0 clang_xcode=1 clang=1"
# export GYP_GENERATOR_FLAGS="output_dir=out_iosv7"

export PATH=/usr/texbin:$PATH # Basictex
export PATH=/usr/local/bin:/usr/local/sbin:$PATH # Homebrew
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=~/.cabal/bin:$PATH
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export NODE_PATH=/usr/local/lib/node:/usr/local/share/npm/lib/node_modules
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# Nix
. $HOME/.nix-profile/etc/profile.d/nix.sh
export NIX_PATH=nixpkgs=$HOME/nixpkgs

# Chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
#chruby $(cat ~/.ruby-version)

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Keychain
eval `keychain --eval id_rsa`

# Tex
eval `/usr/libexec/path_helper -s`

powerline-daemon -q

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

autoload -U select-word-style
select-word-style bash
