{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    go_1_18
    gopls
  ]; 

  # Runs a command after shell is started
  shellHook = ''
    export ENV_NAME=nix-go-1.18
  '';
}
