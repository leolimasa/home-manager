#!/usr/bin/env bash
set -e
set -x
source /etc/system_settings
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Default directories
mkdir -p $HOME/code/personal
mkdir -p $HOME/code/reviews
mkdir -p $HOME/code/vendor

# Git repo
(cd $HOME/code/personal && git clone https://github.com/leolimasa/home-manager)
export PATH="$PATH:$HOME/code/personal/home-manager/bin"

# Nix
curl -L https://nixos.org/nix/install | sh
#echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source $HOME/.nix-profile/etc/profile.d/nix.sh

# Home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
#echo "export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH" >> ~/.bashrc
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
cat $SCRIPT_DIR/templates/home.nix \
	| sed "s/{{MACHINE_NAME}}/$MACHINE_NAME/g" \
	> $HOME/.config/nixpkgs/home.nix
nix-channel --update
home-manager switch

# Plymouth
# We run this at the user level because it depends on AUR
if [ "$USE_PLYMOUTH" = "yes" ]; then
	$SCRIPT_DIR/plymouth.sh
fi
