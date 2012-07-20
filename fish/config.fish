alias l "ls -la"
alias vi vim
set -x EDITOR vim

# VCS stuff
set -x P4USER dswan
set -x P4PORT "humu.insors.net:1666"
set -x P4CONFIG p4.cfg
set -x P4EDITOR vim
set -x SVN_EDITOR vim

# sync visidev to latest Perforce
alias visidev "ssh root@visidev.iocom.com 'cd /; p4 sync'"

set -x PATH /usr/local/bin $PATH # Homebrew
set -x PATH $HOME/.rvm/bin $PATH # RVM
set -x PATH /Applications/Postgres.app/Contents/MacOS/bin $PATH # Postgres
set -x PATH $HOME/Library/Haskell/bin $PATH # Haskell

set -x IGVERBOSE 3
