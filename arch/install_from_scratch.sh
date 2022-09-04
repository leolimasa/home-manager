#!/usr/bin/env bash
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
#source $SCRIPT_DIR/setup_partitions.sh
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
# Chroot to base system and setup basic config
# ------------------------------------------------------------------
#ln -s $SCRIPT_DIR /mnt/tmp/arch_install
cp "$SCRIPT_DIR/templates/locale.gen" /mnt/etc/locale.gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
echo "$MACHINE_NAME" > /mnt/etc/hostname