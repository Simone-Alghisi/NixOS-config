{ config, pkgs, lib, ...}: 

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    cryptsetup
    borgbackup
    rclone
  ];
  environment.pathsToLink = [ "/share/zsh" ];
}
