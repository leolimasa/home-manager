{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    ./neovim2.nix
    ./tmux.nix
    ./kitty.nix
    ./zsh.nix
    ./xdg.nix
  ];

}
