#!/bin/bash
# Run this script to setup the initial partitions using GPT.
# This is NOT idempontent (yet). So running this more than once WILL screw things up.
set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source /etc/system_settings

next_part_number() {
	partcount=$(sgdisk -p $MAIN_DISK | grep "^\s*[[:digit:]]" | wc -l)
	echo $(($partcount+1))
}

create_gpt_table() {
	if gdisk -l $MAIN_DISK | grep "GPT: present"; then
		echo "GPT partition table exists. Skipping."
		return
	fi
	# TODO
}

# -----------------------------------------------------------------------------
# Create partitions. First is EFI, then 2G swap space, and then fill the
# rest of the disk with a linux partition.
# -----------------------------------------------------------------------------
create_boot_part() {
	if [ "$USE_EFI_PART" != "yes" ]; then
		echo "Skipping creation of EFI boot partition."
		return
	fi
	efipart=$(fdisk -l $MAIN_DISK | grep EFI | awk '{print $1}')
	if [ ! -z "$efipart" ]; then
		echo "EFI partition detected. Skipping."
		return 0
	fi

	# Create the partition
	partnum=$(next_part_number)
	sgdisk -n $partnum:0:+512M -t $partnum:ef00 -c $partnum:"EFI boot" $MAIN_DISK
	sleep 1

	efipart=$(fdisk -l $MAIN_DISK | grep EFI | awk '{print $1}')
	mkfs.fat -F 32 $efipart
}

create_swap_part() {
	if [ "$USE_SWAP_PART" != "yes" ]; then
		echo "Skipping creation of swap partition."
		return
	fi
	swappart=$(fdisk -l $MAIN_DISK | grep swap | awk '{print $1}')
	if [ ! -z "$swappart" ]; then
		echo "Swap partition detected. Skipping."
		return 0
	fi

	# Create the partition
	partnum=$(next_part_number)
	sgdisk -n $partnum:0:+2G -t $partnum:8200 -c $partnum:"swap" $MAIN_DISK
	sleep 1

	swappart=$(fdisk -l $MAIN_DISK | grep swap | awk '{print $1}')
	mkswap $swappart
}

encrypt_main_part() {
	cryptsetup luksFormat $MAIN_PART
	cryptsetup open $MAIN_PART cryptroot
	mkfs -t ext4 /dev/mapper/cryptroot
}

create_main_part() {
	MAIN_PART_BLOCK=$(lsblk -ln -o NAME,PARTTYPE $MAIN_DISK | grep 0x83 | awk '{print $1}')
	if [ ! -z "$MAIN_PART_BLOCK" ]; then
		echo "Main partition detected. Skipping."
		return 0
	fi

	# Create the partition
	partnum=$(next_part_number)
	endsector=$(sgdisk -E $MAIN_DISK)
	sgdisk -n $partnum:0:$endsector -t $partnum:8300 -c $partnum:"arch linux" $MAIN_DISK
	sleep 1

	MAIN_PART=/dev/$(lsblk -ln -o NAME,PARTTYPE $MAIN_DISK | grep 0x83 | awk '{print $1}')
	if [ "$ENCRYPT_MAIN_PART" == "yes" ]; then
		encrypt_main_part
	else
		mkfs -t ext4 $MAIN_PART
	fi
}

create_boot_part
create_swap_part
create_main_part
