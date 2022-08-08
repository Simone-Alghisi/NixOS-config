{
  description = "Home Manager configuration of Simone Alghisi";

  inputs = {
    # Specify the source of Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Specify the source of Home Manager
    home-manager = {
      url = "github:rycee/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      username = "alghisius";
      unstable-overlay = final: prev: {
        unstable = import nixpkgs-unstable {
          system = system;
          config.allowUnfree = true;
        };
      };
      overlays = [
        unstable-overlay
      ];
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays;
          imports = [
            ./home.nix
          ];
        };

        inherit system username;
        homeDirectory = "/home/${username}";
        # Update the state version as needed.
        # See the changelog here:
        # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
        stateVersion = "21.11";

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      # https://nixos.org/manual/nix/stable/release-notes/rl-2.7.html
      packages.${system}.default = self.homeConfigurations.${username}.activationPackage;
    };
}
