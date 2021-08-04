int check(void)
{
  #ifdef __unix__
    printf("[+] Linux System!\r\n");    
  #elif defined(_WIN32) || defined(WIN32)
    printf("This system is not on linux!\r\n");
    exit(0);
  #endif
}
