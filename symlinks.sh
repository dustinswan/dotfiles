#!/bin/bash

mkdir ~/.ghc; ln -sf ~/dotfiles/ghci.conf ~/.ghc/ghci.conf
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
mkdir -p ~/.config/khal; ln -sf ~/dotfiles/khal.conf ~/.config/khal/config
mkdir ~/.config/vdirsyncer; ln -sf ~/dotfiles/vdirsyncer/config ~/.config/vdirsyncer/config
mkdir ~/.gnupg; ln -sf ~/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf
mkdir ~/.ssh; ln -sf ~/dotfiles/ssh/config ~/.ssh/config
mkdir -p ~/.config/khard; ln -sf ~/dotfiles/khard.conf ~/.config/khard/khard.conf
mkdir -p ~/.config/qutebrowser; ln -sf ~/dotfiles/qutebrowser.py ~/.config/qutebrowser/config.py
mkdir -p ~/.config/alacritty.yml; ln -sf ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
mkdir -p ~/.config/rtv; ln -sf ~/dotfiles/rtv.cfg ~/.config/rtv/rtv.cfg
mkdir -p ~/.newsboat; ln -sf ~/dotfiles/newsboat ~/.newsboat/config
ln -sf ~/dotfiles/mailcap ~/.mailcap

# Mail stuff
ln -sf ~/dotfiles/offlineimaprc ~/.offlineimaprc
ln -sf ~/dotfiles/msmtprc ~/.msmtprc
ln -sf ~/dotfiles/muttrc ~/.muttrc
ln -sf ~/dotfiles/mutt ~/.mutt

# Mac only
mkdir -p ~/.config/karabiner; ln -sf ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
touch ~/.hushlogin
mkdir -p ~/Library/Application\ Support/glances; ln -sf ~/dotfiles/glances.conf ~/Library/Application\ Support/glances/glances.conf
mkdir -p ~/.qutebrowser; ln -sf ~/dotfiles/qutebrowser.py ~/.qutebrowser/config.py

# Linux only
ln -sf ~/dotfiles/Xresources ~/.Xresources
ln -sf ~/dotfiles/xprofile ~/.xprofile
mkdir ~/.xmonad; ln -sf ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
mkdir -p ~/.config/polybar; ln -sf ~/dotfiles/polybar ~/.config/polybar/config

# Vim
# ln -sf ~/dotfiles/vimrc ~/.vimrc
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovim
mkdir -p ~/.config/nvim; ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Emacs
mv ~/.emacs.d ~/.emacs.bak
git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -sf ~/dotfiles/spacemacs ~/.spacemacs

# NixOS Home Manager
ln -sf ~/dotfiles/home.nix ~/.config/nixpkgs/home.nix
