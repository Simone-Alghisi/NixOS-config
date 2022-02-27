{ pkgs, inputs, system, ...}:

{
    imports = [
        ./modules/packages.nix
        ./modules/services.nix
    ];
}