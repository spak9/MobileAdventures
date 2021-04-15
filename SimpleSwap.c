#include <stdio.h>

/*
 * Swap 2 integers
 */
void fake_swap(int x, int y) 
{
    int temp = x; 
    x = y;
    y = temp;
}

/* 
 * Swaps 2 integer, but real..
 */
void real_swap(int *x, int *y)
{
    int temp; 
    temp = *x;      // dereference 'x' and assign to 'temp
    *x = *y;        // set dereferenced 'y' to derefenced 'x'
    *y = temp;

}

int f(int a[][2])
{
    return 1;
}

void main()
{
    int a = 10;
    int b = 20;
    fake_swap(a, b);
    // Does a = 20 and b = 10?
    printf("After fake-swap()\n");
    printf("\'a\' should be 20, but is: %d\n", a);
    printf("\'b\' should be 10, but is: %d\n", b);

    real_swap(&a, &b);
    printf("After real-swap()\n");
    printf("\'a\' should be 20, but is: %d\n", a);
    printf("\'b\' should be 10, but is: %d\n", b);

}

