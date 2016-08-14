/*
   Copyright (c) 2014, The Linux Foundation. All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

#define CHUNK 2048 /* read 2048 bytes at a time */

int check_cmdline(const char param[]) {

    char buf[CHUNK];
    FILE *file;
    size_t nread;
    file = fopen("/proc/cmdline", "r");
    if (file) {
        while ((nread = fread(buf, 1, sizeof buf, file)) > 0) {
                /* fwrite(buf, 1, nread, stdout); */
                char delims[] = " ";
                char *word = NULL;
                word = strtok(buf, delims);

                while(word != NULL) {
                        if (!strcmp(param,word)) {
                                fclose(file);
                                return 1;
                        }
                        word = strtok(NULL, delims);
                }
        }
    }	
    fclose(file);
    return 0;
}

void vendor_load_properties()
{
    char device[PROP_VALUE_MAX];
    char devicename[PROP_VALUE_MAX];

    if (check_cmdline("HW_ID=PF500KL_ER1") == 1) {
        property_set("ro.hardware.id", "PF500KL_ER1");
    } else if (check_cmdline("HW_ID=PF500KL_ER2") == 1) {
        property_set("ro.hardware.id", "PF500KL_ER2");
    } else if (check_cmdline("HW_ID=PF500KL_ER2_2") == 1) {
        property_set("ro.hardware.id", "PF500KL_ER2_2");
    } else if (check_cmdline("HW_ID=PF500KL_PR") == 1) {
        property_set("ro.hardware.id", "PF500KL_PR");
    } else if (check_cmdline("HW_ID=PF500KL_MP") == 1) {
        property_set("ro.hardware.id", "PF500KL_MP");
    } else if (check_cmdline("HW_ID=PF500KL_MP2") == 1) {
        property_set("ro.hardware.id", "PF500KL_MP2");
    } else if (check_cmdline("HW_ID=A91_SR1") == 1) {
        property_set("ro.hardware.id", "A91_SR1");
    } else if (check_cmdline("HW_ID=A91_SR2") == 1) {
        property_set("ro.hardware.id", "A91_SR2");
    } else if (check_cmdline("HW_ID=A91_SR3") == 1) {
        property_set("ro.hardware.id", "A91_SR3");
    } else if (check_cmdline("HW_ID=A91_SR4") == 1) {
        property_set("ro.hardware.id", "A91_SR4");
    } else if (check_cmdline("HW_ID=A91_SR5") == 1) {
        property_set("ro.hardware.id", "A91_SR5");
    } else if (check_cmdline("HW_ID=A91_ER1") == 1) {
        property_set("ro.hardware.id", "A91_ER1");
    } else if (check_cmdline("HW_ID=A91_ER2") == 1) {
        property_set("ro.hardware.id", "A91_ER2");
    } else if (check_cmdline("HW_ID=A91_PR") == 1) {
        property_set("ro.hardware.id", "A91_PR");
    } else if (check_cmdline("HW_ID=A91_MP") == 1) {
        property_set("ro.hardware.id", "A91_MP");
    }
    property_get("ro.hardware.id", device);
    strlcpy(devicename, device, sizeof(devicename));
    ERROR("Found hardware id: %s setting build properties.\n", devicename);
}
