SWAP_PART_NAME="swap_cesh3"
CRYPT_PART_NAME="crypt_h5v60"
MAIN_PART_NAME="arch_linux_1xq2h"
EFI_PART_NAME="efi_y8jo3"
GPT_BIOS_PART_NAME="gpt_bios_8y6q8"

next_part_number() {
	partcount=$(sgdisk -p $MAIN_DISK | grep "^\s*[[:digit:]]" | wc -l)
	echo $(($partcount+1))
}

get_part_path() {
	lsblk -l -o PATH,PARTLABEL,NAME | grep $1 | awk '{print $1}'
}

get_part_uuid() {
	lsblk -l -o UUID,PARTLABEL,NAME | grep $1 | awk '{print $1}'
}


create_efi_part() {
	disk=$1
	efipart=$(get_part_path $EFI_PART_NAME)
	if [ ! -z "$efipart" ]; then
		echo "EFI partition detected. Skipping."
		return 0
	fi

	# Create the partition
	partnum=$(next_part_number)
	sgdisk -n $partnum:0:+512M -t $partnum:ef00 -c $partnum:"$EFI_PART_NAME" $disk
	sleep 1
	mkfs.fat -F 32 $(get_part_path $EFI_PART_NAME)
}

create_gpt_bios_part() {
	disk=$1
	if [ ! -z "$(get_part_path $GPT_BIOS_PART_NAME)" ]; then
		echo "BIOS partition detected. Skipping."
		return 0
	fi
	partnum=$(next_part_number)

	# See https://wiki.archlinux.org/title/GRUB#GUID_Partition_Table_(GPT)_specific_instructions
	sgdisk -n $partnum:0:+1M -t $partnum:ef02 -U $partnum:"21686148-6449-6E6F-744E-656564454649" -c $partnum:"$GPT_BIOS_PART_NAME" $disk
}

create_swap_part() {
	disk=$1
	if [ ! -z "$(get_part_path $SWAP_PART_NAME)" ]; then
		echo "Swap partition detected. Skipping."
		return 0
	fi

	# Create the partition
	partnum=$(next_part_number)
	sgdisk -n $partnum:0:+2G -t $partnum:8200 -c $partnum:"$SWAP_PART_NAME" $disk
	sleep 1
	mkswap $(get_part_path $SWAP_PART_NAME)
}

encrypt_part() {
	part=$1
	name=$2
	cryptsetup luksFormat $part
	cryptsetup open $part $name
	mkfs -t ext4 /dev/mapper/$name
}

create_main_part() {
	if [ ! -z "$(get_part_path $MAIN_PART_NAME)" ]; then
		echo "Main partition detected. Skipping."
		return 0
	fi

	# Create the partition
	partnum=$(next_part_number)
	endsector=$(sgdisk -E $MAIN_DISK)
	sgdisk -n $partnum:0:$endsector -t $partnum:8300 -c $partnum:"$MAIN_PART_NAME" $MAIN_DISK
	sleep 1

	MAIN_PART=$(get_part_path "$MAIN_PART_NAME")
	if [ "$ENCRYPT_MAIN_PART" == "yes" ]; then
		encrypt_part $MAIN_PART $CRYPT_PART_NAME
	else
		mkfs -t ext4 $MAIN_PART
	fi
}
