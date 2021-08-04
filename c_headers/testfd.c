int r_keys(int fd) 
{
    char buf[255];
    while(1) {
        int test = read(fd, buf, sizeof(buf));
        printf(buf);
    }
    return 0;
}