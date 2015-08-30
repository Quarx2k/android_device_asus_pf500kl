# Copyright (C) 2012 The Android Open Source Project
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

import os

TARGET_DIR = os.getenv('OUT')

def FullOTA_InstallEnd(self):
  self.output_zip.write(os.path.join(TARGET_DIR, "fixup.sh"), "fixup.sh")
  self.script.AppendExtra('package_extract_file("fixup.sh", "/tmp/fixup.sh");')
  self.script.AppendExtra('set_metadata("/tmp/fixup.sh", "uid", 0, "gid", 0, "mode", 0755);')
  self.script.Mount("/system")
  self.script.AppendExtra('run_program("/tmp/fixup.sh");')
  self.script.Unmount("/system");

  self.output_zip.write(os.path.join(TARGET_DIR, "firmware-update/tz.mbn"), "firmware-update/tz.mbn")
  self.output_zip.write(os.path.join(TARGET_DIR, "firmware-update/NON-HLOS.bin"), "firmware-update/NON-HLOS.bin")
  self.output_zip.write(os.path.join(TARGET_DIR, "firmware-update/asusfw.img"), "firmware-update/asusfw.img")
  self.output_zip.write(os.path.join(TARGET_DIR, "firmware-update/rpm.mbn"), "firmware-update/rpm.mbn")
  self.script.AppendExtra('ui_print("installing tz");')
  self.script.AppendExtra('package_extract_file("firmware-update/tz.mbn", "/dev/block/platform/msm_sdcc.1/by-name/tz");')
  self.script.AppendExtra('ui_print("installing modem");')
  self.script.AppendExtra('package_extract_file("firmware-update/NON-HLOS.bin", "/dev/block/platform/msm_sdcc.1/by-name/modem");')
  self.script.AppendExtra('ui_print("installing asusfw");')
  self.script.AppendExtra('package_extract_file("firmware-update/asusfw.img", "/dev/block/platform/msm_sdcc.1/by-name/asusfw");')
  self.script.AppendExtra('ui_print("installing rpm");')
  self.script.AppendExtra('package_extract_file("firmware-update/rpm.mbn", "/dev/block/platform/msm_sdcc.1/by-name/rpm");')



