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

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit from device
$(call inherit-product, device/asus/t00n/t00n.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

PRODUCT_NAME := cm_t00n
PRODUCT_DEVICE := t00n
PRODUCT_MANUFACTURER := asus
PRODUCT_MODEL := ASUS_T00N
PRODUCT_BRAND := asus

TARGET_VENDOR_PRODUCT_NAME := ASUS_T00N
TARGET_VENDOR_DEVICE_NAME := ASUS_T00N
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=ASUS_T00N PRODUCT_NAME=WW_PadFone
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=asus/WW_PadFone/ASUS_T00N:6.0/MRA58K/2256973:user/release-keys \
    PRIVATE_BUILD_DESC="WW_PadFone-user 6.0 MRA58K 2256973 release-keys"
