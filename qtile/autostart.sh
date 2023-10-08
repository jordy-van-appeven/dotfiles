#!/usr/bin/env bash 

nitrogen --restore &
picom --experimental-backends -b &
# Disable touchpad while typing
syndaemon -i 0.5 -t -k &
# Keyboard layout and remapping
kmonad ~/.config/kmonad/laptop.kbd &

