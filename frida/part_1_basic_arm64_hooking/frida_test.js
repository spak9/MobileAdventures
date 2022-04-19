// A small script to hook into `mystery_function` to change input

// 1. Get hold of `a.out` Module
var a_out = Process.findModuleByName("a.out");
console.log("Found a.out module");
console.log(JSON.stringify(a_out));

// 2. Iterate through symbols and get hold of our "mystery_function"
var mystery_function_addr = 0;
var symbols = a_out.enumerateSymbols();
for (let i = 0; i < symbols.length; i++) {
	if (symbols[i].name == "mystery_function") {
		mystery_function_addr = symbols[i].address;
		break;
	}
}
console.log(`mystery_function() address is: ${mystery_function_addr}`);

// 3. Hook "mystery_function", printing original input and changing it
Interceptor.attach(ptr(mystery_function_addr), {
	onEnter(args){
		console.log("===== Inside mystery_function =====");
		console.log(`The input into mystery_function was: ${args[0].readCString()}`);
		console.log("Changing the input to: get_hacked!");
		args[0].writeUtf8String("get_hacked!");
	}
});
