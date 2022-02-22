{ config, pkgs, lib, ...}: 

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    cryptsetup
    tdesktop
    vscode
    firefox
    thunderbird
    obsidian
    borgbackup
  ];
  
  # permitted insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
  ];

  # permitted unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "obsidian"
  ];
}
