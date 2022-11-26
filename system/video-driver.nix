{ config, pkgs, ... }:

{
  # default configuration for video drivers
  services.xserver = {
    videoDrivers = [ "modesetting" ];
  };
}
