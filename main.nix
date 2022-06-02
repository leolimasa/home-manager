{ config, pkgs, ... }:

{ 
  imports = [
  ];

  config = {

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "21.11";

    # Enable zsh
   # programs.zsh = {
   #   enable = true;
   #   shellAliases = {
   #     # Add any aliases here
   #   };
   # };

    home.packages = with pkgs; [
      jetbrains-mono
      ranger
    ];

    fonts.fontconfig.enable = true;
  };
}
