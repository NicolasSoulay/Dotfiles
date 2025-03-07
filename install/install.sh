#!/usr/bin/bash

# Function: Save log to file
save_log() {
    touch ~/install.log
    LOG_FILE=~/install.log
    exec > >(tee -a "$LOG_FILE") 2>&1
}

# Function: update
update_system() {
    sudo apt update -y
    sudo apt upgrade -y
}

# Function: Prompt for GitHub credentials
setup_github_credentials() {
    while :; do
        read -p "GitHub username: " github_username
        if [ -n "$github_username" ]; then
            break
        fi
        echo "The GitHub username can't be empty! Please try again."
    done

    email_regex="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
    while :; do
        read -p "GitHub email: " github_email
        if [[ "$github_email" =~ $email_regex ]]; then
            break
        fi
        echo "Invalid email format! Please enter a valid email address."
    done
}


# Function: Create user directories
create_user_directories() {
    echo "==== Creating user directories ===="
    sudo apt install xdg-user-dirs -y
    xdg-user-dirs-update
    mkdir -p ~/.local/{state/bash,cache,share/themes,share/icons}
    mkdir -p ~/.config/nvm
    mkdir -p ~/Dev
    mkdir -p ~/Games/{PS1,PS2}
    mkdir -p ~/Sources ~/Torrents
    touch ~/.local/state/bash/history
    touch ~/.local/share/wget-hsts
}

# Function: Link dotfiles and config files
link_dotfiles() {
    echo "==== Linking dotfiles and config files ===="
    rm -f ~/.bashrc ~/.bash_aliases  
    cp ~/Dotfiles/install/conf-files/general/.bashrc ~/.bashrc
    cp ~/Dotfiles/install/conf-files/general/.bash_aliases ~/.bash_aliases

    ln -sf ~/Dotfiles/config/{awesome,nvim,rofi,starship,wikiman,wezterm,zathura} ~/.config/
    ln -sf ~/Dotfiles/Wallpapers ~/Pictures/Wallpapers
    ln -sf ~/Dotfiles/Screenshots ~/Pictures/Screenshots
    ln -sf ~/Dotfiles/bin ~/.local/bin
    ln -sf ~/Dotfiles/fonts ~/.local/share/fonts
    fc-cache -f -v

    echo "==== Source bashrc ===="
    source ~/.bashrc
}

# Function: Install essential tools
install_essential_tools() {
    echo "==== Installing essential tools ===="
    sudo apt install inotify-tools wget fzf bat gh jq man gawk w3m coreutils parallel findutils fd-find gettext unzip curl ripgrep xsel playerctl build-essential -y
    sudo apt install pipewire-audio pipewire-jack wireplumber -y
}

# Function: Install code related tools
install_code_tools() {
    echo "==== Installing code related tools ===="

    # Postgres
    echo "==== Installing Postgres ===="
    sudo apt install postgresql postgresql-client -y

    # PHP
    echo "==== Installing PHP ===="
    sudo apt install php php-mysql php-curl php-common libapache2-mod-php php-cli php-xml php-zip composer php-symfony-console php-gd php-pgsql -y

    # Python
    echo "==== Installing Python ===="
    sudo apt install python3 python3-pip python3-venv python3-pynvim -y

    # C/C++
    echo "==== Installing C/C++ ===="
    sudo apt install gcc g++ cmake clang ninja-build -y

    # Rust
    echo "==== Installing Rust ===="
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    echo "==== Source bashrc ===="
    source ~/.bashrc

    # Install de symfony
    echo "==== Installing Symfony ===="
    curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
    sudo apt install symfony-cli -y

    # Install de NodeJs et NPM
    echo "==== Installing NodeJs & NPM ===="
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install de packages NPM
    echo "==== Installing NPM packages ===="
    sudo su - $USER -c 'nvm install --lts'
    sudo su - $USER -c 'nvm install-latest-npm'
    sudo su - $USER -c 'npm install -g @nestjs/cli neovim sass typescript'
}

# Function: Install desktop environment
install_desktop_environment() {
    echo "==== Installing desktop environment ===="
    sudo apt install rofi picom awesome xorg -y
    sudo apt install zathura nitrogen greetd mpv cmus tealdeer -y
    sudo apt install thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin thunar-vcs-plugin -y
    sudo apt install thunderbird firefox-esr -y
    tldr --update

    mkdir -p ~/.config/xfce4
    touch ~/.config/xfce4/helpers.rc
    echo "TerminalEmulator=wezterm" >> ~/.config/xfce4/helpers.rc
}

