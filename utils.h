#pragma once

char read_file(char *file_path) {
    FILE *fp;
    char *response[1024];
    fp = fopen(file_path, "r");
    fread(response, 1024, 1, fp);
    fclose(fp);
    return response;
}