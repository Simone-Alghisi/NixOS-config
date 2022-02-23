{
  description = "NixOS configuration using flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@attrs: {
    nixosConfigurations.alghisius-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./system/hardware-configuration.nix
        nixos-hardware.nixosModules.dell-xps-13-9310
        ./system/boot.nix
        ./system/general.nix
        ./system/video-driver.nix
        ./system/services.nix
        ./system/network.nix
        ./system/users.nix
        ./system/gnome.nix
        ./system/zsh.nix
        ./system/packages.nix
        ./system/X11.nix
        ./system/borgbackup.nix
      ];
    };
  };
}