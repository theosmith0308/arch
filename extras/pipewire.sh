#!/bin/bash
# -----------------------------------------------------
# Install pipewire
# -----------------------------------------------------
sudo pacman -S --needed gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly gstreamer pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber

systemctl enable --user pipewire-pulse.service
