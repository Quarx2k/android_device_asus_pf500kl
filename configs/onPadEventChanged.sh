#!/system/bin/sh
# Copyright (c) 2012, Code Aurora Forum. All rights reserved.
#

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH
file_name=/data/pad_status
if [ ! -f $file_name ];then
	touch $file_name
	chmod 755 $file_name
	chown system.system $file_name 
fi

pad_mode=`getprop sys.config.resolution`
echo $pad_mode > $file_name 
exit 0

