#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

mkdir ~/.local/state/
mkdir ~/.local/state/bash
mkdir ~/.config/nvm

# Ajout des bash alias
sudo ln -sf ~/Dotfiles/bash/.bashrc ~/.bashrc
sudo ln -sf ~/Dotfiles/bash/.bash_aliases ~/.bash_aliases
sudo ln -sf ~/Dotfiles/bash/.bash_env ~/.bash_env

# Tous les fichier de config + les wallpapers
sudo ln -sf ~/Dotfiles/config/awesome ~/.config/awesome
sudo ln -sf ~/Dotfiles/config/kitty ~/.config/kitty
sudo ln -sf ~/Dotfiles/config/nvim ~/.config/nvim
sudo ln -sf ~/Dotfiles/config/rofi ~/.config/rofi
sudo ln -sf ~/Dotfiles/config/zathura ~/.config/zathura
sudo ln -sf ~/Dotfiles/wallpapers ~/Pictures/Wallpapers

# On fais les liens pour les scripts
sudo ln -sf ~/Dotfiles/bin ~/.local/bin

# On recupere les fonts et on met a jour le cache
sudo ln -sf ~/Dotfiles/fonts ~/.local/share/fonts
fc-cache -f -v


