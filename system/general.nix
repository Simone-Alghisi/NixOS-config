{ config, pkgs, ... }:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  nix = {
    settings.auto-optimise-store = true;
    # Automatic gc
    gc = {
      automatic = true;
      dates = "daily";
      persistent = true;
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    # enable flakes
    extraOptions = ''
      experimental-features = nix-command flakes
      # for nix-direnv
      keep-outputs = true
      keep-derivations = true
    '';
   };

  # For dualboot set Windows on UTC
  #time.timeZone = "Europe/Rome";
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "it";
  };
}

