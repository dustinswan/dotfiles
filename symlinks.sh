#!/bin/bash

rm ~/.zshrc; ln -s ~/dotfiles/zshrc ~/.zshrc
rm -rf ~/.config/fish; mkdir -p ~/.config/fish; ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish
rm ~/.gemrc; ln -s ~/dotfiles/gemrc ~/.gemrc
rm -rf ~/.ghc; mkdir ~/.ghc; ln -s ~/dotfiles/ghci.conf ~/.ghc/ghci.conf
rm ~/.gitconfig; ln -s ~/dotfiles/gitconfig ~/.gitconfig
rm ~/.tmux.conf; ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
rm -rf ~/.config/khal; mkdir -p ~/.config/khal; ln -s ~/dotfiles/khal.conf ~/.config/khal/config
rm -rf ~/.vdirsyncer; mkdir ~/.vdirsyncer; ln -s ~/dotfiles/vdirsyncer/config ~/.vdirsyncer/config
rm ~/.jrnl_config; ln -s ~/dotfiles/jrnl_config ~/.jrnl_config
rm ~/.gnupg/gpg-agent.conf; mkdir ~/.gnupg; ln -s ~/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf
mkdir -p ~/.ssh; rm ~/.ssh/config; ln -s ~/dotfiles/ssh/config ~/.ssh/config
rm ~/Library/Application\ Support/glances/glances.conf; mkdir ~/Library/Application\ Support/glances; ln -s ~/dotfiles/glances.conf ~/Library/Application\ Support/glances/glances.conf
rm ~/.config/khard/khard.conf; mkdir ~/.config/khard; ln -s ~/dotfiles/khard.conf ~/.config/khard/khard.conf
rm -rf ~/.config/qutebrowser; mkdir ~/.config/qutebrowser; ln -s ~/dotfiles/qutebrowser.py ~/.config/qutebrowser/config.py

# Mail stuff
rm ~/.offlineimaprc; ln -s ~/dotfiles/offlineimaprc ~/.offlineimaprc
rm ~/.msmtprc; ln -s ~/dotfiles/msmtprc ~/.msmtprc
rm ~/.muttrc; ln -s ~/dotfiles/muttrc ~/.muttrc

# mac only
rm ~/.karabiner.d/configuration/karabiner.json; ln -s ~/dotfiles/karabiner.json ~/.karabiner.d/configuration/karabiner.json
rm -rf ~/.kwm; mkdir ~/.kwm; ln -s ~/dotfiles/kwmrc ~/.kwm/kwmrc
rm -rf ~/.khdrc; ln -s ~/dotfiles/khdrc ~/.khdrc
touch ~/.hushlogin

# linux only
rm -rf ~/.Xresources; ln -s ~/dotfiles/Xresources ~/.Xresources
rm -rf ~/.xprofile; ln -s ~/dotfiles/xprofile ~/.xprofile
rm -rf ~/.xmonad; mkdir ~/.xmonad; ln -s ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
rm -rf ~/.config/polybar; mkdir -p ~/.config/polybar; ln -s ~/dotfiles/polybar ~/.config/polybar/config

# Vim
rm ~/.vimrc; ln -s ~/dotfiles/vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovim
rm -rf ~/.config/nvim; mkdir ~/.config/nvim; ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Spacemacs
mv ~/.emacs.d ~/.emacs.bak
git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
rm ~/.spacemacs; ln -s ~/dotfiles/spacemacs ~/.spacemacs
