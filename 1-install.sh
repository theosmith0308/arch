#!/bin/bash
clear
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "(2023)"
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
read -p "Enter the name of the HOME partition (eg. sda3): " sda3

# ------------------------------------------------------
# Sync time
# ------------------------------------------------------
timedatectl set-ntp true

# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
# mkfs.fat -F 32 -n EFI /dev/$sda1
mkfs.btrfs -L ROOT -f /dev/$sda2
mkfs.ext4 -L HOME /dev/$sda3

# ------------------------------------------------------
# Mount points for btrfs
# ------------------------------------------------------
mount /dev/$sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
# btrfs su cr /mnt/@snapshots
umount /mnt

mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/$sda2 /mnt
mkdir -p /mnt/{boot,home,var/cache,var/log}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@cache /dev/$sda2 /mnt/var/cache
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@log /dev/$sda2 /mnt/var/log
# mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/$sda2 /mnt/.snapshots
mount /dev/$sda3 /mnt/home
mount /dev/$sda1 /mnt/boot
# mkdir /mnt/windows
# mount -o defaults,noatime,commit=120 /dev/$sda3 /mnt/home

# ------------------------------------------------------
# Setting up mirrors for optimal download
# ------------------------------------------------------
timedatectl set-ntp true
pacman -S --noconfirm archlinux-keyring #update keyrings to latest to prevent packages failing to install
pacman -S --noconfirm --needed pacman-contrib terminus-font
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sed -i 's/ParallelDownloads = 5/ParallelDownloads = 3/' /etc/pacman.conf
# pacman -S --noconfirm --needed reflector rsync
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# ------------------------------------------------------
# Run reflector to update mirrorlist
# ------------------------------------------------------
# reflector -c ZA --sort rate -p https -p http -l 10 --save /etc/pacman.d/mirrorlist
pacman -Sy

# ------------------------------------------------------
# Install base packages
# ------------------------------------------------------
pacstrap -K /mnt base linux linux-firmware btrfs-progs intel-ucode openssh git vim pacman-contrib reflector rsync

# ------------------------------------------------------
# Install boot packages
# ------------------------------------------------------
# pacstrap -K /mnt grub os-prober efibootmgr dosfstools ntfs-3g
pacstrap -K /mnt os-prober efibootmgr dosfstools ntfs-3g

# ------------------------------------------------------
# Install network components
# ------------------------------------------------------
pacstrap -K /mnt networkmanager network-manager-applet broadcom-wl

# ------------------------------------------------------
# Generate fstab
# ------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

# ------------------------------------------------------
# Install configuration scripts
# ------------------------------------------------------
mkdir /mnt/archinstall
cp -r ./ /mnt/archinstall/
cp pkgs-x86_64.txt /mnt/

# ------------------------------------------------------
# Chroot to installed sytem
# ------------------------------------------------------
arch-chroot /mnt 
# ./archinstall/2-config.sh
