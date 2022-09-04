#!/usr/bin/env bash
set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ ! -z "/etc/system_settings" ]; then
	echo "No /etc/system_settings detected. Quitting."
	exit 1
fi

# ------------------------------------------------------------------
# Setup partitions
# ------------------------------------------------------------------
#source $SCRIPT_DIR/setup_partitions.sh
if [ "$ENCRYPT_MAIN_PART" == "yes" ]; then
	mount --mkdir /dev/mapper/cryptroot /mnt
else
	mount --mkdir $MAIN_PART /mnt
fi

# ------------------------------------------------------------------
# Install base packages
# ------------------------------------------------------------------
pacstrap /mnt base linux linux-firmware
