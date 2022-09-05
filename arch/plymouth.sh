#!/usr/bin/env bash
set -e
set -x
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# install plymouth
arch_aurinstall plymouth-git

# replace sddm with sddm-plymouth
systemctl disable sddm || true
systemctl enable sddm-plymouth