# Function: Install and configure Flatpak
setup_flatpak() {
    echo "=== Installing Flatpak ==="
    sudo apt install flatpak -y
    flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install --user flathub com.discordapp.Discord org.duckstation.DuckStation org.kde.krita net.pcsx2.PCSX2 -y

    # Dossier pour emulateurs
    echo "==== Creating emulator directories ===="
    mkdir -p ~/.var/app/org.duckstation.DuckStation/config/duckstation/bios
    mkdir -p ~/.var/app/org.duckstation.DuckStation/config/duckstation/games
    ln -sf ~/.var/app/org.duckstation.DuckStation/config/duckstation/bios ~/Games/PS1/BIOS
    ln -sf ~/.var/app/org.duckstation.DuckStation/config/duckstation/games ~/Games/PS1/ROMS

    mkdir -p ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/bios
    mkdir -p ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/games
    ln -sf ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/bios ~/Games/PS2/BIOS
    ln -sf ~/.var/app/net.pcsx2.PCSX2/config/PCSX2/games ~/Games/PS2/ROMS
}

# Function: Configure Git
configure_git() {
    echo "==== Configure Git ===="
    git config --global user.email "$github_email"
    git config --global user.name "$github_username"
    git config --global init.defaultBranch main

    echo "==== Installing Git Credential Manager ===="
    wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb" -O gcm.deb
    sudo dpkg -i gcm.deb
    git config --global credential.credentialStore plaintext
    git-credential-manager configure
    sudo rm gcm.deb

    echo "==== Clean up Git config ===="
    mkdir -p ~/.config/git
    mv ~/.gitconfig ~/.config/git/config
    touch ~/.config/git/.gitignore_global
    echo ".php-cs-fixer.cache" >> ~/.config/git/.gitignore_global
    git config --global core.excludesfile ~/.config/git/.gitignore_global
}

