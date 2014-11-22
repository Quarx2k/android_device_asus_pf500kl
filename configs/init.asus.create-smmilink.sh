#!/system/bin/sh

LOG_TAG="create-smmilink"
LOG_NAME="${0}:"

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

#Selectively start coex module
mount_needed=`getprop persist.sys.enableSMMI`

if [ "$mount_needed" == "1" ]; then
    logi "create-smmilink : persist.sys.enableSMMI = 1"


    chmod 0771 /data
    chmod 0771 /data/data

# When persist.sys.enableSMMI is set to 1 , 
# start copy link to /data/data/ and chmod 

# ---------------- Exampple ---------------
 #ASUS_BSP Eric : add for ATD pcbid Test +++

    start create_pcbid

 #ASUS_BSP Eric : add for ATD pcbid Test ---
# --------------- Example -----------------

#ASUS BSP Wei +++

  rm /data/data/hdmi_status
  ln -s  /sys/devices/virtual/graphics/fb1/connected /data/data/hdmi_status
  chmod 0777 /data/data/hdmi_status

  rm /data/data/sdtp2600_fw_ver
  ln -s /sys/devices/f9928000.i2c/i2c-6/6-0074/SDTP2600/fw_ver /data/data/sdtp2600_fw_ver
  chmod 0777 /data/data/sdtp2600_fw_ver


  rm /data/data/myDP_status
  ln -s /sys/devices/f9925000.i2c/i2c-3/3-0039/ChipID /data/data/myDP_status
  chmod 0777 /data/data/myDP_status

#ASUS BSP Wei ---


#ASUS BSP ShawnHuang +++
  rm /data/data/pad_cap_status
  ln -s /sys/bus/i2c/devices/i2c-6/6-0028/cap1106/result /data/data/pad_cap_status
  chmod 0777 /data/data/pad_cap_status
#ASUS BSP ShawnHuang ---

#ASUS_BSP+++ AllenWang "Add native service for NFC ATD test"+++
touch /data/data/CardStatus.txt
touch /data/data/ReaderStatus.txt
chmod 0777 /data/data/CardStatus.txt
chmod 0777 /data/data/ReaderStatus.txt
#ASUS_BSP--- AllenWang "Add native service for NFC ATD test"---

#ASUS_BSP Deeo : add for Led test +++
  ln -s /system/bin/LedTest /data/data/LedTest
  chmod 0777 /data/data/LedTest
  ln -s /system/bin/PadLED_Test /data/data/PadLED_Test
  chmod 0777 /data/data/PadLED_Test
  chown system system /sys/class/leds/red/blink
  chmod 0666 /sys/class/leds/red/blink
  chown system system /sys/class/leds/green/blink
  chmod 0666 /sys/class/leds/green/blink
  chown system system /sys/class/leds/blue/blink
  chmod 0666 /sys/class/leds/blue/blink
  chown system system /sys/class/leds/mix/blink
  chmod 0666 /sys/class/leds/mix/blink
#ASUS_BSP Deeo : add for Led test ---
#ASUS Tim++
    ln -s /system/bin/AudioRoutingTest /data/data/AudioRoutingTest
    chmod 0777 /data/data/AudioRoutingTest
#ASUS Tim--

# ASUS_BSP +++ Stimber "change path for ATD test"
    rm /data/data/camera_flash
    ln -s /system/etc/camera_flash /data/data/camera_flash
    chmod 0777 /data/data/camera_flash
# ASUS_BSP --- Stimber "change path for ATD test"

else
    logi "create-smmilink : persist.sys.enableSMMI = 0"	

# When persist.sys.enableSMMI is set to 0 , 
# delete link at /data/data/  

# ---------------- Exampple ---------------
 #ASUS_BSP Eric : add for ATD pcbid Test +++
 rm /data/data/pcbid_status
 #ASUS_BSP Eric : add for ATD pcbid Test ---
# --------------- Example -----------------
#ASUS BSP Wei +++
  rm /data/data/hdmi_status
  rm /data/data/sdtp2600_fw_ver
  rm /data/data/myDP_status
#ASUS BSP Wei ---


#ASUS BSP ShawnHuang +++
  rm /data/data/pad_cap_status
#ASUS BSP ShawnHuang ---

#ASUS_BSP+++ AllenWang "Add native service for NFC ATD test"+++
rm /data/data/CardStatus.txt
rm /data/data/ReaderStatus.txt
#ASUS_BSP--- AllenWang "Add native service for NFC ATD test"---

#ASUS_BSP Deeo : add for Led test +++
  rm /data/data/LedTest
  rm /data/data/PadLED_Test
#ASUS_BSP Deeo : add for Led test ---
#ASUS Tim++
    rm /data/data/AudioRoutingTest
#ASUS TIM--

# ASUS_BSP +++ Stimber "change path for ATD test"
	rm /data/data/camera_flash
# ASUS_BSP --- Stimber "change path for ATD test"

    chmod 0771 /data
    chmod 0771 /data/data

fi
