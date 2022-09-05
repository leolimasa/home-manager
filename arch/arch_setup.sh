#!/bin/bash
set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Use \"nmcli device wifi connect [SSID] password [PASSWORD]\" to connect wifi."

# Downgrade kernel because i915 driver and bluetooth is f*cked on newer ones
# pacman --needed -U https://archive.archlinux.org/^Cckages/l/linux/linux-5.14.9.arch2-1-x86_64.pkg.tar.zst
#pacman --needed -U https://archive.archlinux.org/packages/l/linux/linux-5.12.15.arch1-1-x86_64.pkg.tar.zst


# Main packages
pacman --needed -S \
	networkmanager \
	pacman-contrib \
	sudo \
	flatpak \
	base-devel \
	cups \
	cups-pdf \
	system-config-printer \
	nss-mdns \
	ethtool \
	net-tools \
	bind-tools \
	the_silver_searcher \
	git \
	kitty

# Base user
if id leo &>/dev/null; then
	echo "User leo already exists. Skipping creation."
else
	useradd -m leo
	passwd leo
	echo "leo ALL=(ALL) ALL" > /etc/sudoers.d/sudo_leo
fi

# Wayland
#pacman --needed -S xorg-xwayland xorg-xlsclients qt5-wayland glfw-wayland

# KDE
if [ "$USE_KDE" = "yes" ]; then
	pacman -S xorg
	pacman --needed -S plasma-meta plasma-wayland-session kde-applications-meta sddm
	systemctl enable sddm
	flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo
fi

# Bluetooth
if [ "$USE_BLUETOOTH" = "yes" ]; then
	pacman --needed -S \
	bluez \
	bluez-utils \
	pulseaudio-bluetooth
	systemctl enable bluetooth
fi

# Networking
systemctl enable NetworkManager

# Flatpak repos

# Enable services
systemctl enable cups
systemctl enable avahi-daemon # for printing

# Fix network print discovery
cp $SCRIPT_DIR/templates/nsswitch.conf /etc/nsswitch.conf

# Add parallel downloads to pacman
pacman_isparallel_comment=$(cat /etc/pacman.conf | grep "#ParallelDownloads")
if [ -z "$pacman_isparallel_comment" ]; then
	cat /etc/pacman.conf \
		| sed "s/#ParallelDownloads/ParallelDownloads/g" \
		> /etc/pacman.conf
fi

$SCRIPT_DIR/firewall.sh
$SCRIPT_DIR/initramfs.sh
$SCRIPT_DIR/suspend.sh
$SCRIPT_DIR/grub.sh
