{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    environment.systemPackages = with pkgs; [
      nodejs
      fzf
    ];

    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ../files/tmux.conf; 
    };
  };
}
