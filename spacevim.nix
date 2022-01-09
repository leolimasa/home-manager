{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      xclip
      nodejs
      fzf
      ctags
    ];

    programs.neovim = {
    	enable = true;
    	viAlias = true;
	    vimAlias = true;
        configure = {
          customRC = builtins.readFile ./files/spacevim/init.vim;
        };

        plugins = with pkgs.vimPlugins; [
          vimwiki
        ];
    };

    home.file.".SpaceVim.d/init.toml".text = builtins.readFile ./files/spacevim/init.toml;
    home.file.".SpaceVim.d/autoload/myspacevim.vim".text = builtins.readFile ./files/spacevim/myspacevim.vim;
  };

}
