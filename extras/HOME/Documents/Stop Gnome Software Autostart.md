List status of a service
systemctl status --user gnome-software.service

Stop gnome-software
systemctl --user mask gnome-software.service

Restart gnome-software
systemctl --user unmask gnome-software.service
