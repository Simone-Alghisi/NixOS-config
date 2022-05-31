{ config, pkgs, lib, ...}: 

{
  # List packages installed in your user profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; [
    wget
    unstable.tdesktop
    whatsapp-for-linux
    firefox
    thunderbird
    obsidian
    borgbackup
    rclone
    zoom-us
    discord
    home-manager
    xdragon
    libreoffice
    ffmpeg
    xournalpp
    btop
    nodejs-16_x
    google-chrome
    fd
    black
    tree
    psmisc
    gimp
    shotcut
    ncdu
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
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "google-chrome"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
