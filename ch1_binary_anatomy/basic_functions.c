#include <stdio.h>

int print_string(char *);

int main() {
	printf("Hello, Steven Pak!");
	char *some_str = "Hmm some random string?";
	print_string(some_str);
	return 0;
}

int print_string(char *string) {
	int a = 10;
	int b = 20;
	int c = 30;
	int d = a + b;
	int e = d + c;
	printf("%s", string);
}