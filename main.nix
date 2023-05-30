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
    home.stateVersion = "22.11";

    # Enable zsh
   # programs.zsh = {
   #   enable = true;
   #   shellAliases = {
   #     # Add any aliases here
   #   };
   # };

    home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    '';

    home.packages = with pkgs; [
      #jetbrains-mono
      nerdfonts
      ranger
      ripgrep
      silver-searcher
      imagemagick
      lazygit
      sshfs
      racket
    ];

    fonts.fontconfig.enable = true;
  };
}
