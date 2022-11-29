{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alghisius = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/alghisius";
    description = "Simone Alghisi";
    extraGroups = [
      "docker" # Enable docker
      "networkmanager" # Enable networkmanager.
      "wheel" # Enable sudo
    ];
    shell = pkgs.zsh; # default shell only for this user.
  };
}
