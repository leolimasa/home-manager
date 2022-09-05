#!/usr/bin/env bash
source /etc/system_settings
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Krohnkite 
# mkdir -p /tmp/builds 
#cd /tmp/builds
#curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/kwin-scripts-krohnkite-git.tar.gz
#tar -xvf kwin-scripts-krohnkite-git.tar.gz
#cd kwin-scripts-krohnkite-git
#makepkg -s -i
#makepkg -s -i # Running twice seems to build it correctly...

# Nix
curl -L https://nixos.org/nix/install | sh
echo ". /home/leo/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source /home/leo/.nix-profile/etc/profile.d/nix.sh

# Home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
echo "export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH" >> ~/.bashrc
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install

# Chrome
# mkdir -p /home/leo/AUR
# cd /home/leo/AUR
# git clone https://aur.archlinux.org/google-chrome.git
# cd google-chrome
# makepkg
# sudo pacman -U *.zst

# Plymouth
# We run this at the user level because it depends on AUR
if [ "$USE_PLYMOUTH" = "yes" ]; then
	$SCRIPT_DIR/plymouth.sh
fi

echo "!!! IMPORTANT !!!"
echo "Edit ~/.config/nixpkgs/home.nix, add programs.home-manager.enable = true and add an import to this machine's configuration in the git repo."
echo "Ex.:"
echo "  imports = ["
echo "    ~/path/to/git/this-machine.nix"
echo "  ];"
