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
        read -p "Git username: " git_username
        if [ -n "$git_username" ]; then
            break
        fi
        echo "The GitHub username can't be empty! Please try again."
    done

    email_regex="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
    while :; do
        read -p "Git email: " git_email
        if [[ "$git_email" =~ $email_regex ]]; then
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
    sudo apt install wget fzf bat jq man gawk coreutils parallel findutils fd-find gettext unzip curl ripgrep xsel playerctl build-essential -y
    sudo apt install pipewire-audio pipewire-jack wireplumber pulseaudio-utils pavucontrol -y
}

# Function: Install code related tools
install_code_tools() {
    echo "==== Installing code related tools ===="

    # Rust
    echo "==== Installing Rust ===="
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    echo "==== Source bashrc ===="
    source ~/.bashrc

}

# Function: Install desktop environment
install_desktop_environment() {
    echo "==== Installing desktop environment ===="
    sudo apt install rofi picom awesome eza xorg -y
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
    git config --global user.email "$git_email"
    git config --global user.name "$git_username"
    git config --global init.defaultBranch main

    echo "==== Clean up Git config ===="
    mkdir -p ~/.config/git
    mv ~/.gitconfig ~/.config/git/config
}

# Function: Install applications
install_applications() {
    echo "==== Installing applications ===="
    sudo apt install steam-installer libreoffice deluge -y

    # Install de neovim stable depuis les sources
    echo "==== Installing Neovim ===="
    # dependencies
    sudo apt install ninja-build gettext cmake unzip curl -y
    cd ~/Sources
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout nightly    
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ~

    # lua-language-server
    cd ~/Sources
    git clone https://github.com/LuaLS/lua-language-server
    cd lua-language-server
    ./make.sh
    ln -sf ~/Sources/lua-language-server/bin/lua-language-server ~/.local/bin/lua-language-server
    cd ~

    # stylua + rustfmt + rustanalyzer
    cargo install stylua --features luajit
    rustup component add rustfmt rust-analyzer

    # Wine
    echo "==== Installing Wine ===="
    sudo dpkg --add-architecture i386 && sudo apt update
    sudo apt install wine wine64 libwine libwine:i386 fonts-wine -y

    # Wikiman
    echo "==== Installing Wikiman ===="
    sudo apt install parallel -y 
    cd ~/Sources/
    git clone 'https://github.com/filiparag/wikiman'
    cd ./wikiman
    git checkout $(git describe --tags | cut -d'-' -f1)
    make all
    sudo make install
    cd ~/Sources
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
    echo "==== Installing Gog Downloader ===="
    sudo apt install build-essential libcurl4-openssl-dev libboost-regex-dev libjsoncpp-dev librhash-dev libtinyxml2-dev libtidy-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-date-time-dev libboost-iostreams-dev cmake pkg-config zlib1g-dev qtwebengine5-dev ninja-build -y
    cd ~/Sources
    git clone https://github.com/Sude-/lgogdownloader
    cd lgogdownloader
    cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_QT_GUI=ON -GNinja
    sudo ninja -C build install
    cd ~
}

# Function: Install custom themes
install_themes() {
    echo "==== Installing custom themes ===="

    # Bat config
    echo "==== Installing bat theme ===="
    mkdir ~/.config/bat
    mkdir ~/.config/bat/themes
    cd ~/.config/bat/themes
    git clone https://github.com/molchalin/gruvbox-material-bat
    batcat cache --build
    cd ~

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
    sudo cp ~/Dotfiles/install/conf-files/keyboard/keyboard_config /etc/default/keyboard
    sudo cp ~/Dotfiles/install/conf-files/keyboard/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
    sudo cp ~/Dotfiles/install/conf-files/greeter/quiet_greeter /etc/sysctl.d/20-quiet-printk.conf
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
    setup_flatpak
    configure_git
    install_applications
    install_themes
    greeter_config
    cleanup
    read -p "Reboot now? [y/N]: " confirm && [[ $confirm == [yY] ]] && sudo reboot
}

main
