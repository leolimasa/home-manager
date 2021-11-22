# Krohnkite 
mkdir -p /tmp/builds 
cd /tmp/builds
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/kwin-scripts-krohnkite-git.tar.gz
tar -xvf kwin-scripts-krohnkite-git.tar.gz
cd kwin-scripts-krohnkite-git
makepkg -s -i
makepkg -s -i # Running twice seems to build it correctly...

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
