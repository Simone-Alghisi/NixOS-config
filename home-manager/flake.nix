{
  description = "Home Manager configuration of Simone Alghisi";

  inputs = {
    # Specify the source of Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Specify the source of Home Manager
    home-manager = {
        url = "github:rycee/home-manager/release-21.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "alghisius";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = import ./home.nix;

        inherit system username;
        homeDirectory = "/home/${username}";
        # Update the state version as needed.
        # See the changelog here:
        # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
        stateVersion = "21.11";

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      defaultPackage.${system} = self.homeConfigurations.${username}.activationPackage;
    };
}
