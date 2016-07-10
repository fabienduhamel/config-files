#!/bin/bash

cd /home/fab

export DISPLAY=:0

MOUNT_POINT="/media/truecrypt"
DISK_ID="usb-WDC_WD75_00BPVT-60HXZT3_0123456789ABCDEF-0:0"
DISK_PATH="/dev/disk/by-id/$DISK_ID"

# Not our USB plugged
if [ ! -e $DISK_PATH ]; then
    exit
fi

# Already mounted
if [ -d $MOUNT_POINT ]; then
    exit
fi

terminator -e "truecrypt --mount $DISK_PATH $MOUNT_POINT \
    && cd $MOUNT_POINT \
    && ./do_backups.sh ; \
    cd ~ && truecrypt -d && echo 'Disk has been unmounted correctly.' || echo 'Disk has not been unmounted.' ; \
    exec $SHELL"
