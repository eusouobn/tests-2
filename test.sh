#!/usr/bin/env sh

lsblk -nd --output NAME | grep 'sd\|hd\|vd\|nvme\|mmcblk'
