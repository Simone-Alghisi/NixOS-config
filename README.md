<!-- omit in toc -->
# NixOS-config
repo containing my nixos config

<!-- omit in toc -->
## TOC
- [Generating Live USB](#generating-live-usb)
- [Pre-installation/repair](#pre-installationrepair)
  - [Installation](#installation)
  - [Repair installation](#repair-installation)
- [Dualboot](#dualboot)

## Generating Live USB
Generally speaking it is better to first install windows and then perform all the various nix-related things. For such reasons, and due to the fact that on my machine it seems to be done in this way, it is recommended to use [Rufus](https://rufus.ie/en/) (from Windows) for performing the Live USB containing [nixos-minimal](https://nixos.org/download.html) ISO. 

> **Note**:
> 
> Remember to set the partition scheme to GPT and target system to UEFI

## Pre-installation/repair
1. type `sudo passwd` and type a password;
2. switch to root using `su` (use the same password defined in 1);
3. load the keybinds using `loadkeys it`;
4. network the installer as described on the [nixos-manual](https://nixos.org/manual/nixos/stable/index.html#sec-installation-booting-networking);
5. install git using `nix-env -i git`;
6. clone the current repository using `git clone https://github.com/Simone-Alghisi/NixOS-config.git`

    > **Note**:
    > 
    > If, for WHATEVER reason you are not able to get git and/or networking DO NOT PROCEED: you are just going to get stuck on the next steps. 

### Installation
1. generate the partitions with the correct size (using `fdisk` press `n`, insert the partition number, the start sector, and then the desired size - basically after `n` press enter two times and then decide the size), i.e.
    - boot (512MB to be sure);
    - root;
    
    > **Note**
    >
    > In this particular case you need to change the type of the boot partition to EFI (because my Windows EFI was not large enough). *By default, the type of the new partition is set to “Linux filesystem”, which should be fine for most cases. If you want to change the type, press `l` to get a list of partition types and then press `t` to change the type.*
2. run `install.sh <ROOT_DEV> <BOOT_DEV>`;
3. as the last step, nixos-install will ask you to set the password for the root user;
4. finally, set the password for your user, e.g. `sudo passwd alghisius`.

### Repair installation
Basically one day Windows commited suicide and, after several tries, my option was to use the ISO setup to repair the corrupted OS. Of course, Windows resurrected but Nix Boot disappeared instead (YAY!). Long story short, you can recover Nix quite easily with a live usb by simply mounting the correct partition and installing.

1. use `lsblk -f` and `fdisk` print (`p` after selecting the device) to understand which are the partitions to be mounted (should be quite straightforward for the EFI and LUKS);
2. make sure that such partitions are the one specified [here](./system/hardware-configuration.nix);
3. run `repair_install.sh <ROOT_DEV> <BOOT_DEV>`.

## Dualboot
In most cases, dualboot is quite easy given that it is possible to use OSProber and look for other OS to add to GRUB. However, sometimes things are not so easy: in particular, ["my" workaround](https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows) is to [add a manual entry to GRUB by specifying Windows EFI UUID](./system/boot.nix). 