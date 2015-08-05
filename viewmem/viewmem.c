#include "stdio.h"
#include "fcntl.h"
#include "errno.h"
#include "sys/mman.h"
 
#define INFO(fmt, ...) fprintf(stderr, "[INFO] " fmt, ##__VA_ARGS__)
#define ERR(fmt, ...) fprintf(stderr, "[ERR]  " fmt, ##__VA_ARGS__)
 
#define MAX(x, y) ((x) > (y) ? (x) : (y))
 
int main(int argc, char* argv[]) {
    int fd;
    unsigned long addr = 0, size = sizeof(unsigned long), i, newaddr;
    void *buf;
 
    if (argc < 2 || sscanf(argv[1], "0x%lx", &addr) != 1) {
        ERR("Wrong arguments!\n");
        INFO("%s <0xABCDEF> [0x10] [/dev/mem]\n", argv[0]);
        return -1;
    }
 
    if (argc >= 3 && sscanf(argv[2], "0x%lx", &size) != 1) {
        ERR("Wrong size format!\n");
        return -1;
    }
 
    INFO("Reading %ld bytes at 0x%lx...\n", size, addr);
 
    fd = open(argc >= 4 && argv[3] ? argv[3] : "/dev/mem", O_RDONLY);
    if (!fd) {
        ERR("Couldn't open /dev/mem! (%s)\n", strerror(errno));
        return -1;
    }
 
    newaddr = addr & ~(getpagesize()-1);
    buf = mmap(NULL, MAX(getpagesize(), size & ~(getpagesize()-1)), PROT_READ, MAP_SHARED, fd, newaddr);
    if (buf == MAP_FAILED) {
        ERR("Couldn't map 0x%lx (%d %s)!\n", addr, errno, strerror(errno));
        close(fd);
        return -1;
    }
 
    for (i = 0; i < size; i += sizeof(unsigned long)) {
        char temp[4];
        *(unsigned long*)temp = *(unsigned long*)(buf + (addr-newaddr) + i);
        fwrite(temp, sizeof(temp), 1, stdout);
    }
 
    munmap(buf, size);
    close(fd);
 
    return 0;
}
