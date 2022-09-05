#!/usr/bin/env bash
# Installs the entire system starting from a live arch image terminal.
set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ ! -f "/etc/system_settings" ]; then
	echo "No /etc/system_settings detected. Quitting."
	exit 1
fi

source /etc/system_settings

# ------------------------------------------------------------------
# Setup partitions
# ------------------------------------------------------------------
source $SCRIPT_DIR/setup_partitions.sh
#if [ "$ENCRYPT_MAIN_PART" = "yes" ]; then
#	mount /dev/mapper/cryptroot /mnt
#else
#	MAIN_PART=/dev/$(lsblk -ln -o NAME,PARTTYPE $MAIN_DISK | grep 0x83 | awk '{print $1}')
#	mount $MAIN_PART /mnt
#fi
#if [ "$USE_EFI_PART" == "yes" ]; then
#	efipart=$(fdisk -l $MAIN_DISK | grep EFI | awk '{print $1}')
#	mount --mkdir $efipart /mnt/boot
#fi

# ------------------------------------------------------------------
# Install base system
# ------------------------------------------------------------------
#pacstrap /mnt base linux linux-firmware
#genfstab -U /mnt >> /mnt/etc/fstab

# ------------------------------------------------------------------
# Basic config (hostname, locale, etc)
# ------------------------------------------------------------------

# Have our scripts available within chroot
cp -r $SCRIPT_DIR/.. /mnt/home-manager
cp /etc/system_settings /mnt/etc/system_settings

# Set hostname
#echo "$MACHINE_NAME" > /mnt/etc/hostname

# Set locale
#cp "$SCRIPT_DIR/templates/locale.gen" /mnt/etc/locale.gen
#echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Set timezone
#arch-chroot /mnt ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Sync system clock
#arch-chroot /mnt hwclock --systohc

# Set root password
#echo "Set a root password:"
#arch-chroot /mnt passwd

# ------------------------------------------------------------------
# Install grub
# ------------------------------------------------------------------
#arch-chroot /mnt pacman --needed -S grub 
#if [ "$USE_EFI_PART" = "yes" ]; then
#	echo "Installing GRUB on EFI partition"
#	arch-chroot /mnt pacman --needed -S efibootmgr
#	arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot bootloader-id=GRUB
#else
#	echo "Installing GRUB on MBR"
#	arch-chroot /mnt grub-install --target=i386-pc $MAIN_DISK
#fi
	
# ------------------------------------------------------------------
# Setup rest of the system in chroot
# ------------------------------------------------------------------
#arch-chroot /mnt /home-manager/arch/arch_setup.sh


# ------------------------------------------------------------------
# Setup user home
# ------------------------------------------------------------------
arch-chroot sudo -u leo /home-manager/arch/user-setup.sh

# ------------------------------------------------------------------
# Symlink the final user settings
# ------------------------------------------------------------------
