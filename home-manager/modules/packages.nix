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
    unstable.obsidian
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
    lollypop
    unstable.zotero
    ripgrep
    thefuck
  ];

  # permitted unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
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
