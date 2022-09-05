{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    ./neovim.nix
    ./neovim_python.nix
    #./spacevim.nix
    #./spacevim_python.nix
    ./tmux.nix
    ./kitty.nix
    #./zsh.nix
  ];

}
