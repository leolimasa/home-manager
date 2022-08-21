{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python310
    python310Packages.jedi
    python310Packages.mypy
    pipenv
  ]; 

  # Runs a command after shell is started
  shellHook = ''
    export ENV_NAME=nix-python-3.10
  '';
}
