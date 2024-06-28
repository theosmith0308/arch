Copy the scripts to their reletive locations
/etc/initcpio/hooks/
/etc/initcpio/install/

Edit /etc/mkinitcpio.conf and add the hook at the end of the hooks line
eg: HOOKS=(base systemd autodetect modconf kms keyboard sd-vconsole sd-encrypt block filesystems fsck disablesnapro)

Rebuild the image with
mkinitcpio -p linux (Replace linux with your currnet kernel eg: linux or linux-zen
