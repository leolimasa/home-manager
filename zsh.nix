{ config, pkgs, ... }:

{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      initExtraFirst = 
      ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
      export NIX_PATH=$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels
      export PATH=$PATH:$HOME/Code/personal/home-manager/bin
      '';
      initExtra =
      ''
      eval $(persist load)
      source "$(fzf-share)/key-bindings.zsh"
      source "$(fzf-share)/completion.zsh"
      '';
      oh-my-zsh = {
        enable = true;
        plugins = ["dirhistory"];
        theme = "amuse";
      };
    };
  };

}
