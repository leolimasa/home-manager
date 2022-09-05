#!/bin/bash
# Run this script to setup the initial partitions using GPT.
# This is NOT idempontent (yet). So running this more than once WILL screw things up.
set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source /etc/system_settings
source $SCRIPT_DIR/modules/disk.sh


# -----------------------------------------------------------------------------
# Create partitions. First is EFI, then 2G swap space, and then fill the
# rest of the disk with a linux partition.
# -----------------------------------------------------------------------------

if [ "$USE_EFI_PART" = "yes" ]; then
	create_efi_part $MAIN_DISK
fi
if [ "$USE_SWAP_PART" = "yes" ]; then
	create_swap_part $MAIN_DISK
fi
create_main_part $MAIN_DISK
