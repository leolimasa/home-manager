#!/bin/bash
# Run this script to setup from a raw arch image

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ -z "$DISK" ]; then
	echo "set DISK to where you want to install the system. Use fdisk -l to list."
	exit 1
fi

# Create partitions. First is EFI, then 2G swap space, and then fill the
# rest of the disk with a linux partition.

create_boot_part() {
	if [ -z "$CREATE_BOOT_PART" ]; then
		echo "Create boot EFI partition? (y/n):"
		read CREATE_BOOT_PART
	fi

	if [ "$CREATE_BOOT_PART" = "y" ]; then
		# those are fdisk commands. To replicate, just get into fdisk and
		# type the letters. Lines with no letters select the default option.
		fdisk $DISK <<EOF
n
p


+512M
t
ef
w
EOF
	fi
}

create_boot_part

