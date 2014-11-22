mount -o remount,rw /data/asusdata
usb_boot=`getprop sys.usb.config.boot`
build_type=`getprop ro.build.type`
if [ $usb_boot == "QCOM" ];then
	touch /data/asusdata/diag_enable
	chmod 644 /data/asusdata/diag_enable
	setprop persist.usb.diag 1
elif [ $usb_boot == "ASUS" ];then
	rm /data/asusdata/diag_enable
	setprop persist.usb.diag 0
fi

if [ $build_type == "user" ];then
	mount -o remount,ro /data/asusdata
fi