# Function: Install applications
install_applications() {
    if [ "$INSTALL_APPLICATIONS" = true ] ; then
        echo "==== Installing applications ===="
        sudo apt install steam-installer libreoffice blender deluge -y
    fi


    # install de MEGA
    if [ "$INSTALL_MEGA" = true ] ; then
        echo "==== Installing MEGA ===="
        wget https://mega.nz/linux/repo/Debian_12/amd64/megasync-Debian_12_amd64.deb && sudo apt install "$PWD/megasync-Debian_12_amd64.deb" -y
        rm megasync-Debian_12_amd64.deb
    fi

    # Install de neovim stable depuis les sources
    echo "==== Installing Neovim ===="
    cd ~/Sources
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout nightly    
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ~

    # Install de lazygit pour neovim
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    mkdir -p ~/.config/lazygit
    touch ~/.config/lazygit/config.yml

    # Pyfa
    if [ "$INSTALL_PYFA" = true ] ; then
        echo "==== Installing Pyfa ===="
        APPIMAGE_PATH_PYFA=~/Sources/Pyfa/Pyfa.AppImage
        DESKTOP_FILE_PATH_PYFA=~/.local/share/applications/pyfa.desktop
        curl -s https://api.github.com/repos/pyfa-org/Pyfa/releases/latest | \
        grep -oP '"browser_download_url": "\K(.*?Pyfa.*?AppImage)(?=")' | \
        xargs -n 1 curl -L -o "$APPIMAGE_PATH_PYFA"
        chmod +x "$APPIMAGE_PATH_PYFA"
        ln -sf "$APPIMAGE_PATH_PYFA" ~/.local/bin/pyfa
        mkdir -p ~/.local/share/applications
        cat > "$DESKTOP_FILE_PATH_PYFA" <<EOF
[Desktop Entry]
Name=Pyfa
Comment=Python Fitting Assistant for EVE Online
Exec=$APPIMAGE_PATH_PYFA
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Game;
EOF
    fi

    # Wine
    echo "==== Installing Wine ===="
    sudo dpkg --add-architecture i386 && sudo apt update
    sudo apt install wine wine64 libwine libwine:i386 fonts-wine -y

    # Reaper
    echo "==== Downloading Reaper ===="
    wget -O reaper_latest_x86_64.tar.xz "https://www.reaper.fm/$(curl -s https://www.reaper.fm/download.php | grep -oP 'href="\Kfiles/[0-9]+\.[xX]/reaper[0-9]+_linux_x86_64\.tar\.xz' | head -n 1)"
    mkdir -p ~/Sources/reaper
    tar -xf reaper_latest_x86_64.tar.xz -C ~/Sources/reaper
    rm reaper_latest_x86_64.tar.xz
    # ./~/Sources/reaper_linux_x86_64/install-reaper.sh

    # Wikiman
    echo "==== Installing Wikiman ===="
    sudo apt install parallel -y 
    cd ~/Sources/
    git clone 'https://github.com/filiparag/wikiman'
    cd ./wikiman
    git checkout $(git describe --tags | cut -d'-' -f1)
    make all
    sudo make install
    cd ..
    curl -L 'https://raw.githubusercontent.com/filiparag/wikiman/master/Makefile' -o 'wikiman-makefile'
    make -f ./wikiman-makefile source-arch
    sudo make -f ./wikiman-makefile source-install
    sudo make -f ./wikiman-makefile clean
    sudo rm ./wikiman-makefile
    cd ~

    # TUIGreet
    echo "==== Installing TUIGreet ===="
    cd ~/Sources/
    git clone https://github.com/apognu/tuigreet && cd tuigreet
    cargo build --release
    sudo mv target/release/tuigreet /usr/local/bin/tuigreet
    sudo mkdir /var/cache/tuigreet
    sudo chown _greetd:_greetd /var/cache/tuigreet
    sudo chmod 0755 /var/cache/tuigreet
    cd ~

    # Ani-cli
    echo "==== Installing Ani-cli ===="
    cd ~/Sources
    git clone "https://github.com/pystardust/ani-cli.git"
    ln -sf ~/Sources/ani-cli/ani-cli ~/.local/bin/ani-cli

    # Cargo applications
    echo "==== Installing Cargo applications ===="
    cargo install eza

    # Ncspot
    echo "==== Installing Ncspot ===="
    sudo apt install libssl-dev libncurses-dev libncursesw5-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render0-dev libpulse-dev libxcb1-dev libdbus-1-dev -y 
    cargo install --locked ncspot

    # Wezterm
    echo "==== Installing Wezterm ===="
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt update -y
    sudo apt install wezterm-nightly -y

    # Starship
    echo "==== Installing Starship ===="
    curl -sS https://starship.rs/install.sh | sh -s -- -y

    # Gog downloader
    if [ "$INSTALL_GOG" = true ] ; then
        echo "==== Installing Gog Downloader ===="
        sudo apt install build-essential libcurl4-openssl-dev libboost-regex-dev libjsoncpp-dev librhash-dev libtinyxml2-dev libtidy-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-date-time-dev libboost-iostreams-dev cmake pkg-config zlib1g-dev qtwebengine5-dev ninja-build -y
        cd ~/Sources
        git clone https://github.com/Sude-/lgogdownloader
        cd lgogdownloader
        cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_QT_GUI=ON -GNinja
        sudo ninja -C build install
        cd ~
    fi
}

