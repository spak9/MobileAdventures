# Part 2 - Understanding arguments with `NativePointer`s

In part 2, I want to quickly discuss viewing function arguments and iron out 
some of the common assumptions I made that ended up being incorrect.
Recall that `NativePointer` is a class that represents our general pointer concept,
therefore a `NativePointer` instance is a variable whose value is a memory address.
You can create an instance of a `NativePointer` like such:

```
var p = new NativePointer(0x12345678)
var pp = ptr(0x12345678)
```

Also recall that for the `onEnter()` callback of the `Interceptor.attach()` function, 
it is given an argument called `args`, which is an array of `NativePointers` wrapping
the function's actual arguments. The subtle difference is that ALL arguments that 
are passed to the original function are wrapped in a `NativePointer`, regardless
if the argument type was a pointer type!
For example, within the `basic_function.c` file, we have:

```
void basic_function(char* input1, int input2, int* input3);
```

Now for `input2`, which is of `int` type, it will still be wrapped in a `NativePointer`,
even though it's not *really* a pointer (address).
Therefore within `onEnter(args)`, `args[1]` will be a `NativePointer` whose value
is whatever `input2` is, but regardless of what it is, it should be *treated* as 
an `int`, not a `int *`. 

Although it seems very straightforward, not knowing this subtle detail would lead 
me to attempt to dereference these `NativePointer` arguments via `readInt()` 
or `readPointer()`, but were really just primitive types, not pointers, leading
to many JavaScript errors!
