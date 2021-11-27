#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Fix suspend getting interrupted by ACPI event
cp $SCRIPT_DIR/templates/disable_txhc.service /etc/systemd/system/
cp $SCRIPT_DIR/templates/disable_txhc /usr/bin/disable_txhc
chmod +x /usr/bin/disable_txhc
systemctl enable disable_txhc
