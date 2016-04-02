#!/system/bin/sh
# Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#Function to start sensors for DSPS enabled platforms

init_sensors_status()
{
    rm /data/data/gyroscope_status
    rm /data/data/gsensor_status
    rm /data/data/ecompass_status
    rm /data/data/ecompass_phone_i2c
    rm /data/data/gsensor_raw
    rm /data/data/ecompass_raw

    echo 1 > /data/data/gsensor_status
    echo 1 > /data/data/gyroscope_status
    echo 1 > /data/data/ecompass_status
    echo 1 > /data/data/ecompass_phone_i2c

    chmod 777 /data/data/gyroscope_status
    chmod 777 /data/data/gsensor_status
    chmod 777 /data/data/ecompass_status
    chmod 777 /data/data/ecompass_phone_i2c
    
    mkdir -p /data/data/sensordebug
    chmod 777 /data/data/sensordebug
    
    # ASUS_BSP +++ Peter_Lu "Porting sensor HAL"
	chown -h system.system /sys/bus/i2c/devices/6-001c/al3010/power_state
	chown -h system.system /sys/bus/i2c/devices/6-001c/al3010/flush
	# ASUS_BSP ---
}
#ASUS_BSP --- Jiunhau_Wang [A91][ADSP][NA][ATD] support ADSP BMMI

start_sensors()
{
    if [ -c /dev/msm_dsps -o -c /dev/sensors ]; then
# ASUS_BSP +++ Jiunhau_Wang [A91][ADSP][RD][Fix] fix ota update, ADSP load firmware fail
        mkdir -p /persist/sensors
        touch /persist/sensors/sensors_settings
# ASUS_BSP --- Jiunhau_Wang [A91][ADSP][RD][Fix] fix ota update, ADSP load firmware fail
        chmod -h 775 /persist/sensors
        chmod -h 664 /persist/sensors/sensors_settings
        chown -h system.root /persist/sensors/sensors_settings

        mkdir -p /data/misc/sensors
        chmod -h 775 /data/misc/sensors
# ASUS_BSP +++ Jiunhau_Wang [PF500KL][ADSP][RD][Fix] Copy sns.reg from /factory to /data/misc/sensors for file cannot RW issue
#        if [ ! -e /data/misc/sensors/sns.reg ]; then 
            cp /factory/sns.reg /data/misc/sensors/sns.reg
            restorecon -FRvv /data/misc/sensors/sns.reg
#        fi
# ASUS_BSP --- Jiunhau_Wang [PF500KL][ADSP][RD][Fix] Copy sns.reg from /factory to /data/misc/sensors for file cannot RW issue
# ASUS_BSP +++ Jiunhau_Wang [A91][ADSP][RD][Fix] fix ota update, ADSP load firmware fail
        if [ ! -s /persist/sensors/sensors_settings ]; then		
        # If the settings file is empty, enable sensors HAL		
        # Otherwise leave the file with it's current contents		
            echo 1 > /persist/sensors/sensors_settings		
        fi
# ASUS_BSP --- Jiunhau_Wang [A91][ADSP][RD][Fix] fix ota update, ADSP load firmware fail
        start sensors
    fi
}

start_sensors
sleep 3
init_sensors_status
# ASUS_BSP --- Jiunhau_Wang "[A91][Sensor][NA][Spec] Disable Qualcomm DSPS"
