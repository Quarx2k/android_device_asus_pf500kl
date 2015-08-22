/*
 * Copyright (C) 2015 Balázs Triszka <balika011@protonmail.ch>
 *
 * This file is licensed under the terms of the GNU General Public License
 * version 2. This program is licensed "as is" without any warranty of any
 * kind, whether express or implied.
 *
 */
 
#include <stdio.h>
#include <openssl/aes.h>
#include <cstring>
 
#define ASUS_AESED_FILE_SIZE_LIMIT 5120
#define ASUS_INPUT_FILE_SIZE_LIMIT 8192
#define ASUS_DATA_BLOCKSIZE 16
 
static const unsigned char ASUS_AES_KEY[] = {
        0x00, 0xAA, 0x11, 0x55, 0x44, 0x55, 0x66, 0x77,
        0xCC, 0x99, 0xAA, 0xCC, 0xCC, 0xDD, 0xEE, 0xFF
};
 
int main()
{
        FILE* f = fopen("thermal-engine-8974.conf", "rb");
        fseek(f, 0, SEEK_END);
        int size = ftell(f);
        if (size > ASUS_AESED_FILE_SIZE_LIMIT)
                return 0;
        fseek(f, 0, SEEK_SET);
        unsigned char* in = new unsigned char[size];
        fread(in, size, 1, f);
        fclose(f);
 
        AES_KEY wctx;
        AES_set_decrypt_key(ASUS_AES_KEY, 128, &wctx);
 
        unsigned char out[ASUS_INPUT_FILE_SIZE_LIMIT];
        memset(out, 0, ASUS_INPUT_FILE_SIZE_LIMIT);
 
        int asus_size = size / ASUS_DATA_BLOCKSIZE;
        if (size << 28)
                asus_size = size / ASUS_DATA_BLOCKSIZE + 1;
 
        for(int i = 0; i < asus_size; ++i)
                AES_decrypt(&in[ASUS_DATA_BLOCKSIZE * i], &out[ASUS_DATA_BLOCKSIZE * i], &wctx);
 
        f = fopen("thermal-engine-8974_dec.conf", "wb");
        fwrite(out, asus_size * ASUS_DATA_BLOCKSIZE, 1, f);
        fclose(f);
 
        return 0;
}
