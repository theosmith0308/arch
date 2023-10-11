#!/usr/bin/bash

sudo pacman -S pipewire-{jack,alsa,pulse} gst-plugin-pipewire libpulse wireplumber
systemctl --user enable --now pipewire pipewire-pulse wireplumber

echo "Done"