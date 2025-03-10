#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter LI7,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

DISPLAY_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/bin/hw/android.hardware.graphics.allocator@4.0-service-mediatek

$(DISPLAY_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(TARGET_BOARD_PLATFORM)/$(notdir $@).$(TARGET_BOARD_PLATFORM) $@

GATEKEEPER_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.trustonic.so \
	$(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.trustonic.so

$(GATEKEEPER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf libMcGatekeeper.so $@

KEYMASTER_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/kmsetkey.default.so \
	$(TARGET_OUT_VENDOR)/lib64/hw/kmsetkey.default.so

$(KEYMASTER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(subst default,trustonic,$(notdir $@)) $@

MEDIA_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/bin/v3avpud

$(MEDIA_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(notdir $@).$(TARGET_BOARD_PLATFORM) $@

SENSOR_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64/hw/sensors.$(TARGET_BOARD_PLATFORM).so
$(SENSOR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $(notdir $@)"
	@ln -sf sensors.mediatek.V2.0.so $@

VENDOR_PLATFORM_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/, $(strip $(shell cat $(COMMON_PATH)/symlink/vendor.txt)))
$(VENDOR_PLATFORM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $(notdir $@)"
	@ln -sf $(TARGET_BOARD_PLATFORM)/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += \
	$(DISPLAY_SYMLINKS) \
	$(GATEKEEPER_SYMLINKS) \
	$(KEYMASTER_SYMLINKS) \
	$(MEDIA_SYMLINKS) \
	$(SENSOR_SYMLINKS) \
	$(VENDOR_PLATFORM_SYMLINKS)

endif
