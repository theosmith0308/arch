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
read -p "Enter the name of the windows partition (keep it empty if not required): " sda3

# ------------------------------------------------------
# Sync time
# ------------------------------------------------------
timedatectl set-ntp true

# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
mkfs.fat -F 32 /dev/$sda1
mkfs.btrfs -f /dev/$sda2
mkfs.ext4 /dev/$sda3

# ------------------------------------------------------
# Mount points for btrfs
# ------------------------------------------------------
mount /dev/$sda2 /mnt

# Creating subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@/.snapshots
mkdir /mnt/@/.snapshots/1
btrfs subvolume create /mnt/@/.snapshots/1/snapshot
mkdir /mnt/@/boot
btrfs subvolume create /mnt/@/boot/grub
btrfs subvolume create /mnt/@/root
btrfs subvolume create /mnt/@/srv
btrfs subvolume create /mnt/@/tmp
btrfs subvolume create /mnt/@/home
	
mkdir /mnt/@/var
btrfs subvolume create /mnt/@/var/cache
btrfs subvolume create /mnt/@/var/log
btrfs subvolume create /mnt/@/var/spool
btrfs subvolume create /mnt/@/var/tmp
NOW=$(date +"%Y-%m-%d %H:%M:%S")
sed -i "s|2022-01-01 00:00:00|${NOW}|" /arch/info.xml
cp /arch/info.xml /mnt/@/.snapshots/1/info.xml
#setting snapshot 1 as the default subvolume
btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

btrfs quota enable /mnt

#disabling COW for some Var directory
chattr +C /mnt/@/var/cache
chattr +C /mnt/@/var/log
chattr +C /mnt/@/var/spool
chattr +C /mnt/@/var/tmp

# unmount root to remount with subvolume
    umount /mnt

# mount @ subvolume
    mount /dev/$sda2 -o compress=zstd /mnt

# make directories home, .snapshots, var, tmp

	mkdir /mnt/.snapshots
	mkdir -p /mnt/boot/grub
	mkdir /mnt/root
	mkdir /mnt/tmp
	mkdir -p /mnt/var/cache
	mkdir /mnt/var/log
	mkdir /mnt/var/spool
	mkdir /mnt/var/tmp
	mkdir /mnt/home
	mkdir /mnt/boot/efi

# mount subvolumes and partition

    mount /dev/$sda2 -o noatime,compress=zstd,ssd,commit=120,subvol=@/.snapshots /mnt/.snapshots
    mount /dev/$sda2 -o noatime,compress=zstd,ssd,commit=120,subvol=@/boot/grub /mnt/boot/grub
    mount /dev/$sda2 -o noatime,compress=zstd,ssd,commit=120,subvol=@/root /mnt/root
    mount /dev/$sda2 -o noatime,compress=zstd,ssd,commit=120,subvol=@/tmp /mnt/tmp
    mount /dev/$sda2 -o noatime,ssd,commit=120,subvol=@/var/cache /mnt/var/cache
    mount /dev/$sda2 -o noatime,ssd,commit=120,subvol=@/var/log,nodatacow /mnt/var/log
    mount /dev/$sda2 -o noatime,ssd,commit=120,subvol=@/var/spool,nodatacow /mnt/var/spool
    mount /dev/$sda2 -o noatime,ssd,commit=120,subvol=@/var/tmp,nodatacow /mnt/var/tmp
    mount /dev/$sda1 /mnt/boot/efi
    mount /dev/$sda3 /mnt/home


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
reflector -c ZA --sort rate -p https -p http -l 10 --save /etc/pacman.d/mirrorlist
pacman -Sy

# ------------------------------------------------------
# Install base packages
# ------------------------------------------------------
pacstrap -K /mnt base btrfs-progs git intel-ucode linux linux-firmware openssh pacman-contrib reflector rsync vim

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
# arch-chroot /mnt ./archinstall/2-configuration.sh

