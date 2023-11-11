{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      foot
    ];

    home.file.".config/foot/foot.ini".text = builtins.readFile ./files/foot.ini;

    # override this on each machine
    home.file.".config/foot/custom-settings.ini".text = "";
  };
}
