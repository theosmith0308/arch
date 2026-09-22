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
read -p "Enter the name of the BOOT partition (eg. sda2): " sda2
# read -p "Enter the name of the ROOT partition (eg. sda3): " sda3

# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
mkfs.fat -F 32 -n EFI /dev/$sda1
mkfs.btrfs -L ROOT -f /dev/$sda2
# mkfs.ext4 -L HOME /dev/$sda3

# ------------------------------------------------------
# Mount points for btrfs
# ------------------------------------------------------
mount /dev/$sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@spool
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@srv
umount /mnt

mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@ /dev/$sda2 /mnt
mkdir -p /mnt/{efi,home,var/cache,var/log,var/tmp,var/spool,opt,srv}
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@home /dev/$sda2 /mnt/home
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@cache /dev/$sda2 /mnt/var/cache
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@log /dev/$sda2 /mnt/var/log
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@tmp /dev/$sda2 /mnt/var/tmp
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@spool /dev/$sda2 /mnt/var/spool
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@opt /dev/$sda2 /mnt/opt
mount -o defaults,noatime,autodefrag,compress=zstd,commit=120,subvol=@srv /dev/$sda2 /mnt/srv

mount /dev/$sda1 /mnt/efi
# mount /dev/$sda3 /mnt/home
# mkdir /mnt/windows

# ------------------------------------------------------
# Setting up mirrors for optimal download
# ------------------------------------------------------
timedatectl set-ntp true
pacman -S --noconfirm archlinux-keyring #update keyrings to latest to prevent packages failing to install
pacman -S --noconfirm --needed pacman-contrib terminus-font
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sed -i 's/ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
pacman -S --noconfirm --needed reflector rsync

# ------------------------------------------------------
# Run reflector to update mirrorlist
# ------------------------------------------------------
reflector -c ZA -l 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

# ------------------------------------------------------
# Install base packages
# ------------------------------------------------------
pacstrap -K /mnt base base-devel linux linux-firmware btrfs-progs bash-completion grub intel-ucode git nvim plocate man-db man-pages pacman-contrib rsync

# ------------------------------------------------------
# Install boot packages
# ------------------------------------------------------
pacstrap -K /mnt grub os-prober efibootmgr efitools dosfstools ntfs-3g

# ------------------------------------------------------
# Install network components
# ------------------------------------------------------
pacstrap -K /mnt networkmanager network-manager-applet broadcom-wl-dkms

# ------------------------------------------------------
# Generate fstab
# ------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

# ------------------------------------------------------
# Install configuration scripts
# ------------------------------------------------------
mkdir /mnt/archinstall
cp 2-config.sh /mnt/archinstall/
cp packages-x86_64.txt /mnt
cp -r extras /mnt/archinstall/

# ------------------------------------------------------
# Chroot to installed sytem
# ------------------------------------------------------
arch-chroot /mnt ./archinstall/2-config.sh
