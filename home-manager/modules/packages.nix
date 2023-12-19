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
    nodejs
    parallel
    psmisc
    rclone
    slack
    sshfs
    steam-run
    spotify
    thunderbird
    tree
    unstable.obsidian
    tdesktop
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
    "spotify"
    "steam-original"
    "steam-run"
    "vscode"
    "vscode-extension-MS-python-vscode-pylance"
    "vscode-extension-ms-vscode-remote-remote-ssh"
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "zoom"
    "zotero"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
