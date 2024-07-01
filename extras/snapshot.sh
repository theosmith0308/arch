#!/bin/bash
read -p "Enter a comment for the snapshot: " c
snapper -c root create -d "$c"
snapper ls
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo "DONE. Snapshot $c created!"
