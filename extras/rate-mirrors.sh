#!/bin/bash
git clone https://aur.archlinux.org/rate-mirrors-bin.git
cd rate-mirrors-bin
makepkg -si

echo "DONE!"
