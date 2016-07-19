#!/bin/bash

cd /home/fab

export DISPLAY=:0

MOUNT_POINT="/media/truecrypt"
DISK_ID="ata-WDC_WD7500BPVT-60HXZT3_WD-WXB1C22S4013"
DISK_PATH="/dev/disk/by-id/$DISK_ID"

# Not our USB plugged
if [[ "$DISK_ID" != "$1" ]]; then
    exit
fi

# Already mounted
if [ -d $MOUNT_POINT ]; then
    exit
fi

terminator -e "truecrypt --display-password --mount $DISK_PATH $MOUNT_POINT \
    && notify-send 'Backup' 'Le disque de backup a été monté.' \
    && cd $MOUNT_POINT \
    && echo 'Preview files that will be deleted:' && ./do_backups.sh | grep deleting | grep -v Secure ; \
    exec $SHELL"

cd ~ && truecrypt -d \
    && notify-send "Backup" "Le disque externe a été démonté." \
    || notify-send "Backup" "Le disque externe n'a pas pu être démonté correctement."
