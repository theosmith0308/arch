#!/bin/bash

ln -sf /usr/share/zoneinfo/Africa/Windhoek /etc/localtime
hwclock --systohc
pacman -S --noconfirm pacman-contrib
pacman -S --noconfirm reflector
reflector -c ZA -c US -c GB --latest 15 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:ts | chpasswd
useradd -m theo
echo theo:ts | chpasswd
usermod -aG wheel theo

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
