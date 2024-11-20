#!/usr/bin/bash
cd ~

sudo apt update -y
sudo apt upgrade -y

echo "Github username:"
read github_username

echo "Github email:"
read github_email

# dossiers utilisateurs
sudo apt install xdg-user-dirs -y
xdg-user-dirs-update

mkdir -p ~/.local/state/bash
mkdir -p ~/.cache
mkdir -p ~/.config/nvm
mkdir -p ~/.local/share
mkdir -p ~/Games
mkdir -p ~/Games/PS1
mkdir -p ~/Games/PS2
mkdir -p ~/Sources
touch  ~/.local/state/bash/history
touch  ~/.local/share/wget-hsts

# Copie .bashrc
rm ~/.bashrc
rm ~/.bash_aliases
cp ~/Dotfiles/install/.bashrc ~/.bashrc

# Tous les fichier de config + les wallpapers
# TODO: Créer un xinitrc ou xsession pour le desktop Xorg
cp ~/Dotfiles/install/.xinitrc ~/.xinitrc
ln -sf ~/Dotfiles/config/awesome ~/.config/awesome
ln -sf ~/Dotfiles/config/rofi ~/.config/rofi
ln -sf ~/Dotfiles/config/kitty ~/.config/kitty
ln -sf ~/Dotfiles/config/mc ~/.config/mc
ln -sf ~/Dotfiles/config/nvim ~/.config/nvim
ln -sf ~/Dotfiles/config/tmux ~/.config/tmux
ln -sf ~/Dotfiles/config/zathura ~/.config/zathura
ln -sf ~/Dotfiles/wallpapers ~/Pictures/Wallpapers

# On fais les liens pour les scripts
ln -sf ~/Dotfiles/bin ~/.local/bin

# On recupere les fonts et on met a jour le cache
ln -sf ~/Dotfiles/fonts ~/.local/share/fonts
fc-cache -f -v

# Flatpack
sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Clean du dossier home
sudo rm ~/.bash_history
sudo rm ~/.bash_logout
sudo rm ~/.profile
sudo rm ~/.wget-hsts

source ~/.bashrc

# Flatpak
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub org.duckstation.DuckStation -y
flatpak install flathub net.lutris.Lutris
flatpak install net.pcsx2.PCSX2 -y

# Dossier pour emulateurs
mkdir ~/.var/app/org.duckstation.DuckStation/config/duckstation/games
ln -sf ~/.var/app/org.duckstation.DuckStation/config/duckstation/bios ~/Games/PS1/BIOS
ln -sf ~/.var/app/org.duckstation.DuckStation/config/duckstation/games ~/Games/PS1/ROMS

mkdir ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/games
ln -sf ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/bios ~/Games/PS2/BIOS
ln -sf ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/games ~/Games/PS2/ROMS

sudo apt install steam-installer -y

# TODO: ajouter des fichiers de configurations pour firefox & qbittorent
# App
sudo apt install thunderbird dwarf-fortress firefox-esr libreoffice qbittorrent -y

# install de MEGA
wget https://mega.nz/linux/repo/Debian_12/amd64/megasync-Debian_12_amd64.deb && sudo apt install "$PWD/megasync-Debian_12_amd64.deb"
rm megasync-Debian_12_amd64.deb

# Desktop env TODO: change exa for eza when it's available for Debian 13
sudo apt install exa zathura greetd mc mpv cmus tealdeer tmux -y

# Wine
sudo dpkg --add-architecture i386 && sudo apt update
sudo apt install wine wine64 libwine libwine:i386 fonts-wine -y

# Xorg install
sudo apt install rofi picom awesome xorg -y

# Utils
sudo apt install inotify-tools wget fzf bat gh jq man awk w3m coreutils pavucontrol parallel findutils fd-find gettext unzip curl ripgrep xsel pavucontrol playerctl build-essential -y

# Postgres
sudo apt install postgresql postgresql-client -y

# PHP
sudo apt install php php-mysql php-curl php-common libapache2-mod-php php-cli php-xml php-zip composer php-symfony-console php-gd php-pgsql -y

# Python
sudo apt install python3 python3-pip python3-venv python3-pynvim -y

# C/C++
sudo apt install gcc g++ cmake clang ninja-build -y

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Dependencies:
sudo apt install libgit2-dev libcurll4-*-dev libssh-dev libssl-dev pkgconf -y # cargo-update
sudo apt install libssl-dev libncurses-dev libncursesw5-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render0-dev libpulse-dev libxcb1-dev libdbus-1-dev -y # ncspot

# Compte default git
git config --global user.email "${github_email}"
git config --global user.name "${github_username}"
git config --global init.defaultBranch main

# TODO: faire une meilleure gestion des credentials pour github
# Install et configuration de git credential manager
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.1.2/gcm-linux_amd64.2.1.2.deb" -O gcm.deb
sudo dpkg -i gcm.deb
git config --global credential.credentialStore plaintext
git-credential-manager configure
sudo rm gcm.deb

# Install de neovim stable depuis les sources
cd ~/Sources
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ~

source ~/.bashrc

# TODO: Verifier les sources de wikiman
# Wikiman
cd ~/Sources/
git clone 'https://github.com/filiparag/wikiman'
cd ./wikiman
git checkout $(git describe --tags | cut -d'-' -f1)
make all
sudo make install
cd ~

# TUIGreet
cd ~/Sources/
git clone https://github.com/apognu/tuigreet && cd tuigreet
cargo build --release
sudo mv target/release/tuigreet /usr/local/bin/tuigreet
sudo mkdir /var/cache/tuigreet
sudo chown _greetd:_greetd /var/cache/tuigreet
sudo chmod 0755 /var/cache/tuigreet
cd ~

# Install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli -y

# Install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install de packages NPM
sudo su - $USER -c 'nvm install --lts'
sudo su - $USER -c 'nvm install-latest-npm'
sudo su - $USER -c 'npm install -g @nestjs/cli neovim sass typescript'

# Packages cargo
cargo install skim uwuify cargo-update procs rmz cpz
cargo install --locked zoxide bottom gitui ncspot

# ani-cli
git clone "https://github.com/pystardust/ani-cli.git"
sudo cp ani-cli/ani-cli /usr/local/bin
rm -rf ani-cli

# Update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo rm ~/.wget-hsts
sudo rm ~/.bash_history

mkdir ~/.config/git
mv ~/.gitconfig ~/.config/git/config
touch ~/.config/git/.gitignore_global
echo ".php-cs-fixer.cache" >> ~/.config/git/.gitignore_global
git config --global core.excludesfile ~/.config/git/.gitignore_global

# TODO: verifier si on a pas d'autres lignes à supprimer dans le bashrc ou bash_profile
sed -i '$ d' ~/.bashrc

# Config du greeter tuigreet + greetd
sudo cp ~/Dotfiles/install/greetd_tuigreet_config /etc/greetd/config.toml 
sudo cp ~/Dotfiles/install/keyboard /etc/modprobe.d/hid_apple.conf
sudo cp ~/Dotfiles/install/quiet_greeter /etc/sysctl.d/20-quiet-printk.conf
sudo cp ~/Dotfiles/install/keyboard_config /etc/default/keyboard

tldr --update
sudo apt update -y
sudo apt upgrade  -y
sudo apt autoremove -y

sudo reboot
