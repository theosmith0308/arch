#!/bin/bash

grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/efi --bootloader-id=Arch

systemctl enable --now grub-btrfs.path

grub-mkconfig -o /efi/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
#systemctl enable reflector.service
#systemctl enable fstrim.timer
#systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup.timer

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

