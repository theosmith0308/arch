#!/usr/bin/bash

sudo pacman -S --needed --overwrite pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber

# pulseaudio-alsa
# jack2
# pulseaudio
# pulseaudio-bluetooth

systemctl enable --user pipewire-pulse.service

