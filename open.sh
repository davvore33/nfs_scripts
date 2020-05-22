#!/bin/bash
# Mouts and opening a secure partition

# Customize those variables
local=$PWD
nas_mountp="/mnt/nas"
dm_name="dm_nas"
cryptkeyfile_path="$local/keyfile.gpg"
keyfile_path="$local/keyfile"
secpartition_path="$nas_mountp/sec"
SUDOCMD="sudo -i"

#set -e

# Check if $nas_mountp is mounted or automount if in fstab
if [[ -z $(mount | grep $nas_mountp) ]]; then
	if [[ -n $(cat /etc/fstab | grep $nas_mountp) ]]; then
		$SUDOCMD "mount $nas_mountp"
	else
		notify-send "$nas_mountp is not your fstab"
		exit -1
	fi
fi

if [[ ! -f $keyfile_path ]]; then
    if [[ ! -f $cryptkeyfile_path ]]; then
        notify-send "I can't find $cryptkeyfile_path"
        exit -1
    else
        gpg -o $keyfile_path -d $cryptkeyfile_path 
    fi
fi

$SUDOCMD cryptsetup open $secpartition_path $dm_name --key-file $keyfile_path
udisksctl mount -b /dev/mapper/$dm_name
rm $keyfile_path
