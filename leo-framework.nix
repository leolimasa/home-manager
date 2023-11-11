{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    #./neovim2.nix
    #./neovim_python.nix
    #./spacevim.nix
    #./spacevim_python.nix
    #./astronvim.nix
    ./leonvim.nix
    ./tmux.nix
    ./kitty.nix
    ./foot.nix
    ./zsh.nix
  ];

}
