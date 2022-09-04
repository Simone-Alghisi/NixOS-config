{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = pkgs.ruby;

        # Uncomment this only after running "direnv allow" and "gemify.sh"
        #gems = pkgs.bundlerEnv {
        #  name = "gemset";
        #  inherit ruby;
        #  gemfile = ./Gemfile;
        #  lockfile = ./Gemfile.lock;
        #  gemset = ./gemset.nix;
        #};

      in {
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              #gems
              ruby
              bundler
              bundix
            ];
          };
      }
    );
}
