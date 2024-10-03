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
mkdir -p ~/Games/BIOS
mkdir -p ~/Games/Emulator/
mkdir -p ~/Games/PS1
mkdir -p ~/Games/PS2
mkdir -p ~/Games/ROMS
mkdir -p ~/Games/ROMS/PS1
mkdir -p ~/Games/ROMS/PS2
mkdir -p ~/Games/BIOS
mkdir -p ~/Games/BIOS/PS1
mkdir -p ~/Games/BIOS/PS2
touch  ~/.local/state/bash/history
touch  ~/.local/share/wget-hsts

# Config apache2
sudo apt install apache2 -y
mkdir -p ~/Dev/localhost
sudo chmod 0755 ~/Dev/localhost
sudo chgrp www-data ~/Dev/localhost
sudo chmod 755 ~
sudo rm -r /var/www/html
sudo ln -s ~/Dev/localhost /var/www/html

# Copie .bashrc
rm ~/.bashrc
rm ~/.bash_aliases
cp ~/Dotfiles/install/.bashrc ~/.bashrc

# Tous les fichier de config + les wallpapers
ln -sf ~/Dotfiles/config/awesome ~/.config/awesome
ln -sf ~/Dotfiles/config/doublecmd ~/.config/doublecmd
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
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Clean du dossier home
sudo rm ~/.bash_history
sudo rm ~/.bash_logout
sudo rm ~/.wget-hsts

source ~/.bashrc

# Flatpak
flatpak install flathub io.dbeaver.DBeaverCommunity -y
# flatpak install flathub com.discordapp.Discord -y
# flatpak install flathub org.duckstation.DuckStation -y
# flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y
# flatpak install net.pcsx2.PCSX2 -y
# flatpak install flathub com.spotify.Client -y

# App
sudo dpkg --add-architecture i386 && sudo apt update
sudo apt install gimp firefox-esr thunderbird blender libreoffice qbittorrent timeshift steam-installer dwarf-fortress -y
sudo apt install wine wine32 wine64 libwine libwine:i386 fonts-wine -y

# Desktop env
sudo apt install rofi numlockx exa neofetch zathura doublecmd-gtk greetd bat fzf mpv tealdeer tmux -y

# Awesome Wm
sudo apt install awesome picom nitrogen xorg -y

# Utils
sudo apt install inotify-tools wget fzf gh jq findutils fd-find gettext unzip curl ripgrep xsel pavucontrol playerctl mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 -y
sudo apt install libdbus-1-dev libncursesw5-dev libpulse-dev libssl-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y

# Librairie SDL
sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev -y

# MariaDb
sudo apt install mariadb-server mariadb-client -y

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

# Compte default git
git config --global user.email "${github_email}"
git config --global user.name "${github_username}"
git config --global init.defaultBranch main

# Install et configuration de git credential manager
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.1.2/gcm-linux_amd64.2.1.2.deb" -O gcm.deb
sudo dpkg -i gcm.deb
git config --global credential.credentialStore plaintext
git-credential-manager configure
sudo rm gcm.deb

# Install de neovim stable depuis les sources
mkdir ~/Sources
cd ~/Sources
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
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
sudo apt install symfony-cli -y

# Install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install de packages NPM
sudo su - $USER -c 'nvm install --lts'
sudo su - $USER -c 'nvm install-latest-npm'
sudo su - $USER -c 'npm install -g @angular/cli neovim sass typescript'

# Packages cargo
cargo install skim uwuify cargo-update
cargo install --locked zoxide

# ani-cli
git clone "https://github.com/pystardust/ani-cli.git"
sudo cp ani-cli/ani-cli /usr/local/bin
rm -rf ani-cli

# Starhip
curl -sS https://starship.rs/install.sh | sh -y

# Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update -y
sudo apt install wezterm -y

# Update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo rm ~/.wget-hsts
sudo rm ~/.bash_history

mkdir ~/.config/git
mv ~/.gitconfig ~/.config/git/config
sed -i '$ d' ~/.bashrc

# Config du greeter tuigreet + greetd
sudo cp ~/Dotfiles/install/greetd_tuigreet_config /etc/greetd/config.toml 
sudo cp ~/Dotfiles/install/keyboard /etc/modprobe.d/hid_apple.conf
sudo cp ~/Dotfiles/install/quiet_greeter /etc/sysctl.d/20-quiet-printk.conf
sudo cp ~/Dotfiles/install/keyboard_config /etc/default/keyboard

sudo apt update -y
sudo apt upgrade  -y
sudo apt autoremove -y

sudo reboot
