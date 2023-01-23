{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    ./neovim2.nix
    ./tmux.nix
    ./zsh.nix
  ];

  config = {
    #home.file.".ssh/config".text = builtins.readFile /home/leo/pr/tsp/notes/tsp_ssh_config;
  };

}
