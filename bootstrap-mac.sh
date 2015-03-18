#!/bin/bash
sudo -v # ask for password only at the beginning

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Homebrew
brew update
brew upgrade
brew tap homebrew/dupes
brew tap phinze/homebrew-cask
brew tap jimbojsb/launchrocket
brew tap homebrew/versions

# Symlinks
bash ~/dotfiles/symlinks.sh

# Python
pip install --upgrade setuptools
pip install --upgrade pip

# Ruby TODO -- set up chruby, ruby-build some stuff
ruby-build 2.1.0 ~/.rubies/ruby-2.1.0
chruby 2.1.0

# Gems TODO
# Node packages TODO
# Cabal packages TODO

# Sane OS X defaults
bash ~/dotfiles/osx

# Run some of these: Alfred, slate, asepsis, keyremap4macbook, etc.

# App Store
echo "Install Xcode and Pixelmator from the App Store!"
