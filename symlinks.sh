#!/bin/bash

mkdir ~/.ghc; ln -sf ~/dotfiles/ghci.conf ~/.ghc/ghci.conf
mkdir -p ~/.config/khal; ln -sf ~/dotfiles/khal.conf ~/.config/khal/config
mkdir ~/.config/vdirsyncer; ln -sf ~/dotfiles/vdirsyncer/config ~/.config/vdirsyncer/config
# mkdir ~/.gnupg; ln -sf ~/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf
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

# Emacs
# mv ~/.emacs.d ~/.emacs.bak
# git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
# ln -sf ~/dotfiles/spacemacs ~/.spacemacs

# NixOS Home Manager
ln -sf ~/dotfiles/home.nix ~/.config/nixpkgs/home.nix
