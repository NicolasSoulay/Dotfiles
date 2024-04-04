#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

source ~/.bashrc

# Flatpak
flatpak install flathub com.discordapp.Discord
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub io.dbeaver.DBeaverCommunity

# App
sudo dpkg --add-architecture i386 && sudo apt update
sudo apt install gimp firefox-esr thunderbird blender libreoffice timeshift steam-installer
sudo apt install wine wine32 wine64 libwine libwine:i386 fonts-wine

# Desktop env
sudo apt install kitty rofi numlockx exa neofetch zathura mc greetd

# # Sway
# sway swaybg swayidle swaylock xdg-desktop-portal-wlr xwayland waybar 
#
# # SwayFx/Hyprland dependency
# sudo apt install glslang-tools libgbm-dev hwdata libcairo2-dev libcap-dev libdbus-1-dev libdisplay-info-dev libevdev-dev libgdk-pixbuf2.0-dev libinput-dev libjson-c-dev libliftoff-dev libpam0g-dev libpango1.0-dev libpcre2-dev libpixman-1-dev libseat-dev libsystemd-dev libvulkan-dev libwayland-dev libwayland-egl1 libwlroots-dev libxcb-ewmh-dev libxkbcommon-dev meson pkgconf scdoc tree wayland-protocols

# Awesome Wm
sudo apt install awesome picom nitrogen

# Utils
sudo apt install wget fzf gh jq findutils fd-find ninja-build gettext cmake unzip curl ripgrep clang xsel pavucontrol playerctl mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386

# Librairie SDL
sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev

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

source ~/.bashrc

# TUIGreet
cd Sources/
git clone https://github.com/apognu/tuigreet && cd tuigreet
cargo build --release
sudo mv target/release/tuigreet /usr/local/bin/tuigreet
sudo mkdir /var/cache/tuigreet
sudo chown _greetd:_greetd /var/cache/tuigreet
sudo chmod 0755 /var/cache/tuigreet
cd ~

# Install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash

# Install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install de packages NPM
sudo su - $USER -c 'nvm install --lts'
sudo su - $USER -c 'nvm install-latest-npm'
sudo su - $USER -c 'npm install -g @angular/cli neovim sass typescript'

# Packages cargo
cargo install zoxide skim
cargo install --locked ncspot

# ani-cli
git clone "https://github.com/pystardust/ani-cli.git"
sudo cp ani-cli/ani-cli /usr/local/bin
rm -rf ani-cli

# Update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo apt update
sudo apt upgrade
sudo apt autoremove
