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
touch  ~/.local/state/bash/history
touch  ~/.local/share/wget-hsts

# Config apache2
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
cp ~/Dotfiles/install/.bash_aliases ~/.bash_aliases
cp ~/Dotfiles/install/.bash_env ~/.bash_env

# Tous les fichier de config + les wallpapers
ln -sf ~/Dotfiles/config/kitty ~/.config/kitty
ln -sf ~/Dotfiles/config/nvim ~/.config/nvim
ln -sf ~/Dotfiles/config/rofi ~/.config/rofi
ln -sf ~/Dotfiles/config/sway ~/.config/sway
ln -sf ~/Dotfiles/config/waybar ~/.config/waybar
ln -sf ~/Dotfiles/config/zathura ~/.config/zathura
ln -sf ~/Dotfiles/wallpapers ~/Pictures/Wallpapers

# On fais les liens pour les scripts
ln -sf ~/Dotfiles/bin ~/.local/bin

# On recupere les fonts et on met a jour le cache
ln -sf ~/Dotfiles/fonts ~/.local/share/fonts
fc-cache -f -v

#pb clavier
sudo touch /etc/modprobe.d/hid_apple.conf
sudo echo options hid_apple fnmode=2 >> /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u

# Flatpack
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Clean du dossier home
sudo rm ~/.bash_history
sudo rm ~/.wget-hsts

