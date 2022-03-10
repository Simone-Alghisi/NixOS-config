{ config, pkgs, lib, ...}: 

{
  # List packages installed in your user profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; [
    wget
    tdesktop
    firefox
    thunderbird
    obsidian
    borgbackup
    rclone
    zoom-us
    discord
    home-manager
    dragon-drop
    libreoffice
  ];
  
  # permitted insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
  ];

  # permitted unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "obsidian"
    "zoom"
    "discord"
    "vscode-extension-MS-python-vscode-pylance"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    nix-direnv.enableFlakes = true;
  };
}
