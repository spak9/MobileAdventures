# Binary Adventures

This repo serves as a playground for learning more about binary analysis, in particular, ARM binaries!


## Cross-compilation and execution
- qemu-user-static for executing statically linked aarch64 binaries on x86-64
- qemu-user for executing dynamically linked aarch64 binaries on x86-64

- Example for executing aarch64 statically linked binary:
`./<executable_name`

- Example for executing aarch64 dynamically linked binary:
`qemu-aarch64 -L /usr/aarch64-linux-gnu ./<executable_name>`

- Example for compiling statically linked 32-bit ARM
`arm-linux-gnueabihf-gcc -static -o <executable_name> <source_file>.c`

- Example for compiling dynamically linked 32-bit ARM
`arm-linux-gnueabihf-gcc -o <executable_name> <source_file>.c`
`qemu-arm -L /usr/arm-linux-gnueabihf <executable_name>`

## Links

- [Cross-compiling from x86 to ARMv8](https://jensd.be/1126/linux/cross-compiling-for-arm-or-aarch64-on-debian-or-ubuntu)
