#include <stdio.h>

extern int ext_var = 10;
int main(void) 
{
    ext_var = 12345;
    char name[20];
    printf("Hello. What's your name?\n");
    //scanf("%s", &name);  - deprecated
    fgets(name,20,stdin);
    printf("Hi there, %s", name);
    return 0;
}


