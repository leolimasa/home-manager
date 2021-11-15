#!/bin/bash

echo "Use \"nmcli device wifi connect [SSID] password [PASSWORD]\" to connect wifi."

# ------------------
# System
# ------------------

# Downgrade kernel because i915 driver is f*cked on newer ones
pacman --needed -U https://archive.archlinux.org/^Cckages/l/linux/linux-5.14.9.arch2-1-x86_64.pkg.tar.zst

# Base user
# TODO skip if user already exists
useradd leo
passwd leo

# Networking
systemctl enable NetworkManager

# Xorg
#pacman -S xorg

# Wayland
pacman --needed -S xorg-xwayland xorg-xlsclients qt5-wayland glfw-wayland

# KDE
pacman --needed -S plasma-meta plasma-wayland-session kde-applications-meta sddm
systemctl enable sddm


# Other packages
pacman --needed -S /
	pacman-contrib /
	sudo /
	flatpak /
	base-devel

# ------------------
# User
# ------------------

sudo su - leo

# Krohnkite 
mkdir -p /tmp/builds 
cd /tmp/builds
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/kwin-scripts-krohnkite-git.tar.gz
tar -xvf kwin-scripts-krohnkite-git.tar.gz
cd kwin-scripts-krohnkite-git
makepkg -s -i
makepkg -s -i # Running twice seems to build it correctly...

# Nix
curl -L https://nixos.org/nix/install | sh
echo ". /home/leo/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source /home/leo/.nix-profile/etc/profile.d/nix.sh

# Home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
echo "export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH" >> ~/.bashrc
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
