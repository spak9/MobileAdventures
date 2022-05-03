#include <stdio.h>


void basic_function(char* input1, int input2, int* input3) {
	printf("input1 address is [0x%x], input1 is [%s]\n", &input1, input1);
	printf("input2 address is [0x%x], input2 is [%d]\n", &input2, input2);
	printf("input3 address is [0x%x], input3 is [%x]\n", &input3, input3);
	
}

void main(void) 
{
    char* str = "Steven Pak";
    int num_1 = 123456;
    int* num_2 = &num_1;
    printf("num_2 address is [0x%x], num_2 is [0x%x]\n", &num_2, num_2);
    
    basic_function(str, num_1, num_2);
    
}


