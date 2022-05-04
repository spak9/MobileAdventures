// A small script to see how arguments are wrapped in NativePointers
// within the `onEnter()` callback

// 1. Find Module
var module = Process.findModuleByName("a.out");


// 2. Iterate through symbols and get hold of our "basic_function"
var basic_function = 0;
var symbols = module.enumerateSymbols();
for (let i = 0; i < symbols.length; i++) {
	if (symbols[i].name == "basic_function") {
		basic_function = symbols[i].address;
		break;
	}
}
console.log(`basic_function() address is: ${basic_function}`);


// 3. Intercept the "basic_function" call and examine the NativePointers.
// The point of all of this is to simply confirm that the argument values that were
// passed into `basic_function()` are simply the values of the NativePointers within 
// the `args` list. THEREFORE, even if the argument passed in is not a pointer, 
// it STILL GETS WRAPPED IN A NATIVEPOINTER, therefore you don't dereference it!!
Interceptor.attach(basic_function, {
	onEnter(args) {
		
		// Corresponds to the `char *` pointer, therefore a memory address becomes the 
		// value, in which we need to dereference to get the string 
		console.log(`[+] args[0] is: ${args[0]}`);
		console.log(`[+] args[0].readPointer is: ${args[0].readPointer()}`);
		console.log(`[+] args[0].readCString() is: ${args[0].readCString()}`);
		
		// Corresponds to the `int` - Cannot readPointer/Int() because an `int` was passed in, 
		// we can just read the NativePointer value..
		console.log(`[+] args[1] is: ${args[1]}`);
		
		// Corresponds to the `int *` pointer - memory address is the value and 
		// needs to be dereferenced 
		console.log(`[+] args[2] is: ${args[2]}`);
		console.log(`[+] args[2].readPointer is: ${args[2].readPointer()}`);
		console.log(`[+] args[2].readInt() is: ${args[2].readInt()}`);
		
	}	
});