#include <stdio.h>


void basic_function(char* input1, int input2, int* input3) {
	printf("input1 value: %x - a char* \n", input1);		// A memory address
	printf("input2 value: %x - a int \n", input2);		// An actual value (hex for 123456)
	printf("input3 value: %x - a int* \n", input3);		// A memory address
	
}

void main(void) 
{
    char* str = "Steven Pak";
    int num_1 = 123456;
    int* num_2 = &num_1;
    
    basic_function(str, num_1, num_2);
}


