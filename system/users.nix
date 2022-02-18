{ config, pkgs, ... }:
{
	# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alghisius = {
    isNormalUser = true;
    home = "/home/alghisius";
    description = "Simone Alghisi";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh; # default shell only for this user.
  };
}