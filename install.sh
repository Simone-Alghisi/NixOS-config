#!/bin/sh
set -e
HOSTNAME="alghisius-nixos"
BOOT_DEV=$1
SWAP_DEV=$2
ROOT_DEV=$3

# set root password
passwd root

# change user
sudo -i

# encrypt root
cryptsetup --type luks2 luksFormat "$BOOT_DEV"
cryptsetup open "$BOOT_DEV" nixenc
cryptsetup config "$BOOT_DEV" --label nixenc

ROOT="/dev/mapper/nixenc"

# format filesystem
mkfs.ext4 -L root "$ROOT"
mkswap -L swap "$SWAP_DEV"
mkfs.fat -F 32 -n boot "$BOOT_DEV"

# mount
mount "$ROOT" /mnt

mkdir -p /mnt/boot
mount "$BOOT_DEV" /mnt/boot

swapon "$SWAP_DEV"

# generate hardware configs
nixos-generate-config --root /mnt
# check result
nano /mnt/etc/nixos/hardware-configuration.nix

# setup nix flake
nix-env -iA nixos.nixUnstable
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# move repo and replace hardware-configuration
cp -r ~/NixOS-config/* /mnt/etc/nixos
rm /mnt/etc/nixos/configuration.nix
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/system

# install everything
nixos-install --flake /mnt/etc/nixos#"$HOSTNAME"



