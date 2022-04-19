#include <stdio.h>

extern int ext_var = 10; // An extern variable to be seen via Export/Symbol


char* mystery_function(char* input) {
	printf("My input was: %s", input);
	return input;
}

int main(void) 
{
    // Reassign `ext_var`
    ext_var = 12345;
    char name[20];
    printf("Hello. What's your name?\n");
    fgets(name,20,stdin);
    printf("Hi there, %s", name);

    char* mystery_value = mystery_function(name);
    printf("The return from mystery_function() was: %s", mystery_value);
    return 0;
}


