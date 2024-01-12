#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <syslog.h>

int main(int argc, char *argv[])
{
    openlog(NULL, 0, LOG_USER);

    if (argc < 3)
    {
        syslog(LOG_ERR, "Not enough args: %d", argc);
        return 1;
    }
    
    char *writefile = argv[1];
    char *writestr = argv[2];

    int fd;
    fd = creat(writefile, S_IRUSR | S_IRGRP | S_IROTH);
    if (fd == -1)
    {
        syslog(LOG_ERR, "Error opening file");
        return 1;
    }

    size_t count;
    ssize_t nw;

    count = strlen(writestr);
    nw = write(fd, writestr, count);
    if (nw == -1)
    {
        syslog(LOG_ERR, "Error writing file");
        return 1;
    }
    else if (nw != count)
    {
        syslog(LOG_ERR, "Error due to partial write");
        return 1;
    }

    if(close(fd) == -1)
    {
        syslog(LOG_ERR, "Error closing file");
        return 1;
    }
        
    syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);
    return 0;
}
