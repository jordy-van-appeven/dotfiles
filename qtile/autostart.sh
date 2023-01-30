#!/usr/bin/env bash 

nitrogen --restore &
#picom --experimental-backends -b &
# switch to `xrender` backend in case `glx` (default) fails
picom --backend xrender -b &
# Disable touchpad while typing
syndaemon -i 3 -d -t -k &
# Keyboard layout and remapping
kmonad ~/.config/kmonad/laptop.kbd &
# Applications
seadrive-gui &

