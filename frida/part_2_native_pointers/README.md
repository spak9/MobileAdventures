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
are passed to the original function are wrapped in a `NativePointer`, therefore
you must dereference it in order to obtain the original argument data type.

