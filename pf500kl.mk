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

ifneq ($(QCPATH),)
$(call inherit-product-if-exists, $(QCPATH)/common/config/device-vendor.mk)
endif

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/mixer_paths.xml:system/etc/mixer_paths.xml \

PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

PRODUCT_PROPERTY_OVERRIDES += \
    mm.enable.smoothstreaming=true \
    mm.enable.qcom_parser=3314291 \
    ro.qc.sdk.audio.fluencetype=fluence \
    persist.audio.fluence.voicecall=true \
    audio.offload.buffer.size.kb=32 \
    av.offload.enable=true \
    av.streaming.offload.enable=true \
    use.voice.path.for.pcm.voip=true \
    audio.offload.multiple.enabled=false \
    audio.offload.gapless.enabled=true \
    qcom.hw.aac.encoder=false \
    tunnel.audio.encode=true \
    media.aac_51_output_enabled=true \
    audio.offload.pcm.enable=true \
    audio.offload.24bit.enable=1 \
    media.aaccodectype=1

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    e2fsck \
    setup_fs

PRODUCT_PACKAGES += \
    libxml2

# NFC packages
PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    nfc_nci.msm8974 \
    libnfc_ndef \
    libnfc_jni \
    com.android.nfc_extras

# Graphics
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    liboverlay

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/gps/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/gps/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/gps/quipc.conf:system/etc/quipc.conf \
    $(LOCAL_PATH)/gps/sap.conf:system/etc/sap.conf

# Lights
PRODUCT_PACKAGES += \
    lights.msm8974

# IPC router config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Media profile
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/mixer_paths.xml:system/etc/mixer_paths.xml

# Media
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdivxdrmdecrypt \
    libdashplayer \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc \
    libstagefrighthw \
    qcmediaplayer

PRODUCT_BOOT_JARS += qcmediaplayer

# NFC
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access_debug.xml
endif

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# Power
PRODUCT_PACKAGES += \
    power.msm8974

# QRNGD
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

# Keystore, buggy currently
#PRODUCT_PACKAGES += \
#    keystore.msm8974

# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# WiFi
PRODUCT_COPY_FILES += \
    kernel/asus/msm8974/drivers/staging/prima/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    kernel/asus/msm8974/drivers/staging/prima/firmware_bin/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    kernel/asus/msm8974/drivers/staging/prima/firmware_bin/WCNSS_qcom_cfg.ini:/system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf \
    hostapd_default.conf \
    hostapd.accept \
    hostapd.deny

PRODUCT_PACKAGES += \
    wcnss_service

# Misc dependency packages
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    curl \
    libnl_2 \
    libbson

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Enable Bluetooth HFP service
PRODUCT_PROPERTY_OVERRIDES +=
    bluetooth.hfp.client=1

# System properties
PRODUCT_PROPERTY_OVERRIDES += \
    persist.hwc.mdpcomp.enable=true \
    ro.opengles.version=196608 \
    ro.qualcomm.bt.hci_transport=smd \
    ro.data.large_tcp_window_size=true \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.telephony.call_ring.multiple=0

# Permissions
PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    $(LOCAL_PATH)/configs/quipc.conf:system/etc/quipc.conf \

# Rootdir
PRODUCT_COPY_FILES += \
    device/asus/pf500kl/rootdir/fstab.qcom:root/fstab.qcom \
    device/asus/pf500kl/rootdir/init.asus.debugtool.rc:root/init.asus.debugtool.rc \
    device/asus/pf500kl/rootdir/init.asus.rc:root/init.asus.rc \
    device/asus/pf500kl/rootdir/init.asus.thermald.rc:root/init.asus.thermald.rc \
    device/asus/pf500kl/rootdir/init.asus.usb.boot.sh:root/init.asus.usb.boot.sh \
    device/asus/pf500kl/rootdir/init.asus.usb.diag.sh:root/init.asus.usb.diag.sh \
    device/asus/pf500kl/rootdir/init.asus.usb.rc:root/init.asus.usb.rc \
    device/asus/pf500kl/rootdir/init.asusreset.rc:root/init.asusreset.rc \
    device/asus/pf500kl/rootdir/init.class_main.sh:root/init.class_main.sh \
    device/asus/pf500kl/rootdir/init.qcom.class_core.sh:root/init.qcom.class_core.sh \
    device/asus/pf500kl/rootdir/init.qcom.early_boot.sh:root/init.qcom.early_boot.sh \
    device/asus/pf500kl/rootdir/init.qcom.factory.sh:root/init.qcom.factory.sh \
    device/asus/pf500kl/rootdir/init.qcom.rc:root/init.qcom.rc \
    device/asus/pf500kl/rootdir/init.qcom.ril.sh:root/init.qcom.ril.sh \
    device/asus/pf500kl/rootdir/init.qcom.sensor.sh:root/init.qcom.sensor.sh \
    device/asus/pf500kl/rootdir/init.qcom.sh:root/init.qcom.sh \
    device/asus/pf500kl/rootdir/init.qcom.ssr.sh:root/init.qcom.ssr.sh \
    device/asus/pf500kl/rootdir/init.qcom.syspart_fixup.sh:root/init.qcom.syspart_fixup.sh \
    device/asus/pf500kl/rootdir/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/asus/pf500kl/rootdir/init.qcom.usb.rc:root/init.qcom.usb.rc \
    device/asus/pf500kl/rootdir/ueventd.qcom.rc:root/ueventd.qcom.rc \
    device/asus/pf500kl/rootdir/init.target.rc:root/init.target.rc

# Others
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/init.asus.create-smmilink.sh:system/etc/init.asus.create-smmilink.sh \
    $(LOCAL_PATH)/configs/init.asus.thermal_conf.sh:system/etc/init.asus.thermal_conf.sh \
    $(LOCAL_PATH)/configs/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
    $(LOCAL_PATH)/configs/init.qcom.fm.sh:system/etc/init.qcom.fm.sh \
    $(LOCAL_PATH)/configs/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
    $(LOCAL_PATH)/configs/init.qcom.wifi.sh:system/etc/init.qcom.wifi.sh \
    $(LOCAL_PATH)/configs/init.crda.sh:system/etc/init.crda.sh \

# TS/Keys
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/Himax-touchscreen.idc:system/usr/idc/Himax-touchscreen.idc \
    $(LOCAL_PATH)/configs/elan-touchscreen.idc:system/usr/idc/elan-touchscreen.idc \
    $(LOCAL_PATH)/configs/asus_dds_sis_touch.idc:system/usr/idc/asus_dds_sis_touch.idc \
    $(LOCAL_PATH)/configs/ASUS_TransKeyboard.idc:system/usr/idc/aASUS_TransKeyboard.idc

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# call dalvik heap config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

# call the proprietary setup
$(call inherit-product-if-exists, vendor/asus/pf500kl/pf500kl-vendor.mk)

