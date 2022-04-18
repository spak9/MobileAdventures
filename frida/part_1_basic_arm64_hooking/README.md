# Part 1 - Basic Function Hooking

For basic interception of calls to X function, we'll need to use the 
`Interceptor` object and its API.
The main function we'll be using is:
`Interceptor.attach(target, callbacks[, data])`,
where `target` is a `NativePointer` and `callbacks`. We will revisit
this function and its usage, but exactly do we get to this point? 

I like to think of the `Module` object as a object representing a 
some type of shared object/executable (from the ELF perspective). 
There are 2 main ways I like to get hold of `Module` objects:
1. `Process.enumerateModules()` which returns an array of `Module` objects
that are loaded in the process.
2. `Process.findModuleByName/Address(name_or_address)` which returns a
`Module` instance or null if not available. 
`Module`s have attributes like `name`, `size (bytes)`, and most importantly,
the `address`, which is a `NativePointer` of the base address of the module.
EX:
```
[Local::extern_out ]-> extern_out
{
    "base": "0x5577880000",
    "name": "extern_out",
    "path": "/home/steven/Desktop/code/C/extern_out",
    "size": 73728
}
```

`Module` objects have a few important functions for finding important
information within the executable itself.
1. `Module.enumerateImports/Exports/Symbols()` - returns an array of 
the specified data objects from the Module, all of which contain an 
`address` field. This can then tell us external 
functions/variables and other symbols (if not stripped) and their addresses 
in memory, in which we can then hook into! 
Coming full circle, you examine the `Module` you're interested,
then attempt to find the symbol/export's address (NativePointer). We
can then pass that into `Interceptor.attach(target, ..)`.
