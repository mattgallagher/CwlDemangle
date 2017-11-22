# CwlDemangle

A translation of Swift's [Demangle.cpp](https://github.com/apple/swift/blob/master/lib/Basic/Demangle.cpp) into Swift.

## Usage
	
Parse a `String` containing a mangled Swift symbol with the `parseMangledSwiftSymbol` function:

	let swiftSymbol = try parseMangledSwiftSymbol(input)
		
Print the symbol to a string with `description` (to get the `.default` printing options) or use the `print(using:)` function, e.g.:

	let result = swiftSymbol.print(using:
	   SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))

## Article

Read more about this project in the associated article on Cocoa with Love: [Comparing Swift to C++ for parsing](https://www.cocoawithlove.com/blog/2016/05/01/swift-name-demangling.html)
