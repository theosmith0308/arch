#!/bin/bash

#Run this as superuser

umount /.snapshots
rm -r /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
btrfs subvol set-def 256 /
chmod 750 /.snapshots
systemctl enable --now grub-btrfsd.service

#Changing The timeline auto-snap
sed -i 's|ALLOW_USERS=""|ALLOW_USERS="theo"|' /etc/snapper/configs/root
sed -i 's|ALLOW_GROUPS=""|ALLOW_GROUPS="wheel"|' /etc/snapper/configs/root
sed -i 's|NUMBER_LIMIT="50"|NUMBER_LIMIT="12"|' /etc/snapper/configs/root
sed -i 's|NUMBER_LIMIT_IMPORTANT="50"|NUMBER_LIMIT_IMPORTANT="3"|' /etc/snapper/configs/root
sed -i 's|TIMELINE_CREATE="yes|TIMELINE_CREATE="no"|' /etc/snapper/configs/root

#activating the auto-cleanup
SCRUB=$(systemd-escape --template btrfs-scrub@.timer --path /dev/sda5)
systemctl enable ${SCRUB}
systemctl enable snapper-cleanup.timer
sed -i 's|OnUnitActiveSec=1d|OnUnitActiveSec=1h|' /etc/systemd/system/timers.target.wants/snapper-cleanup.timer
grub-mkconfig -o /boot/grub/grub.cfg
