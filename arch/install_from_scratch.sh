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
if [ "$ENCRYPT_MAIN_PART" = "yes" ]; then
	mount /dev/mapper/cryptroot /mnt
else
	MAIN_PART=/dev/$(lsblk -ln -o NAME,PARTTYPE $MAIN_DISK | grep 0x83 | awk '{print $1}')
	mount $MAIN_PART /mnt
fi
if [ "$USE_EFI_PART" == "yes" ]; then
	efipart=$(fdisk -l $MAIN_DISK | grep EFI | awk '{print $1}')
	mount --mkdir $efipart /mnt/boot
fi

# ------------------------------------------------------------------
# Install base packages
# ------------------------------------------------------------------
pacstrap /mnt base linux linux-firmware
