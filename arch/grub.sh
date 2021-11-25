#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source $SCRIPT_DIR/settings.sh

blockdevs=$(lsblk -o NAME,UUID)
CRYPT_UUID=$(echo "$blockdevs" | grep $CRYPT_PART[[:blank:]] | awk '{print $2}')
SWAP_UUID=$(echo "$blockdevs" | grep $SWAP_PART[[:blank:]] | awk '{print $2}')

cat $SCRIPT_DIR/templates/grub \
	| sed "s/{{CRYPT_PART_UUID}}/$CRYPT_UUID/g" \
	| sed "s/{{SWAP_PART_UUID}}/$SWAP_UUID/g" \
	> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
