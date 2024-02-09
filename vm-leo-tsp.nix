{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    #./neovim2.nix
    ./leonvim.nix
    ./tmux.nix
    ./zsh.nix
    ./kitty.nix
    ./zellij.nix
  ];

  config = {
    home.file.".ssh/config".text = builtins.readFile /home/leo/pr/tsp/git/notes/tsp_ssh_config;
    home.file.".ssh/rc".text = builtins.readFile ./files/ssh_rc;
  };

}
