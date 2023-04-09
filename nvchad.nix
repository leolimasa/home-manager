{ config, pkgs, ... }:

# Not using this currently, but leaving here as an example of how to
# setup a custom vim plugin.
let vim-breezy-theme = pkgs.vimUtils.buildVimPlugin {
    name = "vim-breezy-theme";
    src = pkgs.fetchFromGitHub {
      owner = "fneu";
      repo = "breezy";
      rev = "453167dc346f39e51141df4fe7b17272f4833c2b";

      # Easiest way to get a sha is to put some garbage here and check for
      # the error message. It will tell you the correct sha.
      sha256 = "09w4glff27sw4z2998gpq5vmlv36mfx9vp287spm7xvaq9fnn6gb";
    };
  };

in
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      nodejs
      fzf
      gcc
      tree-sitter
      cargo
    ];

    programs.neovim = {
    	enable = true;
    	viAlias = true;
	    vimAlias = true;

        plugins = with pkgs.vimPlugins; [
          vim-tmux-navigator
        ];
    };

    #home.file.".config/astronvim/lua/user/init.lua".text = builtins.readFile ./files/astronvim.lua;
    #home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    #   owner = "NvChad";
    #   repo = "NvChad";
    #   rev = "bb87d70";
    #   sha256 = "Z8UgxAKvC25EWT+6U3E8RjQIFNraDqlHCTcijt/2190=";
    #};
  };

}
