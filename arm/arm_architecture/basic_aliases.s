.global _main			// Provide program starting address to linker
.align 4			// Make sure everything is aligned properly

_main:
	mov X0, #14
	asr X1, X0, #3
	lsl X1, X0, #3
	lsr X1, X0, #3
	ror X1, X0, #3

	sbfm X1, X0, #3, #63
	ubfm X1, X0, #61, #60
	ubfm X1, X0, #3, #63
	extr X1, X0, X0, #3

	mov     X0, #0		// Use 0 return code
	mov     X16, #1		// System call number 1 terminates this program
	svc     #0x80		// Call kernel to terminate the program