{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.file.".config/user-dirs.dirs".text = builtins.readFile ./files/user-dirs.dirs;
  };

}
