{ config, pkgs, ... }:

{
  # GNOME-Desktop
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
}
