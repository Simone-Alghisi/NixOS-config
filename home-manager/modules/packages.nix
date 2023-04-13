{ config, pkgs, lib, ... }:

{
  # List packages installed in your user profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; [
    authy
    bitwarden
    borgbackup
    btop
    discord
    docker
    fd
    ffmpeg
    firefox
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
    steam-run
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
    "authy"
    "discord"
    "google-chrome"
    "slack"
    "steam-original"
    "steam-run"
    "vscode"
    "vscode-extension-MS-python-vscode-pylance"
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "zoom"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
