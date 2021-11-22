{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
    ];

    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./files/tmux.conf; 
    };
  };
}
