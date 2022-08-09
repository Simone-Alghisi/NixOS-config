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

    mach-nix= {
      url = "mach-nix/3.5.0";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pypi-deps-db.follows = "pypi-deps-db";
    };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }@inp:
      flake-utils.lib.eachDefaultSystem (system: let
        pkgs = nixpkgs.legacyPackages.${system};
        mach = mach-nix.lib."${system}";
        req = builtins.filter (builtins.isString) (builtins.split "\n" (builtins.readFile ./requirements.txt));

        isComment = x: ! builtins.isNull (builtins.match "^#.*" x);
        hasVersion = x: ! builtins.isNull (builtins.match ".*=.*" x);
        deleteHttps = x: if (builtins.isNull (builtins.match "https.*" x)) then x else "";
        deleteGit = x: if (builtins.isNull (builtins.match "git.*" x)) then x else "";
        cleanNonMachNixCompatible = x: (deleteGit (deleteHttps x));
        removeVersion = x: if ((isComment x) || (! hasVersion x)) then [ (cleanNonMachNixCompatible x) ] else (builtins.match "([^=><~]*).*" x);
        cleanedReq = builtins.concatStringsSep "\n" (builtins.concatMap removeVersion req);

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
        buildInputs = [
          python-build
        ];
      };
    });
}
