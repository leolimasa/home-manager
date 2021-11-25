# nixpkgs-21.05-darwin

# Waiting on https://github.com/NixOS/nixpkgs/issues/107519
# to be fixed so we can use it on mac BigSur again.
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7d46ea4c9662c61eeaa8fcfcc44c27bda9e27578.tar.gz") {}
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python39
    python39Packages.pylint
    mypy
    which
    pipenv
  ];
}
