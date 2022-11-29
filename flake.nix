{
  description = "NixOS configuration using flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@attrs: {
    nixosConfigurations.alghisius-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./system/boot.nix
        ./system/borgbackup.nix
        ./system/fonts.nix
        ./system/general.nix
        ./system/gnome.nix
        ./system/hardware-configuration.nix
        ./system/network.nix
        ./system/packages.nix
        ./system/services.nix
        ./system/users.nix
        ./system/video-driver.nix
        ./system/virtualisation.nix
        ./system/X11.nix
        ./system/zsh.nix
        nixos-hardware.nixosModules.dell-xps-13-9310
      ];
    };
  };
}
