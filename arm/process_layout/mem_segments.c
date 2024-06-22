/**
 * Example code from "The Linux Programming Interface"
 * 
 * As it's noted in the book, it depends on the ABI you have, which may 
 * change whether something is passed back via register or stack
 */

#include <stdio.h>
#include <stdlib.h>

char globBuf[65536];                // Uninitialized data segment (__DATA,__bss)
int primes[] = {1, 2, 3, 5, 7};     // Initialized data segment   (__DATA, __data)

static int square(int x) {          // Allocated in stack frame for square (x arg)
  int result;                       // Allocated in stack frame for square (local var result)
  result = x * x;
  return result;                    // Stack frame or register
}

static void doCalc(int val) {       // Allocated in stack frame for doCalc (val)
  printf("The square of %d is %d\n", val, square(val));
  
  if (val < 1000) {
    int t;                          // Allocated in stack frame for doCalc (t)
    
    t = val * val * val;
    printf("The cube of %d is %d\n", val, t);
  }
}


int main(int argc, char *argv[]) {    // Allocated in stack frame for "main" (argc, argv)
  static int key = 9973;              // Initialized data segment   (__DATA, __data)
  static char mbuf[10000];            // Uninitialized data segment (__DATA, __bss)
  char *p;                            // Stack frame (p)

  p = malloc(1024);                   // Points to memory in heap segment

  doCalc(key);

 //exit(0);
 return 1;
}