{ config, pkgs, lib, ... }:

{
  # List packages installed in your user profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; [
    borgbackup
    btop
    discord
    docker
    fd
    ffmpeg
    firefox-esr
    gimp
    globalprotect-openconnect
    google-chrome
    home-manager
    libreoffice
    lollypop
    ncdu
    nodejs-16_x
    parallel
    psmisc
    rclone
    slack
    sshfs
    thunderbird
    tree
    unstable.obsidian
    unstable.tdesktop
    wget
    whatsapp-for-linux
    xdragon
    xournalpp
    zoom-us
  ];

  # permitted unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "zoom"
    "discord"
    "vscode-extension-MS-python-vscode-pylance"
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "google-chrome"
    "slack"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
