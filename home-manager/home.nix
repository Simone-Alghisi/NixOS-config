{ pkgs, inputs, system, ...}:

{
    imports = [
        ./modules/packages.nix
        ./modules/git.nix
    ];
}