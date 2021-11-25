{ config, pkgs, ... }:

{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };
  };

}
