int check(void)
{
  #ifdef __unix__
    printf("Gay!\n");    
  #elif defined(_WIN32) || defined(WIN32)
    printf("Extra Gay!\n");
    exit(0)
  #endif
}