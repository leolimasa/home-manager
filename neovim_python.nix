{ config, pkgs, ... }:
let
  jupyter-vim = pkgs.vimUtils.buildVimPlugin {
    name = "jupyter-vim";
    src = pkgs.fetchFromGitHub {
      owner = "jupyter-vim";
      repo = "jupyter-vim";
      rev = "6a26f5beb84fadb983e1423f3661efad5efa0da7";

      # Easiest way to get a sha is to put some garbage here and check for
      # the error message. It will tell you the correct sha.
      sha256 = "08bhpvkmjvdnd959r174w7zyziijdly6iww67v7nnqxhii9xhma2";
    };
  };
in
{
  imports = [];

  config = {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        coc-python
        jupyter-vim
      ];

      withPython3 = true;

      extraPython3Packages = (ps: with ps; [
        jupyter
        pynvim
      ]);
    };
  };
}
