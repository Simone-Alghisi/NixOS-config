{ config, pkgs, ...}: 

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
  ];
}
