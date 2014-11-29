/*
 * Copyright (C) 2014, The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//#define LOG_NDEBUG 0

#define LOG_TAG "wcnss_t00n"

#include <cutils/log.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define MAC_INFO_FILE "/data/asusdata/wifi.nv"

#define BUF_SIZE 30

int wcnss_init_qmi(void)
{
    /* empty */
    return 0;
}

int wcnss_qmi_get_wlan_address(unsigned char *mac)
{

    FILE *fh;
    char buffer[BUF_SIZE + 1];

    int tmp[6];

    int i, length;
     
    if (!(fh = fopen(MAC_INFO_FILE, "r"))) {
        ALOGE("Failure to open file:  %s\n", MAC_INFO_FILE);
    }

    if (!fgets(buffer, BUF_SIZE, fh))
        return 0;

    for (i = 0;  buffer[i] != '\0'; i++) {
        buffer[i] =  buffer[i + 12];
    }

    fclose(fh);

    sscanf(buffer,"%02X%02X%02X%02X%02X%02X", &tmp[0], &tmp[1], &tmp[2], &tmp[3], &tmp[4], &tmp[5]);

    for (i = 0; i < 6; i++) {
        mac[i] = tmp[i];
        printf("%02hhx\n", mac[i]);
    }

    ALOGI("Found MAC address: %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
        mac[0],
        mac[1],
        mac[2],
        mac[3],
        mac[4],
        mac[5]);

    return 0;
}

void wcnss_qmi_deinit(void)
{
    /* empty */
}
