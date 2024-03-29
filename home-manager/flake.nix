{
  description = "Home Manager configuration of Simone Alghisi";

  inputs = {
    # Specify the source of Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Specify the source of Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      username = "alghisius";
      pkgs = import nixpkgs {
        system = system;
        config = {
          permittedInsecurePackages = [
            "zotero-6.0.26"
          ];
        };
      };
      unstable-overlay = final: prev: {
        unstable = import nixpkgs-unstable {
          system = system;
          config.allowUnfree = true;
          config = {
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
        };
      };
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            nixpkgs.overlays = [
              unstable-overlay
            ];
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
              # Update the state version as needed.
              stateVersion = "21.11";
            };
          }
        ];
        # See the changelog here:
        # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      # https://nixos.org/manual/nix/stable/release-notes/rl-2.7.html
      packages.${system}.default = self.homeConfigurations.${username}.activationPackage;
    };
}
