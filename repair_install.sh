#!/bin/sh
set -e
HOSTNAME="alghisius-nixos"
ROOT_DEV=$1
BOOT_DEV=$2

# encrypt root
cryptsetup open "$ROOT_DEV" nixenc

ROOT="/dev/mapper/nixenc"

# mount
mount "$ROOT" /mnt

mkdir -p /mnt/boot
mount "$BOOT_DEV" /mnt/boot

# setup nix flake
nix-env -iA nixos.nixUnstable
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# move repo and replace hardware-configuration
cp -r ~/NixOS-config/* /mnt/etc/nixos

# install everything
nixos-install --flake /mnt/etc/nixos#"$HOSTNAME"