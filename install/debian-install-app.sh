#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

# Flatpak
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.spotify.Client
flatpak install flathub com.discordapp.Discord
flatpak install flathub md.obsidian.Obsidian

# App
sudo apt install gimp

# Desktop env
sudo apt install kitty rofi numlockx exa neofetch zathura xdg-user-dirs mc sway sway-bg swayidle swaylock xdg-desktop-wlr xwayland waybar

# Utils
sudo apt install wget gh fd-find ninja-build gettext cmake unzip curl ripgrep clang xsel 

# MariaDb
sudo apt install mariadb-server mariadb-client

# PHP
sudo apt install php php-mysql php-curl php-common libapache2-mod-php php-cli php-xml composer

# Python
sudo apt install python3 python3-pip python3-venv python3-pynvim

# C++
sudo apt install gcc g++

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Librairie SDL
sudo apt-get install libsdl2-dev

# On crée un dossier Dev
mkdir ~/Dev

# Config apache2
mkdir ~/Dev/localhost
chmod -R 0755 ~/Dev/localhost
sudo rm -r /var/www/html
sudo ln -s ~/Dev/localhost /var/www/html

# Compte default git
git config --global user.email "soulaynicolas@gmail.com"
git config --global user.name "NicolasSoulay"
git config --global init.defaultBranch main

# Install de neovim nightly depuis les sources
mkdir ~/Sources
cd ~/Sources
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout nightly
make CMAKE_BUILD_TYPE=Release
sudo make install
cd

# Install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli

# Install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install de packages NPM
sudo su - $USER -c 'nvm install node'
sudo su - $USER -c 'nvm install-latest-npm'
sudo su - $USER -c 'npm install -g @angular/cli neovim sass typescript'

# Clean du dossier home
sudo rm ~/.bash_history
sudo rm ~/.wget-hsts

# Update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo apt update
sudo apt upgrade
sudo apt autoremove
