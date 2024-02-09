{
  description = "Rust env";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, flake-utils }: 
    let
     forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ] (system: function nixpkgs.legacyPackages.${system});
    in {
      devShell = forAllSystems (pkgs: 
          with pkgs; mkShell {
            buildInputs = [
              python311
              python311Packages.jedi
              python311Packages.mypy
              pipenv
            ]; 

            shellHook = ''
              export ENV_NAME="$ENV_NAME python311"
              exec $SHELL
            '';
          });
    };
}

