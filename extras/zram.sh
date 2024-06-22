#!/bin/bash
# -----------------------------------------------------
# Install zram
# -----------------------------------------------------
yay --noconfirm -S zram-generator

# -----------------------------------------------------
# Open zram-generator.conf
# -----------------------------------------------------
if [ -f "/etc/systemd/zram-generator.conf" ]; then
    echo "/etc/systemd/zram-generator.conf already exists!"
else
	sudo touch /etc/systemd/zram-generator.conf
	sudo bash -c 'echo "[zram0]" >> /etc/systemd/zram-generator.conf'
	sudo bash -c 'echo "zram-size = ram / 2" >> /etc/systemd/zram-generator.conf'
 	sudo bash -c 'echo "compression-algorithm = zstd" >> /etc/systemd/zram-generator.conf'
    sudo systemctl daemon-reload
    sudo systemctl start /dev/zram0
fi

echo "DONE! Reboot now and check with free -h the ZRAM installation."
