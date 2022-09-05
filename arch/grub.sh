#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source /etc/system_settings
source $SCRIPT_DIR/modules/disk.sh

if [ "$ENCRYPT_MAIN_PART" = "yes" ]; then
	CRYPT_UUID=$(get_part_uuid $CRYPT_PART_NAME)
	GRUB_CMDLINE_LINUX="cryptdevice=UUID=$CRYPT_UUID:$CRYPT_PART_NAME root=$(get_part_path $CRYPT_PART_NAME)"
else
	MAIN_PART=$(get_part_path $MAIN_PART_NAME)
	GRUB_CMDLINE_LINUX="root=$MAIN_PART"
fi

SWAP_UUID=$(get_part_uuid $SWAP_PART_NAME)
GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX $GRUB_CMDLINE_LINUX_EXTRA"

cat $SCRIPT_DIR/templates/grub \
	| sed "s/{{GRUB_CMDLINE_LINUX}}/$GRUB_CMDLINE_LINUX/g" \
	| sed "s/{{SWAP_PART_UUID}}/$SWAP_UUID/g" \
	> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
