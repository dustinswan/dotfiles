alias vi vim
alias l "ls -la"
alias tmux "tmux -2"
alias ta "tmux attach -d"
alias dustinswan "mosh dustinswan@dustinswan.org"
alias kill_offlineimap "ps aux | grep offlineimap | awk '{ print $2 }' | xargs kill -9"
set -x EDITOR "vim"
set -x TERM "screen-256color"
set -x MOSH_TITLE_NOPREFIX 1

set -x BROWSER "open"
[ -s luakit ] and set -x BROWSER=luakit

alias browser "eval $BROWSER"

# IOCOM stuff
set -x P4USER "dswan"
set -x P4PORT "humu.insors.net:1666"
set -x P4CONFIG "p4.cfg"
set -x P4EDITOR "vim"
alias p4vimdiff "set -x P4DIFF vimdiff; p4 diff"
alias visidev "ssh root@visidev.iocom.com 'cd /; p4 sync'; scp /opt/iocom/user/webclient/all_desktop.js root@visidev.iocom.com:/opt/iocom/user/webclient/; scp /opt/iocom/user/webclient/css/all_desktop.css root@visidev.iocom.com:/opt/iocom/user/webclient/css/"
alias dswan "ssh root@dswan.insors.net"
alias er 'rm -rf logs; unzip -o'

# PATH
set -x PATH /usr/local/bin /usr/local/sbin $PATH # Homebrew
set -x PATH /Applications/Postgres.app/Contents/MacOS/bin $PATH
set -x PATH $HOME/Library/Haskell/bin $PATH
set -x PATH $HOME/dotfiles/bin $PATH
set -x PATH /usr/local/share/npm/bin $PATH
set -x NODE_PATH $NODE_PATH /usr/local/lib/node
set -x PYTHONPATH $PYTHONPATH /usr/local/lib/python2.7/site-packages
set -x SSL_CERT_FILE /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# Nix
. $HOME/.nix-profile/etc/fish/config.fish
#sh $HOME/.nix-profile/etc/profile.d/nix.sh
sh $HOME/.nix-profile/etc/profile.d/nix_fish.sh

# Chruby
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

# NVM
test -s /Users/dustinswan/.nvm/nvm.fish; and source /Users/dustinswan/.nvm/nvm.fish

if status --is-interactive;
    keychain ~/.ssh/id_rsa
    [ -e $HOME/.keychain/$HOSTNAME-fish ]; and . $HOME/.keychain/$HOSTNAME-fish 
    [ -e $HOME/.keychain/$HOSTNAME-fish-gpg]; and . $HOME/.keychain/$HOSTNAME-fish-gpg
end
