alias l="ls -la"
alias ta="tmux attach -d"
alias e='emacsclient -a "" -t -nw'
alias emacs='emacs -q'
alias weather='curl http://wttr.in'

# Vim
if command --search nvim >/dev/null
    alias vi=nvim
    alias vim=nvim
    set -x EDITOR nvim
else
    alias vi=vim
    set -x EDITOR vim
end

# Mac only
if command --search open >/dev/null
    set -x BROWSER open
end

# IOCOM stuff
alias er='rm -rf logs; unzip -o'
set -x P4USER dswan
set -x P4PORT "humu.iocom.com:1666"
set -x P4CONFIG p4.cfg
set -x P4EDITOR nvim
set -x P4IGNORE .ignore

# PATH
test -e $HOME/dotfiles/bin ; and set -x PATH $HOME/dotfiles/bin $PATH
test -e $HOME/flutter/bin ; and set -x PATH $HOME/flutter/bin $PATH
test -e $HOME/.local/bin ; and set -x PATH $HOME/.local/bin $PATH
test -e $HOME/.cargo ; and set -x PATH $HOME/.cargo $PATH
test -e $HOME/.npm-packeges/bin ; and set -x PATH $HOME/.npm-packages/bin $PATH
test -e /usr/local/opt/python/libexec/bin ; and set -x PATH /usr/local/opt/python/libexec/bin $PATH
test -e $HOME/.cargo/bin ; and set -x PATH $HOME/.cargo/bin $PATH

# Keychain
if status --is-interactive
    # TODO Take this out when keychain fixes this bug
    set -x GPG_AGENT_INFO "~/.gnupg/S.gpg-agent:"(pgrep gpg-agent)":1"
    keychain --eval --inherit any --agents gpg,ssh --quiet id_rsa 2B3A6377 | source
end

# iTerm2
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Ledger
set -x LEDGER_FILE ~/Sync/Ledger/ledger.ledger

# Emacs term stuff
function fish_title
  true
end

if test -n "$EMACS"
  set -x TERM eterm-color
end

set fish_greeting ""

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
