{ config, pkgs, ... }:

{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      any-nix-shell
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
      any-nix-shell zsh | source /dev/stdin
      export PS1=$'%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) %{$fg[blue]%}%*%{$reset_color%} %{$fg_bold[yellow]%}$ENV_NAME%{$reset_color%}\n$ '
      '';

      oh-my-zsh = {
        enable = true;
        plugins = ["dirhistory"];
        theme = "amuse";
      };
    };
  };

}
