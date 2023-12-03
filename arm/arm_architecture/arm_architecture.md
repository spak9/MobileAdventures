# ARM Architecture

## Execution States
- The term `architecture` is the behavioral description of a processor and defines the components like the instruction set.
The `micro-architecture` defines how that architecture is built, therefore, an implementation guide in a sense. 
EX: Armv8-A architecture, with Cortex-A32, Cortex-A72, etc.. as micro-architectures

- There's an idea of `profile`s within the ARMv8 architecture, but don't really know the core purpose, other than it being a distinguishing factor for the domain, such as rich OS, realtime OS, and micro-controller domains. 
We focus primarily on "A" - application.
Armv8-A allow execution for both 64-bit and 32-bit programs natively, but not all "implementations" support that.

- Two major execution states within ARMv8-A:
1. 64-bit - AArch64 --> uses A64 instruction set (32-bit wide instructions, 64-bit registers)
2. 32-bit - AArch32 --> uses earlier Armv7-A instruction sets (Arm & Thumb, which were then renamed to A32 and T32 respectively).
Summary: there are 3 instruction sets, A64, A32, T32. Armv8-A only runs in those 2 execution states, AArch64 and AArch32.


## AArch64
- Width of instructions are 32-bit, but virtual addresses use 64-bit format and can be stored in 64-bit registers, then meaning that A64 instructions can use 64-bit wide registers for processing.
- There for 4 major types are instructions in A64:
1. Data processing
2. Memory access 
3. Control flow
4. System control and others (crypto, floating-point, etc..)

- 31 64-bit registers, labeled `x0-x30`, each with a respective 32-bit form `w0-w30`. The 32-bit form always read the least significant bits.
- Zero register exists
- `x0-x7` - function argument registers
- `x8` 
- `x9-x15` - caller-saved temp. to preserve values across another function call. These are saved in the stack frame of caller, therefore callee can modify.
- `x-29` - frame pointer (fp) to keep track of stack frame
- `x30` - link register - holds the return address of function
- There are also a series of special registers like `PC, SP, WSP, XZR, etc.`

## AArch32
- There's a lot to this, but most importantly the interworking stuff to switch between A32 and T32. Not extremely interested, but reference pg 115 for more..

