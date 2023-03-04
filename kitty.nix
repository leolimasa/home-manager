{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
    ];

    home.file.".config/kitty/current-theme.conf".text = builtins.readFile ./files/kitty/current-theme.conf;
    home.file.".config/kitty/kitty.conf".text = builtins.readFile ./files/kitty/kitty.conf;

    # override this on each machine
    home.file.".config/kitty/custom-settings.conf".text = "";
  };
}
