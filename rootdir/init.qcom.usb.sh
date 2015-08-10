#!/system/bin/sh
ls_ssn=`ls /data/asusdata/SSN`
case "$ls_ssn" in
	*SSN*)
		ssn_value=`cat /data/asusdata/SSN`
		echo "$ssn_value" > /sys/class/android_usb/android0/iSerial
	;;
	* )
		echo "C4ATAS000000" > /sys/class/android_usb/android0/iSerial
	;;
esac
exit
