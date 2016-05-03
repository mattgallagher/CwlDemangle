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

let splitLines: Array<(input: String, output: String)>
do {
	let input = try String(contentsOfFile: "manglings.txt", encoding: NSUTF8StringEncoding)
	let lines = input.componentsSeparatedByString("\n").filter { !$0.isEmpty }
	splitLines = try lines.map { i -> (String, String) in
		let components = i.componentsSeparatedByString(" ---> ")
		if components.count != 2 {
			enum InputError: ErrorType { case UnableToSplitLine(String) }
			throw InputError.UnableToSplitLine(i)
		}
		return (components[0], components[1])
	}
} catch {
	fatalError("Error reading manglings.txt file: \(error)")
}

for (input, output) in splitLines {
	do {
		let result = try demangleSwiftName(input).description
		if result != output {
			print("Failed to demangle \(input). Got \(result), expected \(output)")
		}
	} catch {
		if input != output {
			print("Failed to demangle \(input). Raised \(error), expected \(output)")
		}
	}
}
