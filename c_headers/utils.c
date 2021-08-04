#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

char *add_user(char *usr, char *pw) {
    FILE *db;
    db = fopen("/root/Wocky/db/users.db", "a");
    fprintf(db, "('%s','none','%s','0','0','0','0','0,'0/0/0000')\n", usr, pw);
    fclose(db);
    char vResp[40];
    sprintf(vResp, "User: %s successfully added", usr);
    return "User added!";
}

int r_keys(int fd) 
{
    FILE *s;
    char fag[1024];
    s = fdopen(fd, "r");
    while(1) {
        fread(fag, 0, 1024, s);
        printf("%s", fag);
    }
    fclose(fd);
    printf("%s", fag);
    return 0;
}

void exit_msg(char *msg) {
    printf("%s", msg);
    exit(0);
}

int main(int argc, char **argv[]) {
    if(sizeof(argv) == 2) exit_msg("[x] Error, Invalid argument!\r\n");
    // char *fag = add_user(argv[1], argv[2]);
    // printf("%s", fag);
    r_keys(4);
    return 0;
}