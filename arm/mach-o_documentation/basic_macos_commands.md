# Basic Commands for Mach-O Analysis

A `Mach-O` binary file is comprised of 3 major parts:
1. Mach-O header
```c
struct mach_header_64
   {
   uint32_t magic;
   cpu_type_t cputype;
   cpu_subtype_t cpusubtype;
   uint32_t filetype;
   uint32_t ncmds;
   uint32_t sizeofcmds;
   uint32_t flags;
   uint32_t reserved;
};
```
2. Load Commands
A way to tell the dynamic loader how to load & link the binary in memory. 
I like to view it as a table of contents, where each command describes position
of segments (data) and relevant metadata.
The file format says the following:
```
The load command structures are located directly after the header of the object file, and they specify *both the logical structure of the file and the layout of the file in virtual memory*. Each load command begins with fields that specify the command type and the size of the command data.
```
Here is how a load command would be laid out in memory via the struct:
```c
struct load_command
   {
   uint32_t cmd;
   uint32_t cmdsize;
};
+
struct segment_command_64
   {
   uint32_t cmd;
   uint32_t cmdsize;
   char segname[16];   // e.g "__TEXT"
   uint64_t vmaddr;
   uint64_t vmsize;
   uint64_t fileoff;
   uint64_t filesize;
   vm_prot_t maxprot;
   vm_prot_t initprot;
   uint32_t nsects;
   uint32_t flags;
};
+
// optionally followed by a "section" struct if the segment has sections within it
struct section_64
   {
   char sectname[16];
   char segname[16];    // e.g. "__text"
   uint64_t addr;
   uint64_t size;
   uint32_t offset;
   uint32_t align;
   uint32_t reloff;
   uint32_t nreloc;
   uint32_t flags;
   uint32_t reserved1;
   uint32_t reserved2;
};
```

3. Data and code (segments)
The actual data, whether that be the instructions, symbol tables, dynamic libraries,
constants, cstrings, etc. 

- Small note:
Whenever you view a 64-bit Mach-O executable in any disassembler like Hopper, you'll see that
the start virtual address is at `0x100000000`, which is 2^32 (4GB) in hex. 
I've read reasons are that it reserves upto `0x100000000` bytes of memory for system use & compat. 
Therefore you'll start off with that `__PAGEZERO` segment, usually `0x100000000` long
(conceptually, not on-disk).

## Commands

Dump the header:
`otool -hv <bin>`

Dump all load commands
`otool -lv <bin>`

Dump all shared libraries used
`otool -L <bin>`

Dump all indirect symbols (dynamic symbol pointers/stubs, that is, symbols that the executable needs to resolve at runtime).
`otool -Iv <bin>`