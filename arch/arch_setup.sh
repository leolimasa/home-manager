#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Use \"nmcli device wifi connect [SSID] password [PASSWORD]\" to connect wifi."

# Downgrade kernel because i915 driver and bluetooth is f*cked on newer ones
# pacman --needed -U https://archive.archlinux.org/^Cckages/l/linux/linux-5.14.9.arch2-1-x86_64.pkg.tar.zst
pacman --needed -U https://archive.archlinux.org/packages/l/linux/linux-5.12.15.arch1-1-x86_64.pkg.tar.zst

# Base user
# TODO skip if user already exists
useradd leo
passwd leo

# Networking
systemctl enable NetworkManager

# Xorg
pacman -S xorg

# Wayland
#pacman --needed -S xorg-xwayland xorg-xlsclients qt5-wayland glfw-wayland

# KDE
pacman --needed -S plasma-meta plasma-wayland-session kde-applications-meta sddm
systemctl enable sddm


# Other packages
pacman --needed -S /
	pacman-contrib /
	sudo /
	flatpak /
	base-devel /
	cups /
	cups-pdf /
	bluez /
	bluez-utils /
	pulseaudio-bluetooth /
	system-config-printer /
	nss-mdns /
	ethtool /
	net-tools /
	bind-tools /
	the_silver_searcher /
	kitty

# Flatpak repos
flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo

# Enable services
systemctl enable cups
systemctl enable bluetooth
systemctl enable avahi-daemon # for printing

# Fix network print discovery
cp $SCRIPT_DIR/nsswitch.conf /etc/nsswitch.conf

# Add parallel downloads to pacman
echo "ParallelDownloads = 5" >> /etc/pacman.conf

source $SCRIPT_DIR/firewall.sh
source $SCRIPT_DIR/grub.sh
source $SCRIPT_DIR/initramfs.sh
source $SCRIPT_DIR/suspend.sh
