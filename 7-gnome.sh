#!/bin/bash
# GNOME DESKTOP
# by Theo Smith (2023)                            
# -----------------------------------------------------
# GNOME Install Script
# -----------------------------------------------------
# NAME: GNOME Installation
# DESC: Installation script for gnome desktop.
# WARNING: Run this script at your own risk.
# -----------------------------------------------------
# Confirm Start
# -----------------------------------------------------
while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------
# Install gnome desktop
# -----------------------------------------------------
sudo pacman -S --noconfirm --needed baobab dconf-editor eog evince file-roller gdm ghex gitg glade gnome-backgrounds gnome-calculator gnome-characters gnome-color-manager gnome-connections gnome-console gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-remote-desktop gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-text-editor gnome-tweaks gnome-user-docs gnome-user-share grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb nautilus rygel sushi xdg-desktop-portal-gnome xdg-user-dirs-gtk
# -----------------------------------------------------
# Enable gdm
# -----------------------------------------------------
sudo systemctl enable gdm

echo "Done rebooting into Gnome"
echo "Rebooting in 3 Seconds ..." && sleep 1
echo "Rebooting in 2 Seconds ..." && sleep 1
echo "Rebooting in 1 Second ..." && sleep 1
reboot now
