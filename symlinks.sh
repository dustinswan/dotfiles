#!/bin/bash

rm ~/.ackrc; ln -s ~/dotfiles/ackrc ~/.ackrc
rm -rf ~/.config/fish; mkdir -p ~/.config/fish; ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish
rm ~/.gemrc; ln -s ~/dotfiles/gemrc ~/.gemrc
rm -rf ~/.ghc; mkdir ~/.ghc; ln -s ~/dotfiles/ghci.conf ~/.ghc/ghci.conf
rm ~/.gitconfig; ln -s ~/dotfiles/gitconfig ~/.gitconfig
rm ~/.mbsyncrc; ln -s ~/dotfiles/mbsyncrc ~/.mbsyncrc
rm ~/.msmtprc; ln -s ~/dotfiles/msmtprc ~/.msmtprc
rm ~/.ruby-version; ln -s ~/dotfiles/ruby-version ~/.ruby-version
rm ~/.tmux.conf; ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
rm ~/.vimrc; ln -s ~/dotfiles/vimrc ~/.vimrc
rm -rf ~/.vim; ln -s ~/dotfiles/vim ~/.vim
