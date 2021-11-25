{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    ./neovim.nix
    ./neovim_python.nix
    ./tmux.nix
    ./zsh.nix
  ];

}
