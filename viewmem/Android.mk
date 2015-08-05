LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := viewmem
LOCAL_SRC_FILES := viewmem.c
LOCAL_LDFLAGS := -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_STATIC_LIBRARIES := libc libcutils libutils liblog
include $(BUILD_EXECUTABLE)
