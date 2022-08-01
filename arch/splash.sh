#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# install plymouth
arch_aurinstall plymouth-git

# update mkinitcpio if needed
src_sum=$(sha256sum "$SCRIPT_DIR/templates/mkinitcpio.conf")
dest_sum=$(sha256sum "/etc/mkinitcpio.conf")
if [ "$src_sum" != "$dest_sum" ]; then
	cat $SCRIPT_DIR/templates/mkinitcpio.conf > /etc/mkinitcpio.conf
	mkinitcpio -P
fi

# replace sddm with 
systemctl disable sddm || true
systemctl enable sddm-plymouth
