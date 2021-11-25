#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cat $SCRIPT_DIR/templates/mkinitcpio.conf > /etc/mkinitcpio.conf
mkinitcpio -P
