{ config, pkgs, ...}:

{
  fonts.fonts = with pkgs; [
    powerline-fonts
  ];
}
