!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

# Ajout des bash alias
ln -s ~/Dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/Dotfiles/bash/.bash_aliases ~/.bash_aliases
ln -s ~/Dotfiles/bash/.bash_env ~/.bash_env

# Tous les fichier de config + les wallpapers
ln -s ~/Dotfiles/config/awesome ~/.config/awesome
ln -s ~/Dotfiles/config/kitty ~/.config/kitty
ln -s ~/Dotfiles/config/nvim ~/.config/nvim
ln -s ~/Dotfiles/config/rofi ~/.config/rofi
ln -s ~/Dotfiles/config/zathura ~/.config/zathura
ln -s ~/Dotfiles/wallpapers ~/Pictures/Wallpapers

# On fais les liens pour les scripts
mkdir ~/.local/bin/
ln -s ~/Dotfiles/scripts/* ~/.local/bin/

# On recupere les fonts et on met a jour le cache
ln -s ~/Dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -f -v

sudo su - $USER -c 'bash install-app.sh'
