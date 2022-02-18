{ config, pkgs, ... }:

{
	# boot loader
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    version = 2;
    efiSupport = true;
    useOSProber = true;
    efiInstallAsRemovable = true;
    configurationLimit = 5;
  };
  
  # virtual machine stuff
  fileSystems."/virtualboxshare" = {
    fsType = "vboxsf";
    device = "Nixos_config";
    options = ["rw" "nofail"];
  };
}