#!/bin/bash
set -e

mount /dev/sdb2 /boot/
mount -t tmpfs tmpfs /boot/EFI
TDIR=$(mktemp -d)
clr-boot-manager update
cp /boot/EFI/com.solus-project/* $TDIR
umount /boot/EFI
rm -f /boot/EFI/com.solus-project/*
CURRENT=$(uname -r | grep  -oP '.*(?=\.current)')
NEWFILES=$(ls -d $TDIR/* | grep -v $CURRENT)
cp $NEWFILES /boot/EFI/com.solus-project/
rm -rf $TDIR
umount /boot
systemctl enable update_kernel.service
echo "=======DONE======="
