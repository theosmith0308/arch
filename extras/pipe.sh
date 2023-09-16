#!/usr/bin/bash

sudo pacman -S pipewire-{jack,alsa,pulse}
systemctl --user enable --now pipewire pipewire-pulse pipewire-media-session

echo "Done"