# Function: Install custom themes
install_themes() {
    echo "==== Installing custom themes ===="

    # Themes
    echo "==== Installing custom GTK themes ===="
    mkdir -p ~/.config/gtk-3.0
    cat > ~/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=Gruvbox-Dark-Medium
gtk-icon-theme-name=Gruvbox-Plus-Dark
gtk-font-name=Sans 10
gtk-cursor-theme-name=Nordzy-cursors-white
gtk-cursor-theme-size=24
EOF
    mkdir -p ~/.config/gtk-4.0
    cat > ~/.config/gtk-4.0/settings.ini <<EOF
[Settings]
gtk-theme-name=Gruvbox-Dark-Medium
gtk-icon-theme-name=Gruvbox-Plus-Dark
gtk-font-name=Sans 10
gtk-cursor-theme-name=Nordzy-cursors-white
gtk-cursor-theme-size=24
EOF
    mkdir -p ~/.config/gtk-2.0
    cat > ~/.config/gtk-2.0/gtkrc <<EOF
gtk-theme-name="Gruvbox-Dark-Medium"
gtk-icon-theme-name="Gruvbox-Plus-Dark"
gtk-cursor-theme-name="Nordzy-cursors-white"
gtk-cursor-theme-size=24
EOF
    git clone https://github.com/guillaumeboehm/Nordzy-cursors.git ~/Sources/Nordzy-cursors
    git clone https://github.com/SylEleuth/gruvbox-plus-icon-pack.git ~/Sources/gruvbox-plus-icon-pack
    ln -sf ~/Sources/Nordzy-cursors/xcursors/Nordzy-cursors-white ~/.local/share/icons/Nordzy-cursors-white
    ln -sf ~/Sources/gruvbox-plus-icon-pack/Gruvbox-Plus-Dark ~/.local/share/icons/Gruvbox-Plus-Dark
    for file in ~/Dotfiles/install/conf-files/gtk-theme/*; do
        ln -sf "$file" "$HOME/.local/share/themes/$(basename "$file")"
    done
    for file in ~/Dotfiles/install/conf-files/gtk-theme/Gruvbox-Dark-Medium/gtk-4.0/*; do
        ln -sf "$file" "$HOME/.config/gtk-4.0/$(basename "$file")"
    done

    # Custom Firefox
    echo "==== Installing Firefox theme & config ===="
    firefox --headless &
    sleep 5
    pkill firefox
    FIREFOX_PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default-esr*" | head -n 1)
    cd ~/Sources
    git clone https://github.com/adriankarlen/textfox
    git clone https://github.com/arkenfox/user.js
    ln -sf ~/Sources/textfox/chrome  "$FIREFOX_PROFILE_DIR/chrome"
    cp ~/Sources/user.js/updater.sh "$FIREFOX_PROFILE_DIR/updater.sh"
    ln -sf ~/Dotfiles/install/conf-files/firefox/user-overrides.js "$FIREFOX_PROFILE_DIR/user-overrides.js"
    ln -sf ~/Dotfiles/install/conf-files/firefox/config.css ~/Sources/textfox/chrome/config.css
    cd ~
    (exec $FIREFOX_PROFILE_DIR/updater.sh -es)
}

# Function: Greeter and keyboard configuration
greeter_config() {
    echo "==== Greeter and keyboard configuration ===="
    sudo cp ~/Dotfiles/install/conf-files/greeter/greetd_tuigreet_config /etc/greetd/config.toml 
    sudo cp ~/Dotfiles/install/conf-files/keyboard/keyboard /etc/modprobe.d/hid_apple.conf
    sudo cp ~/Dotfiles/install/conf-files/greeter/quiet_greeter /etc/sysctl.d/20-quiet-printk.conf
    sudo cp ~/Dotfiles/install/conf-files/keyboard/keyboard_config /etc/default/keyboard
}

# Function: Cleanup and finalize
cleanup() {
    echo "==== Cleaning up ===="
    sudo apt autoremove -y
    sudo rm -f ~/.bash_history ~/.bash_logout ~/.wget-hsts
    sed -i '$ d' ~/.bashrc
}

# Main script execution
main() {
    read -p "Do you want to save the log to a file? [y/N]: " confirm && [[ $confirm == [yY] ]] && SAVE_LOG=true
    read -p "Do you want to install heavy applications? [y/N]: " confirm && [[ $confirm == [yY] ]] && INSTALL_APPLICATIONS=true
    read -p "Do you want to install Mega? [y/N]: " confirm && [[ $confirm == [yY] ]] && INSTALL_MEGA=true
    read -p "Do you want to install Pyfa? [y/N]: " confirm && [[ $confirm == [yY] ]] && INSTALL_PYFA=true
    read -p "Do you want to install Gog downloader? [y/N]: " confirm && [[ $confirm == [yY] ]] && INSTALL_GOG=true
    read -p "Do you want to setup Flaptak, Flathub ans some Flatpak apps? [y/N]: " confirm && [[ $confirm == [yY] ]] && INSTALL_FLAPTAK=true
    read -p "Do you want to install custom GTK and Firefox themes? [y/N]: " confirm && [[ $confirm == [yY] ]] && INSTALL_THEMES=true
    if [ "$SAVE_LOG" = true ] ; then
        save_log
        echo "---- Log saved to ~/install.log ----"
    fi
    update_system
    setup_github_credentials
    create_user_directories
    link_dotfiles
    install_essential_tools
    install_code_tools
    install_desktop_environment
    if [ "$INSTALL_FLAPTAK" = true ] ; then
        setup_flatpak
    fi
    configure_git
    install_applications
    if [ "$INSTALL_THEMES" = true ] ; then
        install_themes
    fi
    greeter_config
    cleanup
    read -p "Reboot now? [y/N]: " confirm && [[ $confirm == [yY] ]] && sudo reboot
}

main
