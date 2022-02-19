{ config, pkgs, ...}:

{
	services.power-profiles-daemon.enable = false;
	services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      TLP_DEFAULT_MODE = "AC";
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      CPU_HWP_ON_AC = "performance";
      CPU_HWP_ON_BAT = "performance";
      DEVICES_TO_ENABLE_ON_STARTUP = "bluetooth wifi";
    };
  };
  services.thermald = {
    enable = true;
    # dell
    # configFile = TODO: add path to generated config;
  };
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
	services.upower = {
    enable = true;
    usePercentageForPolicy = false;
  };
}