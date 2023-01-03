#!/bin/bash 
read WIDTH HEIGHT <<< $(xdpyinfo |  
    grep dimensions |  
    awk '{gsub("\(","");
        split($4,size,"x");
        print size[1] " " size[2]}')

xrandr --setmonitor eDP-1-1 960/$(($WIDTH/2))x1080/$HEIGHT+0+0 eDP-1  \
        --setmonitor eDP-1-2 960/$(($WIDTH/2))x1080/$HEIGHT+960+0 none > /dev/null 2>&1 

if [ $? -eq 1 ]
then
    xrandr --delmonitor eDP-1-1 --delmonitor eDP-1-2
fi

qtile shell -c "reload_config()"

