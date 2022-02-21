{ config, pkgs, ... }:

{
	# boot loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    version = 2;
    efiSupport = true;
    configurationLimit = 5;
    enableCryptodisk = true;
    extraEntries = ''
      menuentry "Windows" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        search --fs-uuid --set=root 6EDB-2C87
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
}
