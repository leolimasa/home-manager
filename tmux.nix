{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      xclip
    ];

    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./files/tmux.conf; 
    };
  };
}
