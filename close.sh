#!/bin/bash

udisksctl unmount -b /dev/mapper/dm_nas  
sudo cryptsetup close dm_nas
