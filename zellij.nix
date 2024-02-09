{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      zellij
    ];

    home.file.".config/zellij/config.kdl".text = builtins.readFile ./files/zellij/config.kdl;
    home.file.".config/zellij/layouts/default.kdl".text = builtins.readFile ./files/zellij/layouts/default.kdl;
  };
}
