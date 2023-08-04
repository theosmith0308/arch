#!/bin/bash

#NOTE Change "sda???" to your current ROOT directory Run blkid to get PARTUUID of partitions
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sda???) rootflags=subvol=@ rw" >> /boot/loader/entries/arch.conf

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
