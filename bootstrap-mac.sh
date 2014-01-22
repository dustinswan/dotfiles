#!/bin/bash
sudo -v # ask for password only at the beginning

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Homebrew
brew update
brew upgrade
#brew tap homebrew/versions
brew tap phinze/homebrew-cask

brew install coreutils
brew install findutils
brew install aspell
brew install git
brew install tmux
brew install vim --override-system-vi
brew install wget --enable-iri
brew install weechat --with-aspell --with-python --with-ruby
brew install bash
brew install fish
brew install ack
brew install ssh-copy-id
brew install ffind
brew install node
brew install chruby
brew install ruby-install
brew install msmtp
brew install mutt
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
brew cask install macvim 
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
brew cleanup

# Ruby TODO -- set up chruby, ruby-install some stuff
# Gems TODO
# Node packages TODO
# Cabal packages TODO

# Change to fish shell
# TODO check if it's already in there first!!
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish dustinswan

# Symlinks
bash ~/dotfiles/symlinks.sh

# Sane OS X defaults
bash ~/dotfiles/osx

# App Store
echo "Install Xcode and Pixelmator from the App Store!"
