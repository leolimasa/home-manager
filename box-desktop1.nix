{ config, pkgs, ... }:
{
  imports = [
    ./main.nix
    #./neovim2.nix
    ./leonvim.nix
    ./tmux.nix
    ./kitty.nix
    ./zsh.nix
    ./xdg.nix
  ];

  home.file.".config/kitty/custom-settings.conf".text = ''
    font_size 12.0
  '';
}
