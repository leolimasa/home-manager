{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    ./neovim2.nix
    #./neovim_python.nix
    #./spacevim.nix
    #./spacevim_python.nix
    ./tmux.nix
    ./kitty.nix
    ./zsh.nix
  ];

}
