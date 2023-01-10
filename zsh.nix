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
      source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
      export PATH=$PATH:$HOME/pr/personal/home-manager/bin
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
         . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix
      '';

      initExtra =
      ''
      eval $(persist load)
      source "$(fzf-share)/key-bindings.zsh"
      source "$(fzf-share)/completion.zsh"
      any-nix-shell zsh | source /dev/stdin
      export PS1=$'%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) %{$fg[blue]%}%*%{$reset_color%} %{$fg_bold[yellow]%}$ENV_NAME%{$reset_color%}\n$ '
      export FZF_DEFAULT_COMMAND='ag -l'
      export GPG_TTY="$(tty)"
      # Uncomment for yubikey
      #export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
      #gpg-connect-agent updatestartuptty /bye > /dev/null
      export DEFAULT_SHELL=$(which zsh)
      '';

      oh-my-zsh = {
        enable = true;
        plugins = ["dirhistory"];
        theme = "amuse";
      };
    };
  };

}
