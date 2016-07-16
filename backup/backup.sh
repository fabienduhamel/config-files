#!/bin/bash

cd /home/fab

export DISPLAY=:0

MOUNT_POINT="/media/truecrypt"
DISK_ID="ata-WDC_WD7500BPVT-60HXZT3_WD-WXB1C22S4013"
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
