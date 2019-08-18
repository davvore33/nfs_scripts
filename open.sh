#!/bin/bash
# Mouts and opening a secure partition

# Customize those variables
nas_mountp="/mnt/nas"
dm_name="dm_nas"
keyfile_path="./keyfile"
secpartition_path="$nas_mountp/sec"

# Check if $nas_mountp is mounted or automount if in fstab
if [[ -z $(mount | grep $nas_mountp) ]]; then
    if [[ -n $(cat /etc/fstab | grep $nas_mountp) ]]; then
        mount $nas_mountp
    else
        echo $nas_mountp is not your fstab
        exit 1
    fi
fi

sudo cryptsetup open $secpartition_path $dm_name --key-file $keyfile_path
udisksctl mount -b /dev/mapper/$dm_name
