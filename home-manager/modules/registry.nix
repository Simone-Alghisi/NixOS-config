{ config, pkgs, ...}:

{
  nix.registry = {
    my-templates = {
      from = {
        id = "my-templates";
        type = "indirect";
      };
      to = {
        dir = "flake-templates";
        owner = "Simone-Alghisi";
        repo = "NixOS-config";
        type = "github";
        ref = "master";
      };
    };
  };
}