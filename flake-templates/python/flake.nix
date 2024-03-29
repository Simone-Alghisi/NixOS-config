{
  description = "Desc";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    pypi-deps-db = {
      url = "github:DavHau/pypi-deps-db";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mach-nix.follows = "mach-nix";
    };

    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pypi-deps-db.follows = "pypi-deps-db";
    };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }@inp:
      flake-utils.lib.eachDefaultSystem (system: let
        pkgs = nixpkgs.legacyPackages.${system};
        mach = mach-nix.lib."${system}";

        python-build = mach.mkPython {
          python = "python39";
          requirements = builtins.concatStringsSep "\n" [
            (builtins.readFile ./requirements.txt)
            (builtins.readFile ./requirements.dev.txt)
          ];
          packagesExtra = [

          ];
        };
    in
    {
      devShell = pkgs.mkShell {
        shellHook = ''
        '';
        name = "";
        buildInputs = with pkgs; [
          python-build
        ];
      };
    });
}
