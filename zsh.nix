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
      syntaxHighlighting = {
        enable = true;
      };
      initExtraFirst = 
      ''
      source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
      export PATH=$PATH:$HOME/pr/personal/home-manager/bin
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
         . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      else
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
      # End Nix
      '';

      # TO add git info to zsh, use:
      # export PS1=$'%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) %{$fg[blue]%}%*%{$reset_color%} %{$fg_bold[yellow]%}$ENV_NAME%{$reset_color%}\n$ '

      initExtra =
      ''
      eval $(persist load)
      source "$(fzf-share)/key-bindings.zsh"
      source "$(fzf-share)/completion.zsh"
      any-nix-shell zsh | source /dev/stdin
      export PS1=$'%{$fg_bold[green]%}%~%{$reset_color%} %{$fg[blue]%}%*%{$reset_color%} %{$fg_bold[yellow]%}$ENV_NAME%{$reset_color%}\n$ '
      export FZF_DEFAULT_COMMAND='ag -l'
      export GPG_TTY="$(tty)"
      # Uncomment for yubikey
      #export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
      #gpg-connect-agent updatestartuptty /bye > /dev/null
      export DEFAULT_SHELL=$(which zsh)
      # Local zsh config
      if [ -f "$HOME/.config/zsh" ]; then
        source "$HOME/.config/zsh"
      fi
      '';

      oh-my-zsh = {
        enable = true;
        plugins = ["dirhistory"];
        theme = "amuse";
      };
    };
  };

}
