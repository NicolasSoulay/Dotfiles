#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

source ~/.bashrc

# Flatpak
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.spotify.Client
flatpak install flathub com.discordapp.Discord
flatpak install flathub md.obsidian.Obsidian

# App
sudo apt install gimp firefox-esr thunderbird blender libreoffice wine timeshift

# Desktop env
sudo apt install kitty rofi numlockx exa neofetch zathura mc sway swaybg swayidle swaylock xdg-desktop-portal-wlr xwayland waybar greetd

# Utils
sudo apt install wget gh jq findutils fd-find ninja-build gettext cmake unzip curl ripgrep clang xsel pavucontrol playerctl

# MariaDb
sudo apt install mariadb-server mariadb-client

# PHP
sudo apt install php php-mysql php-curl php-common libapache2-mod-php php-cli php-xml composer php-symfony-console

# Python
sudo apt install python3 python3-pip python3-venv python3-pynvim

# C++
sudo apt install gcc g++

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Librairie SDL
sudo apt-get install libsdl2-dev

# Compte default git
git config --global user.email "soulaynicolas@gmail.com"
git config --global user.name "NicolasSoulay"
git config --global init.defaultBranch main


# Install et configuration de git credential manager
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.1.2/gcm-linux_amd64.2.1.2.deb" -O gcm.deb
sudo dpkg -i gcm.deb
git config --global credential.credentialStore plaintext
git-credential-manager configure
sudo rm gcm.deb

# Install de neovim nightly depuis les sources
mkdir ~/Sources
cd ~/Sources
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout nightly
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ~

# TUIGreet
cd Sources/
git clone https://github.com/apognu/tuigreet && cd tuigreet
cargo build --release
sudo mv target/release/tuigreet /usr/local/bin/tuigreet
sudo mkdir /var/cache/tuigreet
sudo chown _greetd:_greetd /var/cache/tuigreet
sudo chmod 0755 /var/cache/tuigreet

# Install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash

# Install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install de packages NPM
sudo su - $USER -c 'nvm install node'
sudo su - $USER -c 'nvm install-latest-npm'
sudo su - $USER -c 'npm install -g @angular/cli neovim sass typescript'

# Update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo apt update
sudo apt upgrade
sudo apt autoremove
