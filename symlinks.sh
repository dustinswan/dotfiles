#!/bin/bash

rm ~/.ackrc; ln -s ~/dotfiles/ackrc ~/.ackrc
rm -rf ~/.config/fish; mkdir -p ~/.config/fish; ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish
rm ~/.gemrc; ln -s ~/dotfiles/gemrc ~/.gemrc
rm -rf ~/.ghc; mkdir ~/.ghc; ln -s ~/dotfiles/ghci.conf ~/.ghc/ghci.conf
rm ~/.gitconfig; ln -s ~/dotfiles/gitconfig ~/.gitconfig
rm ~/.ruby-version; ln -s ~/dotfiles/ruby-version ~/.ruby-version
rm ~/.tmux.conf; ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
rm ~/.vimrc; ln -s ~/dotfiles/vimrc ~/.vimrc
rm -rf ~/.vim; ln -s ~/dotfiles/vim ~/.vim
rm ~/.vimperatorrc; ln -s ~/dotfiles/vimperatorrc ~/.vimperatorrc
rm -rf ~/.config/khal; mkdir -p ~/.config/khal; ln -s ~/dotfiles/khal.conf ~/.config/khal/khal.conf
rm -rf ~/.vdirsyncer; mkdir ~/.vdirsyncer; ln -s ~/dotfiles/vdirsyncer/config ~/.vdirsyncer/config
rm ~/.zshrc; ln -s ~/dotfiles/zshrc ~/.zshrc
rm ~/.jrnl_config; ln -s ~/dotfiles/jrnl_config ~/.jrnl_config

# Mail stuff
#rm ~/.mbsyncrc; ln -s ~/dotfiles/mbsyncrc ~/.mbsyncrc
rm ~/.offlineimaprc; ln -s ~/dotfiles/offlineimaprc ~/.offlineimaprc
rm ~/.msmtprc; ln -s ~/dotfiles/msmtprc ~/.msmtprc
rm -rf ~/.config/alot; ln -s ~/dotfiles/alot ~/.config/
rm -rf ~/.config/afew; ln -s ~/dotfiles/afew ~/.config/
rmdir ~/.mail/.notmuch/hooks; mkdir -p ~/.mail/.notmuch/hooks; ln -s ~/dotfiles/notmuch-post-new ~/.mail/.notmuch/hooks/post-new

# TODO mac only
rm ~/.slate.js; ln -s ~/dotfiles/slate.js ~/.slate.js
rm ~/.urlview; ln -s ~/dotfiles/urlview.mac ~/.urlview
rm ~/Library/KeyBindings/DefaultKeyBinding.dict; cp ~/dotfiles/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

# TODO linux only
rm -rf ~/.i3; mkdir ~/.i3; ln -s ~/dotfiles/i3/config ~/.i3/config
rm -rf ~/.Xresources; ln -s ~/dotfiles/Xresources ~/.Xresources
rm -rf ~/.xinitrc; ln -s ~/dotfiles/xinitrc.nixos ~/.xinitrc
