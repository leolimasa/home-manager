#!/usr/bin/env bash
# Installs the entire system starting from a live arch image terminal.
# Copy and paste this to start:
#
# pacman -Sy git && git clone https://github.com/leolimasa/home-manager.git
set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ ! -f "/etc/system_settings" ]; then
	if [ -z "$SYSTEM_SETTINGS_FILE" ]; then
		echo "No SYSTEM_SETTINGS_FILE or /etc/system_settings detected. Quitting."
		exit 1
	else
		echo "Linking system settings"
		ln -s $SCRIPT_DIR/configs/$SYSTEM_SETTINGS_FILE /etc/system_settings
	fi
fi

source /etc/system_settings

# ------------------------------------------------------------------
# Setup partitions
# ------------------------------------------------------------------
source $SCRIPT_DIR/setup_partitions.sh
if [ "$ENCRYPT_MAIN_PART" = "yes" ]; then
	cryptroot_mounted=$(mount | grep $(get_part_path $CRYPT_PART_NAME) | awk '{print $1}')
	if [ -z "$cryptroot_mounted" ]; then
		echo "Mounting encrypted partition"
		mount $(get_part_path $CRYPT_PART_NAME) /mnt
	fi
else
	MAIN_PART=$(get_part_path $MAIN_PART_NAME)
	main_mounted=$(mount | grep $MAIN_PART)
	if [ -z "$main_mounted" ]; then
		mount $MAIN_PART /mnt
	fi
fi
if [ "$USE_EFI_PART" == "yes" ]; then
	efipart=$(get_part_path $EFI_PART_NAME)
	efimounted=$(mount | grep $efipart)
	if [ -z "$efimounted" ]; then
		mount --mkdir $efipart /mnt/boot
	fi
fi

# ------------------------------------------------------------------
# Install base system and kernel
# ------------------------------------------------------------------
pacstrap /mnt base linux linux-firmware

# ------------------------------------------------------------------
# Basic config (hostname, locale, etc)
# ------------------------------------------------------------------

# Generate fstab
genfstab -U /mnt > /mnt/etc/fstab

# Have our scripts available within chroot
cp -r $SCRIPT_DIR/.. /mnt/home-manager
cp /etc/system_settings /mnt/etc/system_settings

# Set hostname
echo "$MACHINE_NAME" > /mnt/etc/hostname

# Set locale
cp "$SCRIPT_DIR/templates/locale.gen" /mnt/etc/locale.gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Set timezone
arch-chroot /mnt ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Sync system clock
arch-chroot /mnt hwclock --systohc

# ------------------------------------------------------------------
# Install grub
# ------------------------------------------------------------------
arch-chroot /mnt pacman --needed -Sy grub 
if [ "$USE_EFI_PART" = "yes" ]; then
	echo "Installing GRUB on EFI partition"
	arch-chroot /mnt pacman --needed -S efibootmgr
	arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot bootloader-id=GRUB
else
	echo "Installing GRUB on GPT"
	arch-chroot /mnt grub-install --target=i386-pc $MAIN_DISK
fi

export CRYPT_UUID=$(get_part_uuid $CRYPT_PART_NAME)
export SWAP_UUID=$(get_part_uuid $SWAP_PART_NAME)
arch-chroot /mnt /home-manager/arch/grub.sh
	
# ------------------------------------------------------------------
# Setup rest of the system 
# ------------------------------------------------------------------

# Main packages
arch-chroot /mnt /home-manager/arch/arch_setup.sh

# User home
arch-chroot /mnt sudo -u leo /home-manager/arch/user_setup.sh

# ------------------------------------------------------------------
# Symlink the final user settings
# ------------------------------------------------------------------

# Set root password
echo "Set a root password:"
arch-chroot /mnt passwd
