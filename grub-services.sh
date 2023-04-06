#!/bin/bash

pacman -S grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
#systemctl enable reflector.service
#systemctl enable fstrim.timer
#systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable pipewire.service
systemctl enable pipewire-pulse.service

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

