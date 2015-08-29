#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# inherit from asus common
-include device/asus/common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := krait
#TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

# Kernel
BOARD_CUSTOM_BOOTIMG_MK := device/asus/t00n/mkbootimg.mk
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02500000 --tags_offset 0x01e00000
TARGET_KERNEL_CONFIG := pf500kl-perf_defconfig
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 androidboot.selinux=enforcing
TARGET_KERNEL_SOURCE := kernel/asus/msm8974

# Enable dex-preoptimization to speed up first boot sequence
#WITH_DEXPREOPT := true

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Charger
BOARD_CHARGER_RES := device/asus/t00n/charger/images

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
AUDIO_FEATURE_ENABLED_LOW_LATENCY_CAPTURE := true
AUDIO_FEATURE_ENABLED_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
QCOM_BT_USE_SMD_TTY := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/asus/t00n/bluetooth 

# Charger
BOARD_CHARGER_RES := device/asus/t00n/charger/images

# Graphics
BOARD_EGL_CFG := device/asus/t00n/configs/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_USES_WCNSS_CTRL := true
TARGET_USES_QCOM_WCNSS_QMI := true
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP := "ap"

# Filesystem #Fix to real sizes.
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE     := 16777216
BOARD_CACHEIMAGE_PARTITION_SIZE    := 536870912
BOARD_PERSISTIMAGE_PARTITION_SIZE  := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 1388314624
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13271448576

# Recovery
TARGET_RECOVERY_FSTAB := device/asus/t00n/recovery.fstab
TARGET_INCREMENTAL_OTA_VERBATIM_FILES := /system/priv-app/OneTimeInitializer/OneTimeInitializer.apk

# Twrp
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"
TARGET_RECOVERY_QCOM_RTC_FIX := true
BOARD_UMS_LUNFILE := /sys/class/android_usb/f_mass_storage/lun0/file
DEVICE_RESOLUTION := 1920x1080
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_EXTERNAL_STORAGE_PATH := "/sdcard"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard"
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_FLASH_FROM_STORAGE := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_NO_REBOOT_BOOTLOADER := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
HAVE_SELINUX := true

# NFC
BOARD_NFC_CHIPSET := pn547

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-smd"

# No old RPC for prop
TARGET_NO_RPC := true

# Use HW crypto for ODE
TARGET_HW_DISK_ENCRYPTION := true

# Enable Minikin text layout engine (will be the default soon)
USE_MINIKIN := true

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Time services
BOARD_USES_QC_TIME_SERVICES := true

# Radio
BOARD_RIL_CLASS := ../../../device/asus/t00n/ril/

# SELinux policies
# qcom sepolicy
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
        device/asus/t00n/sepolicy

# inherit from the proprietary version
-include vendor/asus/tn00n/BoardConfigVendor.mk
