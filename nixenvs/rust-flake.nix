{
  description = "A sandbox rust project";

  # Declare inputs to fetch from
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      flake = true;
    };
    # Add your other dependencies here
  };

  # Declare your Nix environment
  outputs = { self, nixpkgs, /* your dependencies */ }: {
    # Get the current system type: "x86_64-linux", "aarch64-linux", etc.
    system = builtins.currentSystem;

    # Build a shell environment
    defaultPackage.${system} = with pkgs; mkShell {
      buildInputs = [
        # Add your dependencies here
      ];
    };
  };
}
