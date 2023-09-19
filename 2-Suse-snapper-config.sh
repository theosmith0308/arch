#!/bin/bash

#   ____             __ _                       _   _             
#  / ___|___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __  
# | |   / _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \ 
# | |__| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
#  \____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
#                         |___/                                   
# (2023)
# ------------------------------------------------------
clear
keyboardlayout="us"
zoneinfo="Africa/Windhoek"
hostname="arch"
username="theo"

# ------------------------------------------------------
# Set System Time
# ------------------------------------------------------
ln -sf /usr/share/zoneinfo/$zoneinfo /etc/localtime
hwclock --systohc --utc

# ------------------------------------------------------
# Setting up reflector and mirrors for optimal download
# ------------------------------------------------------
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
# sed -i 's/ParallelDownloads = 5/ParallelDownloads = 3/' /etc/pacman.conf
# pacman -S --noconfirm --needed reflector rsync
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
# echo "Start reflector..."
# reflector -c ZA --sort rate -p https -p http -l 10 --save /etc/pacman.d/mirrorlist

# ------------------------------------------------------
# Synchronize mirrors
# ------------------------------------------------------
# pacman -Syy

# ------------------------------------------------------
# Install Packages
# ------------------------------------------------------
pacman -S --noconfirm --needed - < pkgs-x86_64.txt

# ------------------------------------------------------
# set lang utf8 US
# ------------------------------------------------------
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# ------------------------------------------------------
# Set Keyboard
# ------------------------------------------------------
# echo "FONT=ter-v18n" >> /etc/vconsole.conf
echo "KEYMAP=$keyboardlayout" >> /etc/vconsole.conf

# ------------------------------------------------------
# Set hostname and localhost
# ------------------------------------------------------
echo "$hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts
clear

# ------------------------------------------------------
# Set Root Password
# ------------------------------------------------------
echo "Set root password"
passwd root

# ------------------------------------------------------
# Add User
# ------------------------------------------------------
echo "Add user $username"
useradd -m -G wheel $username
passwd $username

# ------------------------------------------------------
# Enable Services
# ------------------------------------------------------
systemctl enable NetworkManager
# systemctl enable bluetooth
# systemctl enable cups.service
systemctl enable sshd
# systemctl enable avahi-daemon
# systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
# systemctl enable acpid

# ------------------------------------------------------
# Configure Snapper
# ------------------------------------------------------
umount /.snapshots
rm -r /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod 750 /.snapshots
systemctl enable --now grub-btrfsd.service

#Changing The timeline auto-snap
sed -i 's|ALLOW_USERS=""|ALLOW_USERS="theo"|' /etc/snapper/configs/root
sed -i 's|ALLOW_GROUPS=""|ALLOW_GROUPS="wheel"|' /etc/snapper/configs/root
sed -i 's|NUMBER_LIMIT="50"|NUMBER_LIMIT="5-15"|' /etc/snapper/configs/root
sed -i 's|NUMBER_LIMIT_IMPORTANT="50"|NUMBER_LIMIT_IMPORTANT="5-10"|' /etc/snapper/configs/root
sed -i 's|TIMELINE_LIMIT_HOURLY="10"|TIMELINE_LIMIT_HOURLY="5"|' /etc/snapper/configs/root
sed -i 's|TIMELINE_LIMIT_DAILY="10"|TIMELINE_LIMIT_DAILY="7"|' /etc/snapper/configs/root
sed -i 's|TIMELINE_LIMIT_WEEKLY="0"|TIMELINE_LIMIT_WEEKLY="0"|' /etc/snapper/configs/root
sed -i 's|TIMELINE_LIMIT_MONTHLY="10"|TIMELINE_LIMIT_MONTHLY="0"|' /etc/snapper/configs/root
sed -i 's|TIMELINE_LIMIT_YEARLY="10"|TIMELINE_LIMIT_YEARLY="0"|' /etc/snapper/configs/root

#activating the auto-cleanup
SCRUB=$(systemd-escape --template btrfs-scrub@.timer --path /dev/sda5)
systemctl enable ${SCRUB}
systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup.timer
sed -i 's|OnUnitActiveSec=1d|OnUnitActiveSec=1h|' /etc/systemd/system/timers.target.wants/snapper-cleanup.timer
grub-mkconfig -o /boot/grub/grub.cfg

# ------------------------------------------------------
# Grub installation
# ------------------------------------------------------
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg

# ------------------------------------------------------
# Add btrfs and setfont to mkinitcpio
# ------------------------------------------------------
# Before: BINARIES=() MODULES=()
# After:  BINARIES=(/usr/bin/btrfs) MODULES=(btrfs)
sed -i 's/MODULES=()/MODULES=(btrfs)/g' /etc/mkinitcpio.conf
sed -i 's/BINARIES=()/BINARIES=(/usr/bin/btrfs)/g' /etc/mkinitcpio.conf
mkinitcpio -p linux

# ------------------------------------------------------
# Add user to wheel
# ------------------------------------------------------
clear
# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

# ------------------------------------------------------
# Install Desktop
# ------------------------------------------------------
pacman -S --noconfirm --needed - < xfce4pkglist.txt

# Enable Display Manager
systemctl enable lightdm

# ------------------------------------------------------
# Copy installation scripts to home directory 
# ------------------------------------------------------
mkdir -p /home/$username/extras
sudo cp -r /archinstall/extras /home/$username/
sudo chown -R :wheel /home/$username/extras/
sudo chmod +x /home/$username/extras/*

clear
echo "     _                   "
echo "  __| | ___  _ __   ___  "
echo " / _' |/ _ \| '_ \ / _ \ "
echo "| (_| | (_) | | | |  __/ "
echo " \__,_|\___/|_| |_|\___| "
echo "                         "
echo ""
echo "Please find the following additional installation scripts in your home directory in extras:"
echo "- yay AUR helper: 3-yay.sh"
echo "- zram swap: 4-zram.sh"
echo "- timeshift snapshot tool: 5-timeshift.sh"
echo "- preload application cache: 6-preload.sh"
echo ""
echo "Please exit & shutdown (shutdown -h now), remove the installation media and start again."
echo "Important: Activate WIFI after restart with nmtui."
