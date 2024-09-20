#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

# dossiers utilisateurs
sudo apt install xdg-user-dirs
xdg-user-dirs-update

mkdir -p ~/.local/state/bash
mkdir -p ~/.cache
mkdir -p ~/.config/nvm
mkdir -p ~/.local/share
mkdir -p ~/Games
mkdir -p ~/Games/BIOS
mkdir -p ~/Games/PS1
mkdir -p ~/Games/ROMS
mkdir -p ~/Games/ROMS/PS1
touch  ~/.local/state/bash/history
touch  ~/.local/share/wget-hsts

# Config apache2
sudo apt install apache2
mkdir -p ~/Dev/localhost
sudo chmod 0755 ~/Dev/localhost
sudo chgrp www-data ~/Dev/localhost
sudo chmod 755 ~
sudo rm -r /var/www/html
sudo ln -s ~/Dev/localhost /var/www/html

# Ajout des bash alias
rm ~/.bashrc
rm ~/.bash_aliases
cp ~/Dotfiles/install/.bashrc ~/.bashrc

# Tous les fichier de config + les wallpapers
ln -sf ~/Dotfiles/config/awesome ~/.config/awesome
ln -sf ~/Dotfiles/config/kitty ~/.config/kitty
ln -sf ~/Dotfiles/config/nvim ~/.config/nvim
ln -sf ~/Dotfiles/config/rofi ~/.config/rofi
ln -sf ~/Dotfiles/config/starship ~/.config/starship
ln -sf ~/Dotfiles/config/tmux ~/.config/tmux
ln -sf ~/Dotfiles/config/wezterm ~/.config/wezterm
ln -sf ~/Dotfiles/config/zathura ~/.config/zathura
ln -sf ~/Dotfiles/config/zellij ~/.config/zellij
ln -sf ~/Dotfiles/wallpapers ~/Pictures/Wallpapers
ln -sf ~/Dotfiles/screenshots ~/Pictures/Screenshots

# On fais les liens pour les scripts
ln -sf ~/Dotfiles/bin ~/.local/bin

# On recupere les fonts et on met a jour le cache
ln -sf ~/Dotfiles/fonts ~/.local/share/fonts
fc-cache -f -v

# Flatpack
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Clean du dossier home
sudo rm ~/.bash_history
sudo rm ~/.bash_logout
sudo rm ~/.wget-hsts

