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
      url = "mach-nix/3.5.0";
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
          requirements = builtins.readFile ./requirements.txt;
          packagesExtra = [

          ];
        };
    in
    {
      devShell = pkgs.mkShell {
        shellHook = ''
        '';
        name = "";
        buildInputs = [
          python-build
        ];
      };
    });
}
