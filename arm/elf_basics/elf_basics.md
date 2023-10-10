# ELF Basics

An `ELF` file is a common file format for:
- executable files
- shared objects/libraries
- object code 

It is typically the output of the compilation and linking process and it contains all the information
an operating system + loader needs in order to *load and run the actual program*.
The file format consists of 3 major pieces:

1. ELF Header -- global attributes of program (arch, endianness, etc), entry point, and various sizes and pointers.
2. ELF Program headers -- describes to the loader how to bring the binary into memory efficiently.
3. ELF Section headers --


## cmd

It should be noted that the `as` assembler and the `gcc` compiler both
revert to MacOS's `clang` tools.
MacOS outputs Mach-O files, but at the time of writing, I wanted to 
experiment with both ELF and Mach-Os.

### Assembling
The input is assembly files, typically with a `.s` file extension and output being object files, which can be encoded as either
ELF or Mach-O. These are "partial" object files that must be combined with
other object files via `linking` in order to create the full executable.
Typically a `as <program>.s -o <program>.o` would do it, but outputs a Mach-O
file.

1. ARM Mach-O Object file
```
as <program>.s -o <program>.o
stevenpak@stevenpaks-mbp elf_basics % file HelloWorld_MachO.o 
HelloWorld_MachO.o: Mach-O 64-bit object arm64
``` 

2. ARM ELF Object file
```
clang --target=aarch64-unknown-linux-gnu -c -o <program>.o <program>.s
stevenpak@stevenpaks-mbp elf_basics % file HelloWorld_elf.o 
HelloWorld_elf.o: ELF 64-bit LSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
```
Note that the `-c` flag is the assembling flag and does NOT do the final linking stage.

### Linking
The input of linking are object files or shared libraries, and the output is an .. TBD

1. ARM Mach-O 
```
ld -o HelloWorld HelloWorld.o \
	-lSystem \
	-syslibroot `xcrun -sdk macosx --show-sdk-path` \
	-arch arm64
```

2. ARM ELF
```
/opt/homebrew/opt/llvm/bin/ld.lld HelloWorld_elf.o -o HelloWorld_elf
```
