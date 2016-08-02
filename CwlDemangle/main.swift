//
//  main.swift
//  CwlDemangle
//
//  Created by Matt Gallagher on 2016/04/30.
//  Copyright © 2016 Matt Gallagher. All rights reserved.
//
//  Licensed under Apache License v2.0 with Runtime Library Exception
//
//  See http://swift.org/LICENSE.txt for license information
//  See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

import Foundation

let splitLines: Array<(input: Array<UnicodeScalar>, output: String)>
do {
	let input = try String(contentsOfFile: "manglings.txt", encoding: String.Encoding.utf8)
	let lines = input.components(separatedBy: "\n").filter { !$0.isEmpty }
	splitLines = try lines.map { i -> (Array<UnicodeScalar>, String) in
		let components = i.components(separatedBy: " ---> ")
		if components.count != 2 {
			enum InputError: Error { case unableToSplitLine(String) }
			throw InputError.unableToSplitLine(i)
		}
		return (Array(components[0].unicodeScalars), components[1])
	}
} catch {
	fatalError("Error reading manglings.txt file: \(error)")
}

for (input, output) in splitLines {
#if !PERFORMANCE_TEST
	do {
		let result = try demangleSwiftName(input).description
		if result != output {
			print("Failed to demangle \(input). Got \(result), expected \(output)")
		}
	} catch {
		var s = String()
		s.unicodeScalars.append(contentsOf: input)
		if s != output {
			print("Failed to demangle \(input). Raised \(error), expected \(output)")
		}
	}
#else
	for _ in 0..<10000 {
		_ = try? demangleSwiftName(input).description
	}
#endif
}
