atfwd_ready=`getprop sys.atcmd.ready`
usb_diag=`getprop persist.usb.diag`
usb_config=`getprop sys.usb.config`
diag_enable=`ls /data/asusdata/diag_enable`
cmdline=`cat /proc/cmdline`
fuse_check=0
allow_check=0

#Check Fuse status
case "$cmdline" in
	*SB=Y*)
	case "$cmdline" in
		*UNLOCKED=Y*)
			fuse_check=0
		;;
		* )
			fuse_check=1
		;;
	esac
	;;
	* )
			fuse_check=0
	;;
esac
#Check diag_enable and atfwd
#
case "$diag_enable" in
	*diag_enable*)
	case "$atfwd_ready" in
		"1" )
			allow_check=1
		;;
		* )
			allow_check=0
		;;
	esac
	;;
	* )
		allow_check=1
	;;
esac

#Switch USB
#
if [ $allow_check == "1" ] && [ $fuse_check == "0" ] && [ $usb_diag == "1" ];then
	echo 0 > /sys/class/android_usb/android0/enable
	echo 1 > /sys/class/android_usb/android0/diag
	echo diag > /sys/class/android_usb/android0/f_diag/clients
	echo smd,tty > /sys/class/android_usb/android0/f_serial/transports
	echo smd,bam > /sys/class/android_usb/android0/f_rmnet/transports 
	echo diag,adb,serial,rmnet > /sys/class/android_usb/android0/functions
	echo 1 > /sys/class/android_usb/android0/enable
elif [ $allow_check == "1" ] && [ $fuse_check == "0" ] && [ $usb_diag == "0" ];then
	echo 0 > /sys/class/android_usb/android0/enable
	echo 0 > /sys/class/android_usb/android0/diag
	echo $usb_config > /sys/class/android_usb/android0/functions
	echo 1 > /sys/class/android_usb/android0/enable
fi
