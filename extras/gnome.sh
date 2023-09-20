#!/bin/bash
# -----------------------------------------------------
# Install gnome desktop
# -----------------------------------------------------
sudo pacman -S --noconfirm --needed baobab dconf-editor eog evince file-roller gdm ghex gitg glade gnome-backgrounds gnome-browser-connector gnome-calculator gnome-characters gnome-color-manager gnome-connections gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-text-editor gnome-tweaks gnome-user-docs gnome-user-share grilo-plugins gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb nautilus rygel sushi xdg-desktop-portal-gnome xdg-user-dirs-gtk
# -----------------------------------------------------
# Enable gdm
# -----------------------------------------------------
sudo systemctl enable gdm

echo "Done rebooting into Gnome"
echo "Rebooting in 3 Seconds ..." && sleep 1
echo "Rebooting in 2 Seconds ..." && sleep 1
echo "Rebooting in 1 Second ..." && sleep 1
sudo reboot now
