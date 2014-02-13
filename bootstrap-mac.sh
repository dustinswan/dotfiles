#!/bin/bash
sudo -v # ask for password only at the beginning

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Homebrew
brew update
brew upgrade
#brew tap homebrew/versions
brew tap homebrew/dupes
brew tap phinze/homebrew-cask
brew tap jimbojsb/launchrocket

brew install coreutils
brew install findutils
brew install aspell
brew install git
brew install perforce
brew install tmux
brew install wget --enable-iri
brew install weechat --with-aspell --with-python --with-ruby
brew install ranger
brew install bash
brew install fish
brew install ack
brew install tree
brew install imagesnap
brew install openssl
brew install openssh --with-brewed-openssl
brew install ssh-copy-id
brew install ffind
brew install node
brew install ruby-install
# brew install chruby
brew install python --with-brewed-openssl
brew install macvim --HEAD --override-system-vim
brew install msmtp
brew install mutt
brew install urlview
brew install isync
brew install mosh
brew install haskell-platform
brew install brew-cask
brew cask install rdio
brew cask install alfred
brew cask alfred link
brew cask install slate
brew cask install google-chrome
brew cask install charles
brew cask install dropbox
brew cask install iterm2
#brew cask install macvim
brew cask install vlc
brew cask install transmission
brew cask install firefox
brew cask install the-unarchiver
brew cask install electrum
brew cask install steam
brew cask install sketchup
#brew cask install gpgtools ???
#brew cask install vagrant
#brew cask install bittorrent-sync
#brew cask install truecrypt
brew cask install asepsis
brew cask install keyremap4macbook
brew cask install audacity
brew cask install launchrocket
brew cask install thunderbird
brew cleanup

# Symlinks
bash ~/dotfiles/symlinks.sh

# Python
pip install --upgrade setuptools
pip install --upgrade pip
pip install git+git://github.com/Lokaltog/powerline

# Ruby TODO -- set up chruby, ruby-install some stuff
# https://github.com/JeanMertz/chruby-fish
ruby-install ruby 1.9
ruby-install ruby 2.1
chruby 1.9

# Gems TODO
gem install earthquake

# Node packages TODO
# Cabal packages TODO

# Change to fish shell
# TODO check if it's already in there first!!
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish dustinswan

# Sane OS X defaults
bash ~/dotfiles/osx

# Run some of these: Alfred, slate, asepsis, keyremap4macbook, etc.

# App Store
echo "Install Xcode and Pixelmator from the App Store!"
