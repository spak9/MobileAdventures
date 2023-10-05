.arch armv8-a 
.text
.global _main

_main:
	mov x0, #1
	ldr x1, mystring
	mov x2, #12
	mov x8, #64
	svc #1

	mov x0, #0
	mov x8, #93
	svc #1

mystring:
.asciz "Hello world\n"