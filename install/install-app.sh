#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

# App
sudo apt install gimp steam spotify-client

# Desktop env
sudo apt install kitty picom nitrogen awesome rofi numlockx exa neofetch zathura

# Utils
sudo apt install wget git gh fd-find ninja-build gettext cmake unzip curl ripgrep clang xsel 

# MariaDb
sudo apt install mariadb-server mariadb-client

# PHP
sudo apt install php php-mysql php-curl php-common libapache2-mod-php php-cli php-xml composer

# Python
sudo apt install python3 python3-pip python3-venv python3-pynvim

# C++
sudo apt install gcc g++

# C# 
sudo apt install dotnet-sdk-7.0

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# On crée un dossier Dev
mkdir Dev

# Config apache2
mkdir ~/Dev/localhost
chmod -R 0755 ~/Dev/localhost
sudo rm -r /var/www/html
sudo ln -s ~/Dev/localhost /var/www/html

# Discord
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt install ./discord.deb
sudo rm discord.deb

# Obsidian
wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.14/obsidian_1.4.14_amd64.deb" -O obsidian.deb
sudo apt install ./obsidian.deb
sudo rm obsidian.deb

# Install et configuration de git credential manager
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.1.2/gcm-linux_amd64.2.1.2.deb" -O gcm.deb
sudo dpkg -i gcm.deb
git config --global credential.credentialStore plaintext
git-credential-manager configure
sudo rm gcm.deb

# Compte default git
git config --global user.email "soulaynicolas@gmail.com"
git config --global user.name "NicolasSoulay"
git config --global init.defaultBranch main

# Install de neovim nightly depuis les sources
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout nightly
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
sudo rm -R neovim

# Install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli

# Install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install de packages NPM
sudo su - $USER -c 'nvm install node'
sudo su - $USER -c 'nvm install-latest-npm'
sudo su - $USER -c 'npm install -g @angular/cli neovim sass typescript'

# Package a supprimer: HexChat Hypnotix Notes Seahorse Timeshift Transmission Warpinator WebApps
sudo apt purge hexchat hypnotix sticky seahorse thingy timeshift transmission transmission-gtk transmission-qt warpinator webapp-manager
sudo rm -R ~/.config/hexchat
sudo rm -R ~/.config/sticky
sudo rm -R ~/.config/transmission

# Clean du dossier home
mkdir ~/.config/git
mv ~/.gitconfig ~/.config/git/config

mkdir ~/.config/gtk-2.0
mv ~/.gtkrc-2.0 ~/.config/gtk-2.0/gtkrc
mv ~/.gtkrc-xfce ~/.config/gtk-2.0/.gtkrc-xfce

sudo rm ~/.bash_history
sudo rm ~/.wget-hsts
sudo rm ~/.ICEauthority

# Update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo apt update
sudo apt upgrade
sudo apt autoremove
