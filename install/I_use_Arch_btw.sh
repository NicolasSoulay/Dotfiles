#!/usr/bin/bash

# Install script for Arch Linux
# This is in progress, I will just document the app I might use with their dependencies for now

# Eww
# Dependencies:
#     gtk3 (libgdk-3, libgtk-3)
#     gtk-layer-shell (only on Wayland)
#     pango (libpango)
#     gdk-pixbuf2 (libgdk_pixbuf-2)
#     libdbusmenu-gtk3
#     cairo (libcairo, libcairo-gobject)
#     glib2 (libgio, libglib-2, libgobject-2)
#     gcc-libs (libgcc)
#     glibc
# (Note that you will most likely need the -devel variants of your distro's packages to be able to compile eww.)
#
# Installation: 
# git clone https://github.com/elkowar/eww
# cd eww
# cargo build --release --no-default-features --features=wayland
#
# Running:
# cd target/release
# chmod +x ./eww
#
# ./eww daemon
# ./eww open <window name>

# Rofi
# pacman -S rofi-wayland

# Hyprland + stuff
# pacman -S hyprland xdg-desktop-portal-hyprland hyprlock hyprpaper hyprcursor
# yay -S nordzy-hyprcursors

# file manager
# pacman -S nemo nemo-fileroller nemo-preview nemo-terminal
# xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
# gsettings set org.nemo.desktop show-desktop-icons false
# gsettings set org.cinnamon.desktop.default-applications.terminal exec wezterm
# gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg wezterm -e

# wezterm 
# yay -S wezterm-git
