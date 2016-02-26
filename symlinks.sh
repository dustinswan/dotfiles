#!/bin/bash

rm ~/.zshrc; ln -s ~/dotfiles/zshrc ~/.zshrc
rm ~/.gemrc; ln -s ~/dotfiles/gemrc ~/.gemrc
rm -rf ~/.ghc; mkdir ~/.ghc; ln -s ~/dotfiles/ghci.conf ~/.ghc/ghci.conf
rm ~/.gitconfig; ln -s ~/dotfiles/gitconfig ~/.gitconfig
rm -rf ~/.tmux; ln -s ~/dotfiles/tmux ~/.tmux
rm ~/.tmux.conf; ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
rm -rf ~/.config/khal; mkdir -p ~/.config/khal; ln -s ~/dotfiles/khal.conf ~/.config/khal/khal.conf
rm -rf ~/.vdirsyncer; mkdir ~/.vdirsyncer; ln -s ~/dotfiles/vdirsyncer/config ~/.vdirsyncer/config
rm ~/.jrnl_config; ln -s ~/dotfiles/jrnl_config ~/.jrnl_config
rm ~/.gnupg/gpg-agent.conf; mkdir ~/.gnupg; ln -s ~/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf
mkdir -p ~/.ssh; rm ~/.ssh/config; ln -s ~/dotfiles/ssh/config ~/.ssh/config

# Mail stuff
rm ~/.offlineimaprc; ln -s ~/dotfiles/offlineimaprc ~/.offlineimaprc
rm ~/.msmtprc; ln -s ~/dotfiles/msmtprc ~/.msmtprc
rm ~/.muttrc; ln -s ~/dotfiles/muttrc ~/.muttrc

# mac only
rm ~/.slate.js; ln -s ~/dotfiles/slate.js ~/.slate.js
rm ~/Library/KeyBindings/DefaultKeyBinding.dict; cp ~/dotfiles/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

# linux only
rm -rf ~/.i3; mkdir ~/.i3; ln -s ~/dotfiles/i3/config ~/.i3/config
rm -rf ~/.Xresources; ln -s ~/dotfiles/Xresources ~/.Xresources
rm -rf ~/.xinitrc; ln -s ~/dotfiles/xinitrc ~/.xinitrc

# Vim
rm -rf ~/.vim; ln -s ~/dotfiles/vim ~/.vim
rm ~/.vimrc; ln -s ~/dotfiles/vimrc ~/.vimrc

# Neovim
rm -rf ~/.config/nvim; ln -s ~/dotfiles/vim ~/.config/nvim
rm ~/.config/nvim/init.vim; ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim

# Spacemacs
mv ~/.emacs.d ~/.emacs.bak
git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
rm ~/.spacemacs; ln -s ~/dotfiles/spacemacs ~/.spacemacs
ln -s ~/dotfiles/spacemacs_private/twittering-mode ~/.emacs.d/private/twittering-mode
ln -s ~/dotfiles/spacemacs_private/mu4e ~/.emacs.d/private/mu4e
