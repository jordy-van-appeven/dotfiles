#!/usr/bin/env bash 
"
Spawn four virtual monitors on primary display device (default). 
Optional, specify alternative output device.
"

if [ $# -eq 1 ]
then 
    echo "Please specify output device; e.g. \"`basename "$0"` $MONITOR\""
    MONITOR=$1
else
    MONITOR=$(xrandr --listactivemonitors | grep -P -m1 '0:' | grep -P -o '[^ ]*$')
fi

read WIDTH HEIGHT WIDTH_MM HEIGHT_MM <<< $(xdpyinfo |  
    grep dimensions |  
    awk '{gsub(/\(/,"");
        split($2,size,"x");
        split($4,size_mm,"x");
        print size[1] " " size[2] " " size_mm[1] " " size_mm[2]}')

        xrandr --output $MONITOR --scale 2.0x2.0 \
            --setmonitor $MONITOR-1 $WIDTH/$WIDTH_MM\x$HEIGHT/$HEIGHT_MM+0+0 $MONITOR \
            --setmonitor $MONITOR-2 $WIDTH/$WIDTH_MM\x$HEIGHT/$HEIGHT_MM+$WIDTH+0 none \
            --setmonitor $MONITOR-3 $WIDTH/$WIDTH_MM\x$HEIGHT/$HEIGHT_MM+0+$HEIGHT none \
            --setmonitor $MONITOR-4 $WIDTH/$WIDTH_MM\x$HEIGHT/$HEIGHT_MM+$WIDTH+$HEIGHT none \
                > /dev/null 2>&1 

if [ $? -eq 1 ]
then
    xrandr --delmonitor $MONITOR-1 --delmonitor $MONITOR-2 --delmonitor $MONITOR-3 --delmonitor $MONITOR-4 --output $MONITOR --scale 1.0x1.0
fi

qtile shell -c "reload_config()"
