# Install Nix

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

If the above doesn't work, do:

```
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

# Install home manager

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

# Configure home manager file to point to your machine

Edit `~/.config/nixpkgs/home.nix` and add

```
  imports = [
	/home/leo/pr/personal/home-manager/box-desktop1.nix
  ];
```

replacing the file accordingly.

# Install and change default shell to zsh

```
cat /etc/shells
chsh
```

