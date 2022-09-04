#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source /etc/system_settings

# default hooks
HOOKS="base udev autodetect modconf block filesystems keyboard keymap resume fsck"

if [ "$USE_PLYMOUTH" = "yes" ] && [ "$USE_CRYPT" = "yes" ]; then
	HOOKS="base udev plymouth autodetect modconf block filesystems keyboard keymap resume fsck plymouth-encrypt"
elif [ "$USE_CRYPT" = "yes" ]; then
	HOOKS="base udev autodetect modconf block filesystems keyboard keymap resume fsck encrypt"
fi

cat $SCRIPT_DIR/templates/mkinitcpio.conf \
	| sed "s/{{HOOKS}}/$HOOKS/g" \
	> /etc/mkinitcpio.conf
mkinitcpio -P
