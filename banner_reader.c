#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char read_file(char *file_path) {
    FILE *fp;
    char file_data[255];
    fp = fopen(argv[1], "r");
    fread(&file_data, 255, 1, fp);
    fclose(fp);
    // printf("%s", file_data);
    return file_data;
}

int main(int argc, char **argv[]) {
    char test = read_file(argv[1]);
    printf("%s", test);
    return 0;
}