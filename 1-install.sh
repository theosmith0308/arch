#!/bin/bash
clear
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "by Stephan Raabe (2023)"
echo "-----------------------------------------------------"
echo ""
echo "Important: Please make sure that you have followed the "
echo "manual steps in the README to partition the harddisc!"
echo "Warning: Run this script at your own risk."
echo ""

# ------------------------------------------------------
# Enter partition names
# ------------------------------------------------------
lsblk
read -p "Enter the name of the EFI partition (eg. sda1): " sda1
read -p "Enter the name of the ROOT partition (eg. sda2): " sda2
# read -p "Enter the name of the VM partition (keep it empty if not required): " sda3

# ------------------------------------------------------
# Sync time
# ------------------------------------------------------
timedatectl set-ntp true

# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
mkfs.fat -F 32 /dev/$sda1;
mkfs.btrfs -f /dev/$sda2
# mkfs.btrfs -f /dev/$sda3

# ------------------------------------------------------
# Mount points for btrfs
# ------------------------------------------------------
mount /dev/$sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@log
btrfs su cr /mnt/@pkg
btrfs su cr /mnt/@images
umount /mnt

mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/$sda2 /mnt
mkdir -p /mnt/{boot/efi,home,var/log,var/cache/pacman/pkg,windows}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@home /dev/$sda2 /mnt/home
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@log /dev/$sda2 /mnt/var/log
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@pkg /dev/$sda2 /mnt/var/cache/pacman/pkg
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@images /dev/$sda2 /mnt/var/lib/libvirt/images
mount /dev/$sda3 /mnt/windows
mount /dev/$sda1 /mnt/boot/efi

# ------------------------------------------------------
# Install base packages
# ------------------------------------------------------
pacstrap -K /mnt base linux linux-firmware intel-ucode btrfs-progs git vim rsync

# ------------------------------------------------------
# Generate fstab
# ------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab
#cat /mnt/etc/fstab

# ------------------------------------------------------
# Install configuration scripts
# ------------------------------------------------------
mkdir /mnt/archinstall
cp 2-configuration.sh /mnt/archinstall/
cp 3-yay.sh /mnt/archinstall/
cp 4-zram.sh /mnt/archinstall/
cp 5-timeshift.sh /mnt/archinstall/
cp 6-preload.sh /mnt/archinstall/
cp snapshot.sh /mnt/archinstall/
cp basepkglist.txt /mnt/archinstall/
cp desktop.txt /mnt/archinstall/
cp gnome.txt /mnt/archinstall/
cp pipewire.txt /mnt/archinstall/

# ------------------------------------------------------
# Chroot to installed sytem
# ------------------------------------------------------
arch-chroot /mnt ./archinstall/2-configuration.sh

