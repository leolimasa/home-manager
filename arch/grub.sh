#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source /etc/system_settings

if [ "$ENCRYPT_MAIN_PART" = "yes" ]; then
	CRYPT_UUID=$(echo "$blockdevs" | grep $CRYPT_PART[[:blank:]] | awk '{print $2}')
	GRUB_CMDLINE_LINUX="cryptdevice=UUID=$CRYPT_UUID:cryptroot root=/dev/mapper/cryptroot"
else
	MAIN_PART=/dev/$(lsblk -ln -o NAME,PARTTYPE $MAIN_DISK | grep 0x83 | awk '{print $1}')
	GRUB_CMDLINE_LINUX="root=$MAIN_PART"
fi
SWAP_PART=$(fdisk -l $MAIN_DISK | grep swap | awk '{print $1}')
blockdevs=$(lsblk -o NAME,UUID)
SWAP_UUID=$(echo "$blockdevs" | grep $SWAP_PART[[:blank:]] | awk '{print $2}')

GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX $GRUB_CMDLINE_LINUX_EXTRA"

cat $SCRIPT_DIR/templates/grub \
	| sed "s/{{GRUB_CMDLINE_LINUX}}/$GRUB_CMDLINE_LINUX/g" \
	| sed "s/{{SWAP_PART_UUID}}/$SWAP_UUID/g" \
	> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
