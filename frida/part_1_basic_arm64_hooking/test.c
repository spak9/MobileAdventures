#include <stdio.h>

int main(void) 
{
    char name[20];
    printf("Hello. What's your name?\n");
    //scanf("%s", &name);  - deprecated
    fgets(name,20,stdin);
    printf("Hi there, %s", name);
    return 0;
}
