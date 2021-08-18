#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

void sleep_f(int timee) {
    sleep(timee);
}

void exit_msg(char *msg) {
    printf("%s", msg);
    exit(0);
}