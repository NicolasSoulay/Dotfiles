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
touch -p ~/.local/state/bash/history
touch -p ~/.local/share/wget-hsts

# Config apache2
mkdir -p ~/Dev/localhost
chmod -R 0755 ~/Dev/localhost
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

# Flatpack
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Clean du dossier home
sudo rm ~/.bash_history
sudo rm ~/.wget-hsts

