//
//  CwlDemangle.swift
//
//  Created by Matt Gallagher on 11/10/2015.
//  Copyright © 2015 Matt Gallagher ( http://cocoawithlove.com ). All rights reserved.
//
//  This file is derived from Demangle.cpp
//		https://github.com/apple/swift/blob/master/lib/Basic/Demangle.cpp
//
//  Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
//  Licensed under Apache License v2.0 with Runtime Library Exception
//
//  See http://swift.org/LICENSE.txt for license information
//  See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

import Swift

public func demangleSwiftName(_ mangled: String) throws -> SwiftName {
	return try demangleSwiftName(Array<UnicodeScalar>(mangled.unicodeScalars))
}

public func demangleSwiftName(_ mangled: Array<UnicodeScalar>) throws -> SwiftName {
	var nameRefs = [SwiftName]()
	var scanner = ScalarScanner(scalars: mangled)
	
	try scanner.match(string: "_T")
	var children = [SwiftName]()
	
	switch (try scanner.readScalar(), try scanner.readScalar()) {
	case ("T", "S"):
		repeat {
			children.append(try demangleSpecializedAttribute(&scanner, &nameRefs))
			nameRefs.removeAll()
		} while scanner.conditional(string: "_TTS")
		try scanner.match(string: "_T")
	case ("T", "o"): children.append(SwiftName(kind: .objCAttribute))
	case ("T", "O"): children.append(SwiftName(kind: .nonObjCAttribute))
	case ("T", "D"): children.append(SwiftName(kind: .dynamicAttribute))
	case ("T", "d"): children.append(SwiftName(kind: .directMethodReferenceAttribute))
	case ("T", "v"): children.append(SwiftName(kind: .vTableAttribute))
	default: try scanner.backtrack(count: 2)
	}

	children.append(try demangleGlobal(&scanner, &nameRefs))
	
	let remainder = scanner.remainder()
	if !remainder.isEmpty {
		children.append(SwiftName(kind: .suffix, contents: .name(remainder)))
	}
	
	return SwiftName(kind: .global, children: children)
}

private func demangleGlobal<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let c1 = try scanner.readScalar()
	let c2 = try scanner.readScalar()
	switch (c1, c2) {
	case ("M", "P"): return SwiftName(kind: .genericTypeMetadataPattern, children: [try demangleType(&scanner, &nameRefs)])
	case ("M", "a"): return SwiftName(kind: .typeMetadataAccessFunction, children: [try demangleType(&scanner, &nameRefs)])
	case ("M", "L"): return SwiftName(kind: .typeMetadataLazyCache, children: [try demangleType(&scanner, &nameRefs)])
	case ("M", "m"): return SwiftName(kind: .metaclass, children: [try demangleType(&scanner, &nameRefs)])
	case ("M", "n"): return SwiftName(kind: .nominalTypeDescriptor, children: [try demangleType(&scanner, &nameRefs)])
	case ("M", "f"): return SwiftName(kind: .fullTypeMetadata, children: [try demangleType(&scanner, &nameRefs)])
	case ("M", "p"): return SwiftName(kind: .protocolDescriptor, children: [try demangleProtocolName(&scanner, &nameRefs)])
	case ("M", _):
		try scanner.backtrack()
		return SwiftName(kind: .typeMetadata, children: [try demangleType(&scanner, &nameRefs)])
	case ("P", "A"):
		return SwiftName(kind: scanner.conditional(scalar: "o") ? .partialApplyObjCForwarder : .partialApplyForwarder, children: scanner.conditional(string: "__T") ? [try demangleGlobal(&scanner, &nameRefs)] : [])
	case ("P", _): throw scanner.unexpectedError()
	case ("t", _):
		try scanner.backtrack()
		return SwiftName(kind: .typeMangling, children: [try demangleType(&scanner, &nameRefs)])
	case ("w", _):
		let c3 = try scanner.readScalar()
		let value: UInt32
		switch (c2, c3) {
		case ("a", "l"): value = ValueWitnessKind.allocateBuffer.rawValue
		case ("c", "a"): value = ValueWitnessKind.assignWithCopy.rawValue
		case ("t", "a"): value = ValueWitnessKind.assignWithTake.rawValue
		case ("d", "e"): value = ValueWitnessKind.deallocateBuffer.rawValue
		case ("x", "x"): value = ValueWitnessKind.destroy.rawValue
		case ("X", "X"): value = ValueWitnessKind.destroyBuffer.rawValue
		case ("C", "P"): value = ValueWitnessKind.initializeBufferWithCopyOfBuffer.rawValue
		case ("C", "p"): value = ValueWitnessKind.initializeBufferWithCopy.rawValue
		case ("c", "p"): value = ValueWitnessKind.initializeWithCopy.rawValue
		case ("C", "c"): value = ValueWitnessKind.initializeArrayWithCopy.rawValue
		case ("T", "K"): value = ValueWitnessKind.initializeBufferWithTakeOfBuffer.rawValue
		case ("T", "k"): value = ValueWitnessKind.initializeBufferWithTake.rawValue
		case ("t", "k"): value = ValueWitnessKind.initializeWithTake.rawValue
		case ("T", "t"): value = ValueWitnessKind.initializeArrayWithTakeFrontToBack.rawValue
		case ("t", "T"): value = ValueWitnessKind.initializeArrayWithTakeBackToFront.rawValue
		case ("p", "r"): value = ValueWitnessKind.projectBuffer.rawValue
		case ("X", "x"): value = ValueWitnessKind.destroyArray.rawValue
		case ("x", "s"): value = ValueWitnessKind.storeExtraInhabitant.rawValue
		case ("x", "g"): value = ValueWitnessKind.getExtraInhabitantIndex.rawValue
		case ("u", "g"): value = ValueWitnessKind.getEnumTag.rawValue
		case ("u", "p"): value = ValueWitnessKind.destructiveProjectEnumData.rawValue
		default: throw scanner.unexpectedError()
		}
		return SwiftName(kind: .valueWitness, children: [try demangleType(&scanner, &nameRefs)], contents: .index(value))
	case ("W", "V"): return SwiftName(kind: .valueWitnessTable, children: [try demangleType(&scanner, &nameRefs)])
	case ("W", "o"): return SwiftName(kind: .witnessTableOffset, children: [try demangleEntity(&scanner, &nameRefs)])
	case ("W", "v"): return SwiftName(kind: .fieldOffset, children: [SwiftName(kind: .directness, contents: .index(try scanner.readScalar() == "d" ? 0 : 1)), try demangleEntity(&scanner, &nameRefs)])
	case ("W", "P"): return SwiftName(kind: .protocolWitnessTable, children: [try demangleProtocolConformance(&scanner, &nameRefs)])
	case ("W", "G"): return SwiftName(kind: .genericProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner, &nameRefs)])
	case ("W", "I"): return SwiftName(kind: .genericProtocolWitnessTableInstantiationFunction, children: [try demangleProtocolConformance(&scanner, &nameRefs)])
	case ("W", "l"): return SwiftName(kind: .lazyProtocolWitnessTableAccessor, children: [try demangleType(&scanner, &nameRefs), try demangleProtocolConformance(&scanner, &nameRefs)])
	case ("W", "L"): return SwiftName(kind: .lazyProtocolWitnessTableCacheVariable, children: [try demangleType(&scanner, &nameRefs), try demangleProtocolConformance(&scanner, &nameRefs)])
	case ("W", "a"): return SwiftName(kind: .protocolWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner, &nameRefs)])
	case ("W", "t"): return SwiftName(kind: .associatedTypeMetadataAccessor, children: [try demangleProtocolConformance(&scanner, &nameRefs), try demangleDeclName(&scanner, &nameRefs)])
	case ("W", "T"): return SwiftName(kind: .associatedTypeWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner, &nameRefs), try demangleDeclName(&scanner, &nameRefs), try demangleProtocolName(&scanner, &nameRefs)])
	case ("W", _): throw scanner.unexpectedError()
	case ("T","W"): return SwiftName(kind: .protocolWitness, children: [try demangleProtocolConformance(&scanner, &nameRefs), try demangleEntity(&scanner, &nameRefs)])
	case ("T", "R"): fallthrough
	case ("T", "r"): return SwiftName(kind: c2 == "R" ? SwiftName.Kind.reabstractionThunkHelper : SwiftName.Kind.reabstractionThunk, children: scanner.conditional(scalar: "G") ? [try demangleGenericSignature(&scanner, &nameRefs), try demangleType(&scanner, &nameRefs), try demangleType(&scanner, &nameRefs)] : [try demangleType(&scanner, &nameRefs), try demangleType(&scanner, &nameRefs)])
	default:
		try scanner.backtrack(count: 2)
		return try demangleEntity(&scanner, &nameRefs)
	}
}

private func demangleSpecializedAttribute<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let c = try scanner.readScalar()
	var children = [SwiftName]()
	if scanner.conditional(scalar: "q") {
		children.append(SwiftName(kind: .specializationIsFragile))
	}
	children.append(SwiftName(kind: .specializationPassID, contents: .index(try scanner.readScalar().value - 48)))
	switch c {
	case "r": fallthrough
	case "g":
		while !scanner.conditional(scalar: "_") {
			var parameterChildren = [SwiftName]()
			parameterChildren.append(try demangleType(&scanner, &nameRefs))
			while !scanner.conditional(scalar: "_") {
				parameterChildren.append(try demangleProtocolConformance(&scanner, &nameRefs))
			}
			children.append(SwiftName(kind: .genericSpecializationParam, children: parameterChildren))
		}
		return SwiftName(kind: c == "r" ? .genericSpecializationNotReAbstracted : .genericSpecialization, children: children)
	case "f":
		var count: UInt32 = 0
		while !scanner.conditional(scalar: "_") {
			var paramChildren = [SwiftName]()
			let c = try scanner.readScalar()
			switch (c, try scanner.readScalar()) {
			case ("n", "_"): break
			case ("c", "p"): paramChildren.append(contentsOf: try demangleFuncSigSpecializationConstantProp(&scanner, &nameRefs))
			case ("c", "l"):
				paramChildren.append(SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(FunctionSigSpecializationParamKind.closureProp.rawValue)))
				paramChildren.append(SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner, &nameRefs).contents))
				while !scanner.conditional(scalar: "_") {
					paramChildren.append(try demangleType(&scanner, &nameRefs))
				}
			case ("i", "_"): fallthrough
			case ("k", "_"): paramChildren.append(SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(c == "i" ? FunctionSigSpecializationParamKind.boxToValue.rawValue : FunctionSigSpecializationParamKind.boxToStack.rawValue)))
			default:
				try scanner.backtrack(count: 2)
				var value: UInt32 = 0
				value |= scanner.conditional(scalar: "d") ? FunctionSigSpecializationParamKind.dead.rawValue : 0
				value |= scanner.conditional(scalar: "g") ? FunctionSigSpecializationParamKind.ownedToGuaranteed.rawValue : 0
				value |= scanner.conditional(scalar: "s") ? FunctionSigSpecializationParamKind.sroa.rawValue : 0
				try scanner.match(scalar: "_")
				paramChildren.append(SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(value)))
			}
			children.append(SwiftName(kind: .functionSignatureSpecializationParam, children: paramChildren, contents: .index(count)))
			count += 1
		}
		return SwiftName(kind: .functionSignatureSpecialization, children: children)
	default: throw scanner.unexpectedError()
	}
}

private func demangleFuncSigSpecializationConstantProp<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> [SwiftName] {
	switch (try scanner.readScalar(), try scanner.readScalar()) {
	case ("f", "r"):
		let name = SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner, &nameRefs).contents)
		try scanner.match(scalar: "_")
		let kind = SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(FunctionSigSpecializationParamKind.constantPropFunction.rawValue))
		return [kind, name]
	case ("g", _):
		try scanner.backtrack()
		let name = SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner, &nameRefs).contents)
		try scanner.match(scalar: "_")
		let kind = SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(FunctionSigSpecializationParamKind.constantPropGlobal.rawValue))
		return [kind, name]
	case ("i", _):
		try scanner.backtrack()
		let string = try scanner.readUntil(scalar: "_")
		try scanner.match(scalar: "_")
		let name = SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: .name(string))
		let kind = SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(FunctionSigSpecializationParamKind.constantPropInteger.rawValue))
		return [kind, name]
	case ("f", "l"):
		let string = try scanner.readUntil(scalar: "_")
		try scanner.match(scalar: "_")
		let name = SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: .name(string))
		let kind = SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(FunctionSigSpecializationParamKind.constantPropFloat.rawValue))
		return [kind, name]
	case ("s", "e"):
		var string: String
		switch try scanner.readScalar() {
		case "0": string = "u8"
		case "1": string = "u16"
		default: throw scanner.unexpectedError()
		}
		try scanner.match(scalar: "v")
		let name = SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner, &nameRefs).contents)
		let encoding = SwiftName(kind: .functionSignatureSpecializationParamPayload, contents: .name(string))
		let kind = SwiftName(kind: .functionSignatureSpecializationParamKind, contents: .index(FunctionSigSpecializationParamKind.constantPropString.rawValue))
		try scanner.match(scalar: "_")
		return [kind, encoding, name]
	default: throw scanner.unexpectedError()
	}
}


private func demangleProtocolConformance<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let type = try demangleType(&scanner, &nameRefs)
	let prot = try demangleProtocolName(&scanner, &nameRefs)
	let context = try demangleContext(&scanner, &nameRefs)
	return SwiftName(kind: .protocolConformance, children: [type, prot, context])
}

private func demangleProtocolName<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let name: SwiftName
	if scanner.conditional(scalar: "S") {
		let index = try demangleSubstitutionIndex(&scanner, &nameRefs)
		switch index.kind {
		case .protocol: name = index
		case .module: name = try demangleProtocolNameGivenContext(&scanner, &nameRefs, context: index)
		default: throw scanner.unexpectedError()
		}
	} else if scanner.conditional(scalar: "s") {
		let stdlib = SwiftName(kind: .module, contents: .name(stdlibName))
		name = try demangleProtocolNameGivenContext(&scanner, &nameRefs, context: stdlib)
	} else {
		name = try demangleDeclarationName(&scanner, &nameRefs, kind: .protocol)
	}

	return SwiftName(kind: .type, children: [name])
}

private func demangleProtocolNameGivenContext<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], context: SwiftName) throws -> SwiftName {
	let name = try demangleDeclName(&scanner, &nameRefs)
	let result = SwiftName(kind: .protocol, children: [context, name])
	nameRefs.append(result)
	return result
}

private func demangleEntity<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let isStatic = scanner.conditional(scalar: "Z")
	
	let basicKind: SwiftName.Kind
	switch try scanner.readScalar() {
	case "F": basicKind = .function
	case "v": basicKind = .variable
	case "I": basicKind = .initializer
	case "i": basicKind = .subscript
	case "S": return try demangleSubstitutionIndex(&scanner, &nameRefs)
	case "V": return try demangleDeclarationName(&scanner, &nameRefs, kind: .structure)
	case "O": return try demangleDeclarationName(&scanner, &nameRefs, kind: .enum)
	case "C": return try demangleDeclarationName(&scanner, &nameRefs, kind: .class)
	case "P": return try demangleDeclarationName(&scanner, &nameRefs, kind: .protocol)
	default: throw scanner.unexpectedError()
	}
	
	let context = try demangleContext(&scanner, &nameRefs)
	let kind: SwiftName.Kind
	let hasType: Bool
	var name: SwiftName? = nil
	
	let c = try scanner.readScalar()
	switch c {
	case "D": (kind, hasType) = (.deallocator, false)
	case "d": (kind, hasType) = (.destructor, false)
	case "e": (kind, hasType) = (.iVarInitializer, false)
	case "E": (kind, hasType) = (.iVarDestroyer, false)
	case "C": (kind, hasType) = (.allocator, true)
	case "c": (kind, hasType) = (.constructor, true)
	case "a": fallthrough
	case "l":
		switch try scanner.readScalar() {
		case "O": (kind, hasType, name) = (c == "a" ? .owningMutableAddressor : .owningAddressor, true, try demangleDeclName(&scanner, &nameRefs))
		case "o": (kind, hasType, name) = (c == "a" ? .nativeOwningMutableAddressor : .nativeOwningAddressor, true, try demangleDeclName(&scanner, &nameRefs))
		case "p": (kind, hasType, name) = (c == "a" ? .nativePinningMutableAddressor : .nativePinningAddressor, true, try demangleDeclName(&scanner, &nameRefs))
		case "u": (kind, hasType, name) = (c == "a" ? .unsafeMutableAddressor : .unsafeAddressor, true, try demangleDeclName(&scanner, &nameRefs))
		default: throw scanner.unexpectedError()
		}
	case "g": (kind, hasType, name) = (.getter, true, try demangleDeclName(&scanner, &nameRefs))
	case "G": (kind, hasType, name) = (.globalGetter, true, try demangleDeclName(&scanner, &nameRefs))
	case "s": (kind, hasType, name) = (.setter, true, try demangleDeclName(&scanner, &nameRefs))
	case "m": (kind, hasType, name) = (.materializeForSet, true, try demangleDeclName(&scanner, &nameRefs))
	case "w": (kind, hasType, name) = (.willSet, true, try demangleDeclName(&scanner, &nameRefs))
	case "W": (kind, hasType, name) = (.didSet, true, try demangleDeclName(&scanner, &nameRefs))
	case "U": (kind, hasType, name) = (.explicitClosure, true, SwiftName(kind: .number, contents: .index(try demangleIndex(&scanner, &nameRefs))))
	case "u": (kind, hasType, name) = (.implicitClosure, true, SwiftName(kind: .number, contents: .index(try demangleIndex(&scanner, &nameRefs))))
	case "A" where basicKind == .initializer: (kind, hasType, name) = (.defaultArgumentInitializer, false, SwiftName(kind: .number, contents: .index(try demangleIndex(&scanner, &nameRefs))))
	case "i" where basicKind == .initializer: (kind, hasType) = (.initializer, false)
	case _ where basicKind == .initializer: throw scanner.unexpectedError()
	default:
		try scanner.backtrack()
		(kind, hasType, name) = (basicKind, true, try demangleDeclName(&scanner, &nameRefs))
	}
	
	var children = [context]
	if let n = name {
		children.append(n)
	}
	if hasType {
		children.append(try demangleType(&scanner, &nameRefs))
	}
	let entity = SwiftName(kind: kind, children: children)
	return isStatic ? SwiftName(kind: .static, children: [entity]) : entity
}

private func demangleDeclarationName<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], kind: SwiftName.Kind) throws -> SwiftName {
	let result = SwiftName(kind: kind, children: [try demangleContext(&scanner, &nameRefs), try demangleDeclName(&scanner, &nameRefs)])
	nameRefs.append(result)
	return result
}

private func demangleContext<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "E": return SwiftName(kind: .extension, children: [try demangleModule(&scanner, &nameRefs), try demangleContext(&scanner, &nameRefs)])
	case "e":
		let module = try demangleModule(&scanner, &nameRefs)
		let signature = try demangleGenericSignature(&scanner, &nameRefs)
		let type = try demangleContext(&scanner, &nameRefs)
		return SwiftName(kind: .extension, children: [module, type, signature])
	case "S": return try demangleSubstitutionIndex(&scanner, &nameRefs)
	case "s": return SwiftName(kind: .module, children: [], contents: .name(stdlibName))
	case "F": fallthrough
	case "I": fallthrough
	case "v": fallthrough
	case "P": fallthrough
	case "s": fallthrough
	case "Z": fallthrough
	case "C": fallthrough
	case "V": fallthrough
	case "O":
		try scanner.backtrack()
		return try demangleEntity(&scanner, &nameRefs)
	default:
		try scanner.backtrack()
		return try demangleModule(&scanner, &nameRefs)
	}
}

private func demangleModule<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "S": return try demangleSubstitutionIndex(&scanner, &nameRefs)
	case "s": return SwiftName(kind: .module, children: [], contents: .name("Swift"))
	default:
		try scanner.backtrack()
		let module = try demangleIdentifier(&scanner, &nameRefs, kind: .module)
		nameRefs.append(module)
		return module
	}
}

private func swiftStdLibType(_ kind: SwiftName.Kind, named: String) -> SwiftName {
	return SwiftName(kind: kind, children: [SwiftName(kind: .module, contents: .name(stdlibName)), SwiftName(kind: .identifier, contents: .name(named))])
}

private func demangleSubstitutionIndex<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "o": return SwiftName(kind: .module, contents: .name(objcModule))
	case "C": return SwiftName(kind: .module, contents: .name(cModule))
	case "a": return swiftStdLibType(.structure, named: "Array")
	case "b": return swiftStdLibType(.structure, named: "Bool")
	case "c": return swiftStdLibType(.structure, named: "UnicodeScalar")
	case "d": return swiftStdLibType(.structure, named: "Double")
	case "f": return swiftStdLibType(.structure, named: "Float")
	case "i": return swiftStdLibType(.structure, named: "Int")
	case "P": return swiftStdLibType(.structure, named: "UnsafePointer")
	case "p": return swiftStdLibType(.structure, named: "UnsafeMutablePointer")
	case "q": return swiftStdLibType(.enum, named: "Optional")
	case "Q": return swiftStdLibType(.enum, named: "ImplicitlyUnwrappedOptional")
	case "R": return swiftStdLibType(.structure, named: "UnsafeBufferPointer")
	case "r": return swiftStdLibType(.structure, named: "UnsafeMutableBufferPointer")
	case "S": return swiftStdLibType(.structure, named: "String")
	case "u": return swiftStdLibType(.structure, named: "UInt")
	default:
		try scanner.backtrack()
		let index = try demangleIndex(&scanner, &nameRefs)
		if Int(index) >= nameRefs.count {
			throw scanner.unexpectedError()
		}
		return nameRefs[Int(index)]
	}
}

private func demangleGenericSignature<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	var children = [SwiftName]()
	var c = try scanner.requirePeek()
	while c != "R" && c != "r" {
		children.append(SwiftName(kind: .dependentGenericParamCount, contents: .index(scanner.conditional(scalar: "z") ? 0 : (try demangleIndex(&scanner, &nameRefs) + 1))))
		c = try scanner.requirePeek()
	}
	if children.isEmpty {
		children.append(SwiftName(kind: .dependentGenericParamCount, contents: .index(1)))
	}
	if !scanner.conditional(scalar: "r") {
		try scanner.match(scalar: "R")
		while !scanner.conditional(scalar: "r") {
			children.append(try demangleGenericRequirement(&scanner, &nameRefs))
		}
	}
	return SwiftName(kind: .dependentGenericSignature, children: children)
}

private func demangleGenericRequirement<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let constrainedType = try demangleConstrainedType(&scanner, &nameRefs)
	if scanner.conditional(scalar: "z") {
		return SwiftName(kind: .dependentGenericSameTypeRequirement, children: [constrainedType, try demangleType(&scanner, &nameRefs)])
	}
	let c = try scanner.requirePeek()
	let constraint: SwiftName
	if c == "C" {
		constraint = try demangleType(&scanner, &nameRefs)
	} else if c == "S" {
		try scanner.match(scalar: "S")
		let index = try demangleSubstitutionIndex(&scanner, &nameRefs)
		let typename: SwiftName
		switch index.kind {
		case .protocol: fallthrough
		case .class: typename = index
		case .module: typename = try demangleProtocolNameGivenContext(&scanner, &nameRefs, context: index)
		default: throw scanner.unexpectedError()
		}
		constraint = SwiftName(kind: .type, children: [typename])
	} else {
		constraint = try demangleProtocolName(&scanner, &nameRefs)
	}
	return SwiftName(kind: .dependentGenericConformanceRequirement, children: [constrainedType, constraint])
}

private func demangleConstrainedType<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	if scanner.conditional(scalar: "w") {
		return try demangleAssociatedTypeSimple(&scanner, &nameRefs)
	} else if scanner.conditional(scalar: "W") {
		return try demangleAssociatedTypeCompound(&scanner, &nameRefs)
	}
	return try demangleGenericParamIndex(&scanner, &nameRefs)
}

private func demangleAssociatedTypeSimple<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let base = try demangleGenericParamIndex(&scanner, &nameRefs)
	return try demangleDependentMemberTypeName(&scanner, &nameRefs, base: SwiftName(kind: .type, children: [base]))
}

private func demangleAssociatedTypeCompound<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	var base = try demangleGenericParamIndex(&scanner, &nameRefs)
	while !scanner.conditional(scalar: "_") {
		let type = SwiftName(kind: .type, children: [base])
		base = try demangleDependentMemberTypeName(&scanner, &nameRefs, base: type)
	}
	return base
}

private func demangleGenericParamIndex<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let depth: UInt32
	let index: UInt32
	switch try scanner.readScalar() {
	case "d": (depth, index) = (try demangleIndex(&scanner, &nameRefs) + 1, try demangleIndex(&scanner, &nameRefs))
	case "x": (depth, index) = (0, 0)
	default:
		try scanner.backtrack()
		(depth, index) = (0, try demangleIndex(&scanner, &nameRefs) + 1)
	}
	return SwiftName(kind: .dependentGenericParamType, children: [SwiftName(kind: .index, contents: .index(depth)), SwiftName(kind: .index, contents: .index(index))], contents: .name(archetypeName(index, depth)))
}

private func demangleDependentMemberTypeName<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], base: SwiftName) throws -> SwiftName {
	let associatedType: SwiftName
	if scanner.conditional(scalar: "S") {
		associatedType = try demangleSubstitutionIndex(&scanner, &nameRefs)
	} else {
		var prot: SwiftName? = nil
		if scanner.conditional(scalar: "P") {
			prot = try demangleProtocolName(&scanner, &nameRefs)
		}
		let at = try demangleIdentifier(&scanner, &nameRefs, kind: .dependentAssociatedTypeRef)
		if let p = prot {
			var children = at.children
			children.append(p)
			associatedType = SwiftName(kind: at.kind, children: children, contents: at.contents)
		} else {
			associatedType = at
		}
		nameRefs.append(associatedType)
	}
	
	return SwiftName(kind: .dependentMemberType, children: [base, associatedType])
}

private func demangleDeclName<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "L": return SwiftName(kind: .localDeclName, children: [SwiftName(kind: .number, contents: .index(try demangleIndex(&scanner, &nameRefs))), try demangleIdentifier(&scanner, &nameRefs)])
	case "P": return SwiftName(kind: .privateDeclName, children: [try demangleIdentifier(&scanner, &nameRefs), try demangleIdentifier(&scanner, &nameRefs)])
	default:
		try scanner.backtrack()
		return try demangleIdentifier(&scanner, &nameRefs)
	}
}

private func demangleIndex<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> UInt32 {
	if scanner.conditional(scalar: "_") {
		return 0
	}
	let value = UInt32(try scanner.readInt()) + 1
	try scanner.match(scalar: "_")
	return value
}

private func demangleType<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	let type: SwiftName
	switch try scanner.readScalar() {
	case "B":
		switch try scanner.readScalar() {
		case "b": type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.BridgeObject"))
		case "B": type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.UnsafeValueBuffer"))
		case "f":
			let size = try scanner.readInt()
			try scanner.match(scalar: "_")
			type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.Float\(size)"))
		case "i":
			let size = try scanner.readInt()
			try scanner.match(scalar: "_")
			type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.Int\(size)"))
		case "v":
			let elements = try scanner.readInt()
			try scanner.match(scalar: "B")
			let name: String
			let size: String
			let c = try scanner.readScalar()
			switch c {
			case "p": (name, size) = ("xRawPointer", "")
			case "i": fallthrough
			case "f":
				(name, size) = (c == "i" ? "xInt" : "xFloat", try "\(scanner.readInt())")
				try scanner.match(scalar: "_")
			default: throw scanner.unexpectedError()
			}
			type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.Vec\(elements)\(name)\(size)"))
		case "O": type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.UnknownObject"))
		case "o": type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.NativeObject"))
		case "p": type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.RawPointer"))
		case "w": type = SwiftName(kind: .builtinTypeName, contents: .name("Builtin.Word"))
		default: throw scanner.unexpectedError()
		}
	case "a": type = try demangleDeclarationName(&scanner, &nameRefs, kind: .typeAlias)
	case "b": type = try demangleFunctionType(&scanner, &nameRefs, kind: .objCBlock)
	case "c": type = try demangleFunctionType(&scanner, &nameRefs, kind: .cFunctionPointer)
	case "D": type = SwiftName(kind: .dynamicSelf, children: [try demangleType(&scanner, &nameRefs)])
	case "E":
		guard try scanner.readScalars(count: 2) == "RR" else { throw scanner.unexpectedError() }
		type = SwiftName(kind: .errorType, children: [], contents: .name(""))
	case "F": type = try demangleFunctionType(&scanner, &nameRefs, kind: .functionType)
	case "f": type = try demangleFunctionType(&scanner, &nameRefs, kind: .uncurriedFunctionType)
	case "G":
		let unboundType = try demangleType(&scanner, &nameRefs)
		var children = [SwiftName]()
		while !scanner.conditional(scalar: "_") {
			children.append(try demangleType(&scanner, &nameRefs))
		}
		let kind: SwiftName.Kind
		switch unboundType.children.first?.kind {
		case .some(.class): kind = .boundGenericClass
		case .some(.structure): kind = .boundGenericStructure
		case .some(.enum): kind = .boundGenericEnum
		default: throw scanner.unexpectedError()
		}
		type = SwiftName(kind: kind, children: [unboundType, SwiftName(kind: .typeList, children: children)])
	case "X":
		let c = try scanner.readScalar()
		switch c {
		case "b": type = SwiftName(kind: .silBoxType, children: [try demangleType(&scanner, &nameRefs)])
		case "P" where scanner.conditional(scalar: "M"): fallthrough
		case "M":
			let value: String
			switch try scanner.readScalar() {
			case "t": value = "@thick"
			case "T": value = "@thin"
			case "o": value = "@objc_metatype"
			default: throw scanner.unexpectedError()
			}
			type = SwiftName(kind: c == "P" ? .existentialMetatype : .metatype, children: [SwiftName(kind: .metatypeRepresentation, contents: .name(value)), try demangleType(&scanner, &nameRefs)])
		case "P":
			var children = [SwiftName]()
			while !scanner.conditional(scalar: "_") {
				children.append(try demangleProtocolName(&scanner, &nameRefs))
			}
			type = SwiftName(kind: .protocolList, children: [SwiftName(kind: .typeList)])
		case "f": type = try demangleFunctionType(&scanner, &nameRefs, kind: .thinFunctionType)
		case "o": type = SwiftName(kind: .unowned, children: [try demangleType(&scanner, &nameRefs)])
		case "u": type = SwiftName(kind: .unmanaged, children: [try demangleType(&scanner, &nameRefs)])
		case "w": type = SwiftName(kind: .weak, children: [try demangleType(&scanner, &nameRefs)])
		case "F":
			var children = [SwiftName]()
			children.append(SwiftName(kind: .implConvention, contents: .name(try demangleImplConvention(&scanner, &nameRefs, kind: .implConvention))))
			if scanner.conditional(scalar: "C") {
				let name: String
				switch try scanner.readScalar() {
				case "b": name = "@convention(block)"
				case "c": name = "@convention(c)"
				case "m": name = "@convention(method)"
				case "O": name = "@convention(objc_method)"
				case "w": name = "@convention(witness_method)"
				default: throw scanner.unexpectedError()
				}
				children.append(SwiftName(kind: .implFunctionAttribute, contents: .name(name)))
			}
			if scanner.conditional(scalar: "N") {
				children.append(SwiftName(kind: .implFunctionAttribute, contents: .name("@noreturn")))
			}
			if scanner.conditional(scalar: "G") {
				children.append(try demangleGenericSignature(&scanner, &nameRefs))
			}
			try scanner.match(scalar: "_")
			while !scanner.conditional(scalar: "_") {
				children.append(try demangleImplParameterOrResult(&scanner, &nameRefs, kind: .implParameter))
			}
			while !scanner.conditional(scalar: "_") {
				children.append(try demangleImplParameterOrResult(&scanner, &nameRefs, kind: .implResult))
			}
			type = SwiftName(kind: .implFunctionType, children: children)
		default: throw scanner.unexpectedError()
		}
	case "K": type = try demangleFunctionType(&scanner, &nameRefs, kind: .autoClosureType)
	case "M": type = SwiftName(kind: .metatype, children: [try demangleType(&scanner, &nameRefs)])
	case "P" where scanner.conditional(scalar: "M"): type = SwiftName(kind: .existentialMetatype, children: [try demangleType(&scanner, &nameRefs)])
	case "P":
		var children = [SwiftName]()
		while !scanner.conditional(scalar: "_") {
			children.append(try demangleProtocolName(&scanner, &nameRefs))
		}
		type = SwiftName(kind: .protocolList, children: [SwiftName(kind: .typeList, children: children)])
	case "Q": type = try demangleArchetypeType(&scanner, &nameRefs)
	case "q":
		let c = try scanner.requirePeek()
		if c != "d" && c != "_" && c < "0" && c > "9" {
			type = try demangleDependentMemberTypeName(&scanner, &nameRefs, base: demangleType(&scanner, &nameRefs))
		} else {
			type = try demangleGenericParamIndex(&scanner, &nameRefs)
		}
	case "x": type = SwiftName(kind: .dependentGenericParamType, children: [SwiftName(kind: .index, contents: .index(0)), SwiftName(kind: .index, contents: .index(0))], contents: .name(archetypeName(0, 0)))
	case "w": type = try demangleAssociatedTypeSimple(&scanner, &nameRefs)
	case "W": type = try demangleAssociatedTypeCompound(&scanner, &nameRefs)
	case "R": type = SwiftName(kind: .inOut, children: try demangleType(&scanner, &nameRefs).children)
	case "S": type = try demangleSubstitutionIndex(&scanner, &nameRefs)
	case "T": type = try demangleTuple(&scanner, &nameRefs, variadic: false)
	case "t": type = try demangleTuple(&scanner, &nameRefs, variadic: true)
	case "u": type = SwiftName(kind: .dependentGenericType, children: [try demangleGenericSignature(&scanner, &nameRefs), try demangleType(&scanner, &nameRefs)])
	case "C": type = try demangleDeclarationName(&scanner, &nameRefs, kind: .class)
	case "V": type = try demangleDeclarationName(&scanner, &nameRefs, kind: .structure)
	case "O": type = try demangleDeclarationName(&scanner, &nameRefs, kind: .enum)
	default: throw scanner.unexpectedError()
	}
	return SwiftName(kind: .type, children: [type])
}

private func demangleArchetypeType<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName]) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "P": return SwiftName(kind: .selfTypeRef, children: [try demangleProtocolName(&scanner, &nameRefs)])
	case "Q":
		let result = SwiftName(kind: .associatedTypeRef, children: [try demangleArchetypeType(&scanner, &nameRefs), try demangleIdentifier(&scanner, &nameRefs)])
		nameRefs.append(result)
		return result
	case "S":
		let index = try demangleSubstitutionIndex(&scanner, &nameRefs)
		if case .protocol = index.kind {
			return SwiftName(kind: .selfTypeRef, children: [index])
		} else {
			let result = SwiftName(kind: .associatedTypeRef, children: [index, try demangleIdentifier(&scanner, &nameRefs)])
			nameRefs.append(result)
			return result
		}
	case "s":
		let root = SwiftName(kind: .module, contents: .name(stdlibName))
		let result = SwiftName(kind: .associatedTypeRef, children: [root, try demangleIdentifier(&scanner, &nameRefs)])
		nameRefs.append(result)
		return result
	case "d":
		let depth = try demangleIndex(&scanner, &nameRefs) + 1
		let index = try demangleIndex(&scanner, &nameRefs)
		let depthChild = SwiftName(kind: .index, contents: .index(depth))
		let indexChild = SwiftName(kind: .index, contents: .index(index))
		return SwiftName(kind: .archetypeRef, children: [depthChild, indexChild], contents: .name(archetypeName(index, depth)))
	case "q":
		let index = SwiftName(kind: .index, contents: .index(try demangleIndex(&scanner, &nameRefs)))
		let context = try demangleContext(&scanner, &nameRefs)
		let declContext = SwiftName(kind: .declContext, children: [context])
		return SwiftName(kind: .qualifiedArchetype, children: [index, declContext])
	default:
		try scanner.backtrack()
		let index = try demangleIndex(&scanner, &nameRefs)
		let depthChild = SwiftName(kind: .index, contents: .index(0))
		let indexChild = SwiftName(kind: .index, contents: .index(index))
		return SwiftName(kind: .archetypeRef, children: [depthChild, indexChild], contents: .name(archetypeName(index, 0)))
	}
}

private func demangleImplConvention<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], kind: SwiftName.Kind) throws -> String {
	switch (try scanner.readScalar(), (kind == .implErrorResult ? .implResult : kind)) {
	case ("a", .implResult): return "@autoreleased"
	case ("d", .implConvention): return "@callee_unowned"
	case ("d", _): return "@unowned"
	case ("D", .implResult): return "@unowned_inner_pointer"
	case ("g", .implParameter): return "@guaranteed"
	case ("e", .implParameter): return "@deallocating"
	case ("g", .implConvention): return "@callee_guaranteed"
	case ("i", .implParameter): return "@in"
	case ("i", .implResult): return "@out"
	case ("l", .implParameter): return "@inout"
	case ("o", .implConvention): return "@callee_owned"
	case ("o", _): return "@owned"
	case ("t", .implConvention): return "@convention(thin)"
	default: throw scanner.unexpectedError()
	}
}

private func demangleImplParameterOrResult<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], kind: SwiftName.Kind) throws -> SwiftName {
	var k: SwiftName.Kind
	if scanner.conditional(scalar: "z") {
		if case .implResult = kind {
			k = .implErrorResult
		} else {
			throw scanner.unexpectedError()
		}
	} else {
		k = kind
	}
	
	let convention = try demangleImplConvention(&scanner, &nameRefs, kind: k)
	let type = try demangleType(&scanner, &nameRefs)
	let conventionNode = SwiftName(kind: .implConvention, contents: .name(convention))
	return SwiftName(kind: k, children: [conventionNode, type])
}


private func demangleTuple<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], variadic: Bool) throws -> SwiftName {
	var children = [SwiftName]()
	while !scanner.conditional(scalar: "_") {
		var elementChildren = [SwiftName]()
		let peek = try scanner.requirePeek()
		if (peek >= "0" && peek <= "9") || peek == "o" {
			elementChildren.append(try demangleIdentifier(&scanner, &nameRefs, kind: .tupleElementName))
		}
		elementChildren.append(try demangleType(&scanner, &nameRefs))
		children.append(SwiftName(kind: .tupleElement, children: elementChildren))
	}
	return SwiftName(kind: variadic ? .variadicTuple : .nonVariadicTuple, children: children)
}

private func demangleFunctionType<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], kind: SwiftName.Kind) throws -> SwiftName {
	var children = [SwiftName]()
	if scanner.conditional(scalar: "z") {
		children.append(SwiftName(kind: .throwsAnnotation))
	}
	children.append(SwiftName(kind: .argumentTuple, children: [try demangleType(&scanner, &nameRefs)]))
	children.append(SwiftName(kind: .returnType, children: [try demangleType(&scanner, &nameRefs)]))
	return SwiftName(kind: kind, children: children)
}

private func demangleIdentifier<C>(_ scanner: inout ScalarScanner<C>, _ nameRefs: inout [SwiftName], kind: SwiftName.Kind? = nil) throws -> SwiftName {
	let isPunycode = scanner.conditional(scalar: "X")
	let k: SwiftName.Kind
	let isOperator: Bool
	if scanner.conditional(scalar: "o") {
		guard kind == nil else { throw scanner.unexpectedError() }
		switch try scanner.readScalar() {
		case "p": (isOperator, k) = (true, .prefixOperator)
		case "P": (isOperator, k) = (true, .postfixOperator)
		case "i": (isOperator, k) = (true, .infixOperator)
		default: throw scanner.unexpectedError()
		}
	} else {
		(isOperator, k) = (false, kind ?? SwiftName.Kind.identifier)
	}
	
	var identifier = try scanner.readScalars(count: scanner.readInt())
	if isPunycode {
		identifier = decodeSwiftPunycode(identifier)
	}
	if isOperator {
		let source = identifier
		identifier = ""
		for scalar in source.unicodeScalars {
			switch scalar {
			case "a": identifier.append("&" as UnicodeScalar)
			case "c": identifier.append("@" as UnicodeScalar)
			case "d": identifier.append("/" as UnicodeScalar)
			case "e": identifier.append("=" as UnicodeScalar)
			case "g": identifier.append(">" as UnicodeScalar)
			case "l": identifier.append("<" as UnicodeScalar)
			case "m": identifier.append("*" as UnicodeScalar)
			case "n": identifier.append("!" as UnicodeScalar)
			case "o": identifier.append("|" as UnicodeScalar)
			case "p": identifier.append("+" as UnicodeScalar)
			case "q": identifier.append("?" as UnicodeScalar)
			case "r": identifier.append("%" as UnicodeScalar)
			case "s": identifier.append("-" as UnicodeScalar)
			case "t": identifier.append("~" as UnicodeScalar)
			case "x": identifier.append("^" as UnicodeScalar)
			case "z": identifier.append("." as UnicodeScalar)
			default:
				if scalar.value >= 128 {
					identifier.append(scalar)
				} else {
					throw scanner.unexpectedError()
				}
			}
		}
	}

	return SwiftName(kind: k, children: [], contents: .name(identifier))
}

private func archetypeName(_ index: UInt32, _ depth: UInt32) -> String {
	var result = ""
	var i = index
	repeat {
		result.append(UnicodeScalar(UnicodeScalar("A").value + i % 26))
		i /= 26
	} while i > 0
	if depth != 0 {
		result += depth.description
	}
	return result
}

/// A type for representing the different possible failure conditions when using ScalarScanner
///
/// NAME and ACCESS NOTE: To avoid any dependencies on other files/frameworks, I chose to embed the ScalarScanner class in this file. I made the ScalarScanner private to avoid potential name conflicts. However, this error type might need to be handled externally, so it is public but I've *renamed* it so that it will not conflict with any public copies of ScalarScanner in the same namespace.
public enum DemangleScannerError: ErrorProtocol {
	/// The scalar at the specified index doesn't match the expected grammar
	case unexpected(at: Int)
	
	/// Expected `wanted` at offset `at`
	case matchFailed(wanted: String, at: Int)
	
	/// Expected numerals at offset `at`
	case expectedInt(at: Int)
	
	/// Attempted to read `count` scalars from position `at` but hit the end of the sequence
	case endedPrematurely(count: Int, at: Int)
	
	/// Unable to find search patter `wanted` at or after `after` in the sequence
	case searchFailed(wanted: String, after: Int)
}

/// This typealias allows the renamed DemangleScannerError to be used by the embedded copy of ScalarScanner.
private typealias ScalarScannerError = DemangleScannerError

/// A structure for traversing a `String.UnicodeScalarView`. A `context` field is provided but is not used by the scanner (it is entirely for storage by the scanner's user).
/// This is a private copy of a class normally included in CwlUtils: http://github.com/mattgallagher/CwlUtils
private struct ScalarScanner<C: Collection where C.Iterator.Element == UnicodeScalar, C.Index: Comparable> {
	/// The underlying storage
	private let scalars: C
	
	/// Current scanning index
	private var index: C.Index
	
	/// Number of scalars consumed up to `index` (since String.UnicodeScalarView.Index is not a RandomAccessIndex, this makes determining the position *much* easier)
	private var consumed: Int
	
	/// Construct from a String.UnicodeScalarView and a context value
	private init(scalars: C) {
		self.scalars = scalars
		self.index = self.scalars.startIndex
		self.consumed = 0
	}
	
	/// Throw if the scalars at the current `index` don't match the scalars in `value`. Advance the `index` to the end of the match.
	/// WARNING: `string` is used purely for its `unicodeScalars` property and matching is purely based on direct scalar comparison (no decomposition or normalization is performed).
	private mutating func match(string: String) throws {
		let (newIndex, newConsumed) = try string.unicodeScalars.reduce((index: index, count: 0)) { (tuple: (index: C.Index, count: Int), scalar: UnicodeScalar) in
			if tuple.index == self.scalars.endIndex || scalar != self.scalars[tuple.index] {
				throw ScalarScannerError.matchFailed(wanted: string, at: consumed)
			}
			return (index: self.scalars.index(after: tuple.index), count: tuple.count + 1)
		}
		index = newIndex
		consumed += newConsumed
	}
	
	/// Throw if the scalars at the current `index` don't match the scalars in `value`. Advance the `index` to the end of the match.
	private mutating func match(scalar: UnicodeScalar) throws {
		if index == scalars.endIndex || scalars[index] != scalar {
			throw ScalarScannerError.matchFailed(wanted: String(scalar), at: consumed)
		}
		index = self.scalars.index(after: index)
		consumed += 1
	}
	
	/// Consume scalars from the contained collection, up to but not including the first instance of `scalar` found. `index` is advanced to immediately before `scalar`. Returns all scalars consumed prior to `scalar` as a `String`. Throws if `scalar` is never found.
	private mutating func readUntil(scalar: UnicodeScalar) throws -> String {
		var i = index
		let previousConsumed = consumed
		try skipUntil(scalar: scalar)
		
		var result = ""
		result.reserveCapacity(consumed - previousConsumed)
		while i != index {
			result.append(scalars[i])
			i = scalars.index(after: i)
		}
		
		return result
	}
	
	/// Consume scalars from the contained collection, up to but not including the first instance of `string` found. `index` is advanced to immediately before `string`. Returns all scalars consumed prior to `string` as a `String`. Throws if `string` is never found.
	/// WARNING: `string` is used purely for its `unicodeScalars` property and matching is purely based on direct scalar comparison (no decomposition or normalization is performed).
	private mutating func readUntil(string: String) throws -> String {
		var i = index
		let previousConsumed = consumed
		try skipUntil(string: string)
		
		var result = ""
		result.reserveCapacity(consumed - previousConsumed)
		while i != index {
			result.append(scalars[i])
			i = scalars.index(after: i)
		}
		
		return result
	}
	
	/// Peeks at the scalar at the current `index`, testing it with function `f`. If `f` returns `true`, the scalar is appended to a `String` and the `index` increased. The `String` is returned at the end.
	private mutating func readWhile(testTrue: @noescape (UnicodeScalar) -> Bool) -> String {
		var string = ""
		while index != scalars.endIndex {
			if !testTrue(scalars[index]) {
				break
			}
			string.append(scalars[index])
			index = self.scalars.index(after: index)
			consumed += 1
		}
		return string
	}
	
	/// Repeatedly peeks at the scalar at the current `index`, testing it with function `f`. If `f` returns `true`, the `index` increased. If `false`, the function returns.
	private mutating func skipWhile(testTrue: @noescape (UnicodeScalar) -> Bool) {
		while index != scalars.endIndex {
			if !testTrue(scalars[index]) {
				return
			}
			index = self.scalars.index(after: index)
			consumed += 1
		}
	}
	
	/// Consume scalars from the contained collection, up to but not including the first instance of `scalar` found. `index` is advanced to immediately before `scalar`. Throws if `scalar` is never found.
	private mutating func skipUntil(scalar: UnicodeScalar) throws {
		var i = index
		var c = 0
		while i != scalars.endIndex && scalars[i] != scalar {
			i = self.scalars.index(after: i)
			c += 1
		}
		if i == scalars.endIndex {
			throw ScalarScannerError.searchFailed(wanted: String(scalar), after: consumed)
		}
		index = i
		consumed += c
	}
	
	/// Consume scalars from the contained collection, up to but not including the first instance of `string` found. `index` is advanced to immediately before `string`. Throws if `string` is never found.
	/// WARNING: `string` is used purely for its `unicodeScalars` property and matching is purely based on direct scalar comparison (no decomposition or normalization is performed).
	private mutating func skipUntil(string: String) throws {
		let match = string.unicodeScalars
		guard let first = match.first else { return }
		if match.count == 1 {
			return try skipUntil(scalar: first)
		}
		var i = index
		var j = index
		var c = 0
		var d = 0
		let remainder = match[match.index(after: match.startIndex)..<match.endIndex]
		outerLoop: repeat {
			while scalars[i] != first {
				if i == scalars.endIndex {
					throw ScalarScannerError.searchFailed(wanted: String(match), after: consumed)
				}
				i = self.scalars.index(after: i)
				c += 1
				
				// Track the last index and consume count before hitting the match
				j = i
				d = c
			}
			i = self.scalars.index(after: i)
			c += 1
			for s in remainder {
				if i == self.scalars.endIndex {
					throw ScalarScannerError.searchFailed(wanted: String(match), after: consumed)
				}
				if scalars[i] != s {
					continue outerLoop
				}
				i = self.scalars.index(after: i)
				c += 1
			}
			break
		} while true
		index = j
		consumed += d
	}
	
	/// Attempt to advance the `index` by count, returning `false` and `index` unchanged if `index` would advance past the end, otherwise returns `true` and `index` is advanced.
	private mutating func skip(count: Int = 1) throws {
		if count == 1 && index != scalars.endIndex {
			index = scalars.index(after: index)
			consumed += 1
		} else {
			var i = index
			var c = count
			while c > 0 {
				if i == scalars.endIndex {
					throw ScalarScannerError.endedPrematurely(count: count, at: consumed)
				}
				i = self.scalars.index(after: i)
				c -= 1
			}
			index = i
			consumed += count
		}
	}
	
	/// Attempt to advance the `index` by count, returning `false` and `index` unchanged if `index` would advance past the end, otherwise returns `true` and `index` is advanced.
	private mutating func backtrack(count: Int = 1) throws {
		if count <= consumed {
			if count == 1 {
				index = scalars.index(index, offsetBy: -1)
				consumed -= 1
			} else {
				let limit = consumed - count
				while consumed != limit {
					index = scalars.index(index, offsetBy: -1)
					consumed -= 1
				}
			}
		} else {
			throw ScalarScannerError.endedPrematurely(count: -count, at: consumed)
		}
	}
	
	/// Returns all content after the current `index`. `index` is advanced to the end.
	private mutating func remainder() -> String {
		var string: String = ""
		while index != scalars.endIndex {
			string.append(scalars[index])
			index = scalars.index(after: index)
			consumed += 1
		}
		return string
	}
	
	/// If the next scalars after the current `index` match `value`, advance over them and return `true`, otherwise, leave `index` unchanged and return `false`.
	/// WARNING: `string` is used purely for its `unicodeScalars` property and matching is purely based on direct scalar comparison (no decomposition or normalization is performed).
	private mutating func conditional(string: String) -> Bool {
		var i = index
		var c = 0
		for s in string.unicodeScalars {
			if i == scalars.endIndex || s != scalars[i] {
				return false
			}
			i = self.scalars.index(after: i)
			c += 1
		}
		index = i
		consumed += c
		return true
	}
	
	/// If the next scalar after the current `index` match `value`, advance over it and return `true`, otherwise, leave `index` unchanged and return `false`.
	private mutating func conditional(scalar: UnicodeScalar) -> Bool {
		if index == scalars.endIndex || scalar != scalars[index] {
			return false
		}
		index = self.scalars.index(after: index)
		consumed += 1
		return true
	}
	
	/// If the `index` is at the end, throw, otherwise, return the next scalar at the current `index` without advancing `index`.
	private func requirePeek() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.endedPrematurely(count: 1, at: consumed)
		}
		return scalars[index]
	}
	
	/// If `index` + `ahead` is within bounds, return the scalar at that location, otherwise return `nil`. The `index` will not be changed in any case.
	private func peek(skipCount: Int = 0) -> UnicodeScalar? {
		var i = index
		var c = skipCount
		while c > 0 && i != scalars.endIndex {
			i = self.scalars.index(after: i)
			c -= 1
		}
		if i == scalars.endIndex {
			return nil
		}
		return scalars[i]
	}
	
	/// If the `index` is at the end, throw, otherwise, return the next scalar at the current `index`, advancing `index` by one.
	private mutating func readScalar() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.endedPrematurely(count: 1, at: consumed)
		}
		let result = scalars[index]
		index = self.scalars.index(after: index)
		consumed += 1
		return result
	}
	
	/// Throws if scalar at the current `index` is not in the range `"0"` to `"9"`. Consume scalars `"0"` to `"9"` until a scalar outside that range is encountered. Return the integer representation of the value scanned, interpreted as a base 10 integer. `index` is advanced to the end of the number.
	private mutating func readInt() throws -> Int {
		var result = 0
		var i = index
		var c = 0
		while i != scalars.endIndex && scalars[i] >= "0" && scalars[i] <= "9" {
			result = result * 10 + Int(scalars[i].value - UnicodeScalar("0").value)
			i = self.scalars.index(after: i)
			c += 1
		}
		if i == index {
			throw ScalarScannerError.expectedInt(at: consumed)
		}
		index = i
		consumed += c
		return result
	}
	
	/// Consume and return `count` scalars. `index` will be advanced by count. Throws if end of `scalars` occurs before consuming `count` scalars.
	private mutating func readScalars(count: Int) throws -> String {
		var result = String()
		result.reserveCapacity(count)
		var i = index
		for _ in 0..<count {
			if i == scalars.endIndex {
				throw ScalarScannerError.endedPrematurely(count: count, at: consumed)
			}
			result.append(scalars[i])
			i = self.scalars.index(after: i)
		}
		index = i
		consumed += count
		return result
	}
	
	/// Returns a throwable error capturing the current scanner progress point.
	private func unexpectedError() -> ErrorProtocol {
		return ScalarScannerError.unexpected(at: consumed)
	}
	
	private var isAtEnd: Bool {
		return index == scalars.endIndex
	}
}

private extension Array {
	func at(_ index: Int) -> Element? {
		return self.indices.contains(index) ? self[index] : nil
	}
	func slice(_ from: Int, _ to: Int) -> ArraySlice<Element> {
		if from > to || from > self.endIndex || to < self.startIndex {
			return ArraySlice()
		} else {
			return self[(from > self.startIndex ? from : self.startIndex)..<(to < self.endIndex ? to : self.endIndex)]
		}
	}
}

private extension OutputStream {
	mutating func write<S: Sequence, T: Sequence where T.Iterator.Element == String?>(sequence: S, labels: T, render: @noescape(inout Self, S.Iterator.Element) -> ()) {
		var lg = labels.makeIterator()
		if let maybePrefix = lg.next(), let prefix = maybePrefix {
			write(prefix)
		}
		for e in sequence {
			render(&self, e)
			if let maybeLabel = lg.next(), let label = maybeLabel {
				write(label)
			}
		}
	}

	mutating func write<S: Sequence>(sequence: S, prefix: String? = nil, separator: String? = nil, suffix: String? = nil, render: @noescape(inout Self, S.Iterator.Element) -> ()) {
		if let p = prefix {
			write(p)
		}
		var first = true
		for e in sequence {
			if !first, let s = separator {
				write(s)
			}
			render(&self, e)
			first = false
		}
		if let s = suffix {
			write(s)
		}
	}

    mutating func write<T>(optional: Optional<T>, prefix: String? = nil, suffix: String? = nil, render: @noescape (inout Self, T) -> ()) {
        if let p = prefix {
            write(p)
        }
        if let e = optional {
            render(&self, e)
        }
        if let s = suffix {
            write(s)
        }
    }

    mutating func write<T>(value: T, prefix: String? = nil, suffix: String? = nil, render: @noescape (inout Self, T) -> ()) {
        if let p = prefix {
            write(p)
        }
        render(&self, value)
        if let s = suffix {
            write(s)
        }
    }
}

private struct PrintOptions: OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static let asContext = PrintOptions(rawValue: 1)
    static let suppressType = PrintOptions(rawValue: 2)
    static let hasName = PrintOptions(rawValue: 4)
    static let hasType = PrintOptions(rawValue: 8)
    static let hasTypeAndName = PrintOptions(rawValue: 12)
}

public struct SwiftName: CustomStringConvertible {
	public let kind: Kind
	public let children: [SwiftName]
	public enum Contents {
		case none
		case index(UInt32)
		case name(String)
		var description: String {
			switch self {
			case .none: return ""
			case .index(let i): return i.description
			case .name(let s): return s
			}
		}
	}
	public let contents: Contents
	
	init(kind: Kind, children: [SwiftName] = [], contents: Contents = .none) {
		self.kind = kind
		self.children = children
		self.contents = contents
	}
	
	public var description: String {
		var result = ""
		print(&result)
		return result
	}
	
	func printFunction<T: OutputStream>(_ output: inout T) {
		let startIndex = children.count == 3 ? 1 : 0
		let separator: String? = children.count == 3 ? " throws" : nil
		output.write(sequence: children[startIndex...(startIndex + 1)], separator: separator) { $1.print(&$0) }
	}

	private func printEntity<T: OutputStream>(_ output: inout T, extraName: String, options: PrintOptions) {
		children.at(0)?.print(&output, PrintOptions.asContext)
		output.write(".")
		let printType = (options.contains(PrintOptions.hasType) && !options.contains(PrintOptions.suppressType))
		let useParens = (printType && options.contains(PrintOptions.asContext))
		
		if useParens {
			output.write("(")
		}
		if options.contains(PrintOptions.hasName) {
			children.at(1)?.print(&output)
		}
		output.write(extraName)
		if printType, let type = children.at(1 + (options.contains(PrintOptions.hasName) ? 1 : 0)) {
			output.write(useColonForType(type) ? " : " : " ")
			type.print(&output)
		}
		if useParens {
			output.write(")")
		}
	}
	
	func indexFromChild(_ childIndex: Int = 1) -> UInt32 {
		return children.at(childIndex)?.indexFromContents() ?? 0
	}
	
	func indexFromContents() -> UInt32 {
		if case .index(let i) = contents {
			return i
		} else {
			return 0
		}
	}
	
	func findSugar() -> SugarType {
		guard children.count != 1 || kind != .type else { return children[0].findSugar() }
		guard children.count == 2 else { return .none }
		guard kind == .boundGenericEnum || kind == .boundGenericStructure else { return .none }
		
		guard let unboundType = children[0].children.first, unboundType.children.count > 1 else { return .none }
		let typeArgs = children[1]
		let c0 = unboundType.children[0]
		let c1 = unboundType.children[1]
		
		if kind == .boundGenericEnum {
			if c1.kind == .identifier, case .name(let s) = c1.contents, s == "Optional" && typeArgs.children.count == 1 && c0.kind == .module, case .name(let m) = c0.contents, m == stdlibName {
				return .optional
			}
			if c1.kind == .identifier, case .name(let s) = c1.contents, s == "ImplicitlyUnwrappedOptional" && typeArgs.children.count == 1 && c0.kind == .module, case .name(let m) = c0.contents, m == stdlibName {
				return .implicitlyUnwrappedOptional
			}
			return .none
		}
		if c1.kind == .identifier, case .name(let s) = c1.contents, s == "Array" && typeArgs.children.count == 1 && c0.kind == .module, case .name(let m) = c0.contents, m == stdlibName {
			return .array
		}
		if c1.kind == .identifier, case .name(let s) = c1.contents, s == "Dictionary" && typeArgs.children.count == 2 && c0.kind == .module, case .name(let m) = c0.contents, m == stdlibName {
			return .dictionary
		}
		return .none
	}
	
	func printBoundGenericNoSugar<T: OutputStream>(_ output: inout T) {
		children.at(0)?.print(&output)
		output.write(sequence: children.slice(1, children.endIndex), prefix: "<", separator: ", ", suffix: ">") { $1.print(&$0) }
	}
	
	func printBoundGeneric<T: OutputStream>(_ output: inout T) {
		guard children.count >= 2 else { return }
		guard children.count == 2 else { printBoundGenericNoSugar(&output); return }
		let sugarType = findSugar()
		switch sugarType {
		case .optional: fallthrough
		case .implicitlyUnwrappedOptional:
			if let type = children.at(1)?.children.at(0) {
				let needParens = !type.kind.isSimpleType
				output.write(value: type, prefix: needParens ? "(" : nil, suffix: needParens ? ")" : nil) { $1.print(&$0) }
				output.write(sugarType == .optional ? "?" : "!")
			}
		case .array: fallthrough
		case .dictionary:
			output.write(sequence: children[1].children, prefix: "[", separator: " : ", suffix: "]") { $1.print(&$0) }
		default: printBoundGenericNoSugar(&output)
		}
	}

	enum State { case attrs, inputs, results }
	func printImplFunctionType<T: OutputStream>(_ output: inout T) {
		var curState: State = .attrs
		childLoop: for c in children {
			if c.kind == .implParameter {
				switch curState {
				case .inputs: output.write(", ")
				case .attrs: output.write("(")
				case .results: break childLoop
				}
				curState = .inputs
				c.print(&output)
			} else if c.kind == .implResult || c.kind == .implErrorResult {
				switch curState {
				case .inputs: output.write(") -> (")
				case .attrs: output.write("() -> (")
				case .results: output.write(", ")
				}
				curState = .results
				c.print(&output)
			} else {
				c.print(&output)
				output.write(" ")
			}
		}
		switch curState {
		case .inputs: output.write(") -> ()")
		case .attrs: output.write("() -> ()")
		case .results: output.write(")")
		}
	}
	
	func quotedString<T: OutputStream>(_ output: inout T, value: String) {
		output.write("\"")
		for c in value.unicodeScalars {
			switch c {
			case "\\": output.write("\\\\")
			case "\t": output.write("\\t")
			case "\n": output.write("\\n")
			case "\r": output.write("\\r")
			case "\"": output.write("\\\"")
			case "\0": output.write("\\0")
			default:
				if c < UnicodeScalar(0x20) || c == UnicodeScalar(0x7f) {
					output.write("\\x")
					output.write(String(((c.value >> 4) > 9) ? UnicodeScalar(c.value + UnicodeScalar("A").value) : UnicodeScalar(c.value + UnicodeScalar("0").value)))
				} else {
					output.write(String(c))
				}
			}
		}
		output.write("\"")
	}
	
	private func print<T: OutputStream>(_ output: inout T, _ options: PrintOptions = PrintOptions()) {
		switch kind {
		case .static:
			output.write(optional: children.at(0), prefix: "static ") { $1.print(&$0, options) }
		case .directness:
			output.write(indexFromContents() == 1 ? "indirect " : "direct ")
		case .extension:
			var index = 0
			output.write(sequence: children.prefix(3), labels: ["(extension in ", "):"]) { o, e in
				e.print(&o, index == 2 ? PrintOptions.asContext : options)
				index += 1
			}
		case .variable: fallthrough
		case .function: fallthrough
		case .subscript:
			printEntity(&output, extraName: "", options: options.union(PrintOptions.hasTypeAndName))
		case .explicitClosure: fallthrough
		case .implicitClosure:
			printEntity(&output, extraName: "(\(kind == .implicitClosure ? "implicit " : "")closure #\((indexFromChild(1) + 1).description))", options: options)
		case .global:
			output.write(sequence: children) { $1.print(&$0) }
		case .suffix:
			output.write(" with unmangled suffix ")
			quotedString(&output, value: contents.description)
		case .initializer:
			printEntity(&output, extraName: "(variable initialization expression)", options: options)
		case .defaultArgumentInitializer:
			printEntity(&output, extraName: "(default argument \(indexFromChild(1)))", options: options)
		case .declContext:
			children.at(0)?.print(&output, options.subtracting(PrintOptions.suppressType))
		case .type:
			children.at(0)?.print(&output, options.subtracting(PrintOptions.suppressType))
		case .typeMangling:
			children.at(0)?.print(&output)
		case .class: fallthrough
		case .structure: fallthrough
		case .enum: fallthrough
		case .protocol: fallthrough
		case .typeAlias:
			printEntity(&output, extraName: "", options: options.union(PrintOptions.hasName))
		case .localDeclName:
			output.write(optional: children.at(1), prefix: "(") { $1.print(&$0) }
			output.write(" #")
			output.write((indexFromChild(0) + 1).description)
			output.write(")")
		case .privateDeclName:
			output.write(optional: children.at(1), prefix: "(") { $1.print(&$0) }
			if let c = children.first {
				output.write(" in ")
				output.write(c.contents.description)
				output.write(")")
			}
		case .module: fallthrough
		case .identifier: fallthrough
		case .index:
			output.write(contents.description)
		case .autoClosureType:
			output.write("@autoclosure ")
			printFunction(&output)
		case .thinFunctionType:
			output.write("@convention(thin) ")
			printFunction(&output)
		case .functionType: fallthrough
		case .uncurriedFunctionType:
			printFunction(&output)
		case .argumentTuple:
			let needParens: Bool
			if let k = children.at(0)?.children.at(0)?.kind, k == .variadicTuple || k == .nonVariadicTuple {
				needParens = false
			} else {
				needParens = true
			}
			output.write(sequence: children, prefix: needParens ? "(" : nil, suffix: needParens ? ")" : nil) { $1.print(&$0) }
		case .nonVariadicTuple: fallthrough
		case .variadicTuple:
			output.write(sequence: children, prefix: "(", separator: ", ", suffix: kind == .variadicTuple ? "...)" : ")") { $1.print(&$0) }
		case .tupleElement:
			output.write(sequence: children.prefix(2)) { $1.print(&$0) }
		case .tupleElementName:
			output.write(contents.description)
			output.write(" : ")
		case .returnType:
			output.write(sequence: children.count == 0 ? [self] : children, prefix: " -> ") { children.count == 0 ? $0.write(contents.description) : $1.print(&$0) }
		case .weak:
			output.write(optional: children.at(0), prefix: "weak ") { $1.print(&$0) }
		case .unowned:
			output.write(optional: children.at(0), prefix: "unowned ") { $1.print(&$0) }
		case .unmanaged:
			output.write(optional: children.at(0), prefix: "unowned(unsafe) ") { $1.print(&$0) }
		case .inOut:
			output.write(optional: children.at(0), prefix: "inout ") { $1.print(&$0) }
		case .nonObjCAttribute:
			output.write("@nonobjc ")
		case .objCAttribute:
			output.write("@objc ")
		case .directMethodReferenceAttribute:
			output.write("super ")
		case .dynamicAttribute:
			output.write("dynamic ")
		case .vTableAttribute:
			output.write("override ")
		case .functionSignatureSpecialization: fallthrough
		case .genericSpecialization: fallthrough
		case .genericSpecializationNotReAbstracted:
			let prefix: String
			switch kind {
			case .functionSignatureSpecialization: prefix = "function signature specialization <"
			case .genericSpecialization: prefix = "generic specialization <"
			default: prefix = "generic not re-abstracted specialization <"
			}
			let cs = children.lazy.filter { (c: SwiftName) -> Bool in c.kind != .specializationPassID && (c.kind == .specializationIsFragile || c.children.count != 0) }
			output.write(sequence: cs, prefix: prefix, separator: ", ", suffix: "> of ") { $1.print(&$0) }
		case .specializationIsFragile: output.write("preserving fragile attribute")
		case .genericSpecializationParam:
			var index = 0
			output.write(sequence: children) {
				if index == 1 {
					$0.write(" with ")
				} else if index != 0 {
					$0.write(" and ")
				}
				$1.print(&$0)
				index += 1
			}
		case .functionSignatureSpecializationParam:
			output.write("Arg[")
			output.write(contents.description)
			output.write("] = ")
			var index = 0
			while index < children.endIndex {
				switch FunctionSigSpecializationParamKind(rawValue: indexFromChild(index)) {
				case .some(.boxToValue): fallthrough
				case .some(.boxToStack):
					children.at(index)?.print(&output)
				case .some(.constantPropFunction): fallthrough
				case .some(.constantPropGlobal):
					if let t = children.at(index + 1)?.contents.description {
						output.write(optional: children.at(index), prefix: "[", suffix: " : ") { $1.print(&$0) }
						output.write((try? demangleSwiftName(t).description) ?? t)
						output.write("]")
						index += 1
					}
				case .some(.constantPropInteger): fallthrough
				case .some(.constantPropFloat):
					output.write(sequence: children.slice(index, (index + 2)), prefix: "[", separator: " : ", suffix: "]") { $1.print(&$0) }
					index += 1
				case .some(.constantPropString):
					output.write(sequence: children.slice(index, (index + 3)), labels: ["[", " : ", "'", "']"]) { $1.print(&$0) }
					index += 2
				case .some(.closureProp):
					output.write(sequence: children.slice(index, (index + 2)), labels: ["[", " : ", ", Argument Types : ["]) { $1.print(&$0) }
					index += 2
					output.write(sequence: children.slice(index, children.endIndex), separator: ", ", suffix: "]") { $1.print(&$0) }
					index = children.endIndex
				default: children.at(index)?.print(&output)
				}
				index += 1
			}
		case .functionSignatureSpecializationParamPayload:
			output.write((try? demangleSwiftName(contents.description).description) ?? contents.description)
		case .functionSignatureSpecializationParamKind:
			let raw = indexFromContents()
			switch FunctionSigSpecializationParamKind(rawValue: raw) {
			case .some(.boxToValue): output.write("Value Promoted from Box")
			case .some(.boxToStack): output.write("Stack Promoted from Box")
			case .some(.constantPropFunction): output.write("Constant Propagated Function")
			case .some(.constantPropGlobal): output.write("Constant Propagated Global")
			case .some(.constantPropInteger): output.write("Constant Propagated Integer")
			case .some(.constantPropFloat): output.write("Constant Propagated Float")
			case .some(.constantPropString): output.write("Constant Propagated String")
			case .some(.closureProp): output.write("Closure Propagated")
			default:
				if raw & FunctionSigSpecializationParamKind.dead.rawValue != 0 {
					output.write("Dead")
				}
				if raw & FunctionSigSpecializationParamKind.ownedToGuaranteed.rawValue != 0 {
					if raw & FunctionSigSpecializationParamKind.dead.rawValue != 0 {
						output.write(" and ")
					}
					output.write("Owned To Guaranteed")
				}
				if raw & FunctionSigSpecializationParamKind.sroa.rawValue != 0 {
					if raw & (FunctionSigSpecializationParamKind.ownedToGuaranteed.rawValue | FunctionSigSpecializationParamKind.dead.rawValue) != 0 {
						output.write(" and ")
					}
					output.write("Exploded")
				}
			}
		case .specializationPassID:
			output.write(contents.description)
		case .builtinTypeName:
			output.write(contents.description)
		case .number:
			output.write(contents.description)
		case .infixOperator:
			output.write(contents.description + " infix")
		case .prefixOperator:
			output.write(contents.description + " prefix")
		case .postfixOperator:
			output.write(contents.description + " postfix")
		case .lazyProtocolWitnessTableAccessor:
			output.write(sequence: children.prefix(2), labels: ["lazy protocol witness table accessor for type ", " and conformance "]) { $1.print(&$0) }
		case .lazyProtocolWitnessTableCacheVariable:
			output.write(sequence: children.prefix(2), labels: ["lazy protocol witness table cache variable for type ", " and conformance "]) { $1.print(&$0) }
		case .protocolWitnessTableAccessor:
			output.write(optional: children.at(0), prefix: "protocol witness table accessor for ") { $1.print(&$0) }
		case .protocolWitnessTable:
			output.write(optional: children.at(0), prefix: "protocol witness table for ") { $1.print(&$0) }
		case .genericProtocolWitnessTable:
			output.write(optional: children.at(0), prefix: "generic protocol witness table for ") { $1.print(&$0) }
		case .genericProtocolWitnessTableInstantiationFunction:
			output.write(optional: children.at(0), prefix: "instantiation function for generic protocol witness table for ") { $1.print(&$0) }
		case .protocolWitness:
			output.write(sequence: [children.at(1), children.at(0)], labels: ["protocol witness for ", " in conformance "]) { $1?.print(&$0) }
		case .partialApplyForwarder:
			output.write("partial apply forwarder")
			output.write(optional: children.at(0), prefix: children.isEmpty ? nil : " for ") { $1.print(&$0) }
		case .partialApplyObjCForwarder:
			output.write("partial apply ObjC forwarder")
			output.write(optional: children.at(0), prefix: children.isEmpty ? nil : " for ") { $1.print(&$0) }
		case .fieldOffset:
			output.write(sequence: children.prefix(2), separator: "field offset for ") { $1.print(&$0) }
		case .reabstractionThunk: fallthrough
		case .reabstractionThunkHelper:
			output.write("reabstraction thunk ")
			output.write(kind == .reabstractionThunkHelper ? "helper " : "")
			let dgs = children.lazy.filter({ $0.kind == .dependentGenericSignature }).first
			let firstLabel: String? = dgs == nil ? "from " : nil
			let labels: [String?] = (dgs == nil ? [firstLabel, " to "] : [firstLabel, " from ", " to "])
			output.write(sequence: [dgs, children.at(children.count - 2), children.at(children.count - 1)].flatMap { $0 }, labels: labels) { $1.print(&$0) }
		case .genericTypeMetadataPattern:
			output.write(optional: children.at(0), prefix: "generic type metadata pattern for ") { $1.print(&$0) }
		case .metaclass:
			output.write(optional: children.at(0), prefix: "metaclass for ") { $1.print(&$0) }
		case .protocolDescriptor:
			output.write(optional: children.at(0), prefix: "protocol descriptor for ") { $1.print(&$0) }
		case .fullTypeMetadata:
			output.write(optional: children.at(0), prefix: "full type metadata for ") { $1.print(&$0) }
		case .typeMetadata:
			output.write(optional: children.at(0), prefix: "type metadata for ") { $1.print(&$0) }
		case .typeMetadataAccessFunction:
			output.write(optional: children.at(0), prefix: "type metadata accessor for ") { $1.print(&$0) }
		case .typeMetadataLazyCache:
			output.write(optional: children.at(0), prefix: "lazy cache variable for type metadata for ") { $1.print(&$0) }
		case .associatedTypeMetadataAccessor:
			output.write(sequence: [children.at(1), children.at(0)], labels: ["associated type metadata accessor for ", " in "]) { $1?.print(&$0) }
		case .associatedTypeWitnessTableAccessor:
			output.write(sequence: [children.at(1), children.at(2), children.at(0)], labels: ["associated type witness table accessor for ", " : ", " in "]) { $1?.print(&$0) }
		case .nominalTypeDescriptor:
			output.write(optional: children.at(0), prefix: "nominal type descriptor for ") { $1.print(&$0) }
		case .valueWitness:
			output.write(ValueWitnessKind(rawValue: indexFromContents())?.description ?? "")
			output.write(optional: children.at(0), prefix: " value witness for ") { $1.print(&$0) }
		case .valueWitnessTable:
			output.write(optional: children.at(0), prefix: "value witness table for ") { $1.print(&$0) }
		case .witnessTableOffset:
			output.write(optional: children.at(0), prefix: "witness table offset for ") { $1.print(&$0) }
		case .boundGenericClass: fallthrough
		case .boundGenericStructure: fallthrough
		case .boundGenericEnum:
			printBoundGeneric(&output)
		case .dynamicSelf:
			output.write("Self")
		case .cFunctionPointer:
			output.write("@convention(c) ")
			printFunction(&output)
		case .objCBlock:
			output.write("@convention(block) ")
			printFunction(&output)
		case .silBoxType:
			output.write("@box ")
			children.at(0)?.print(&output)
		case .metatype:
			guard let c0 = children.at(0) else { return }
			let suffix: String
			if c0.kind == .type, let f = c0.children.first, f.kind == .existentialMetatype || f.kind == .protocolList {
				suffix = ".Protocol"
			} else {
				suffix = ".Type"
			}
			if let c1 = children.at(1) {
				output.write(sequence: [c1, c0], separator: " ", suffix: suffix) { $1.print(&$0) }
			} else {
				output.write(value: c0, suffix: suffix) { $1.print(&$0) }
			}
		case .existentialMetatype:
			guard let c0 = children.at(0) else { return }
			if let c1 = children.at(1) {
				output.write(sequence: [c1, c0], separator: " ", suffix: ".Type") { $1.print(&$0) }
			} else {
				output.write(value: c0, suffix: ".Type") { $1.print(&$0) }
			}
		case .metatypeRepresentation:
			output.write(contents.description)
		case .archetypeRef:
			output.write(contents.description)
		case .associatedTypeRef:
			guard let c1 = children.at(1) else { return }
			output.write(optional: children.at(0), suffix: ".") { $1.print(&$0) }
			output.write(c1.contents.description)
		case .selfTypeRef:
			output.write(optional: children.at(0), suffix: ".Self") { $1.print(&$0) }
		case .protocolList:
			guard let p = children.at(0) else { return }
			output.write(sequence: p.children, prefix: p.children.count != 1 ? "protocol<" : nil, separator: ", ", suffix: p.children.count != 1 ? ">" : nil) { $1.print(&$0) }
		case .generics:
			output.write(sequence: children.lazy.filter { $0.kind == .archetype }, prefix: "<", separator: ", ", suffix: ">") { $1.print(&$0) }
		case .archetype:
			output.write(contents.description)
			output.write(optional: children.at(0), prefix: children.isEmpty ? nil : " : ") { $1.print(&$0) }
		case .associatedType: return
		case .qualifiedArchetype:
			guard let c0 = children.at(0), let c1 = children.at(1) else { return }
			output.write("(archetype ")
			output.write(c0.contents.description)
			output.write(value: c1, prefix: " of ", suffix: ")") { $1.print(&$0) }
		case .genericType:
			output.write(sequence: [children.at(0), children.at(1)?.children.at(0)]) { $1?.print(&$0) }
		case .owningAddressor:
			printEntity(&output, extraName: ".owningAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .owningMutableAddressor:
			printEntity(&output, extraName: ".owningMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .nativeOwningAddressor:
			printEntity(&output, extraName: ".nativeOwningAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .nativeOwningMutableAddressor:
			printEntity(&output, extraName: ".nativeOwningMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .nativePinningAddressor:
			printEntity(&output, extraName: ".nativePinningAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .nativePinningMutableAddressor:
			printEntity(&output, extraName: ".nativePinningMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .unsafeAddressor:
			printEntity(&output, extraName: ".unsafeAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .unsafeMutableAddressor:
			printEntity(&output, extraName: ".unsafeMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .globalGetter:
			printEntity(&output, extraName: ".getter", options: options.union(PrintOptions.hasTypeAndName))
		case .getter:
			printEntity(&output, extraName: ".getter", options: options.union(PrintOptions.hasTypeAndName))
		case .setter:
			printEntity(&output, extraName: ".setter", options: options.union(PrintOptions.hasTypeAndName))
		case .materializeForSet:
			printEntity(&output, extraName: ".materializeForSet", options: options.union(PrintOptions.hasTypeAndName))
		case .willSet:
			printEntity(&output, extraName: ".willset", options: options.union(PrintOptions.hasTypeAndName))
		case .didSet:
			printEntity(&output, extraName: ".didset", options: options.union(PrintOptions.hasTypeAndName))
		case .allocator:
			printEntity(&output, extraName: ((children.count > 0 && children[0].kind == .class) ? "__allocating_init" : "init"), options: options.union(PrintOptions.hasType))
		case .constructor:
			printEntity(&output, extraName: "init", options: options.union(PrintOptions.hasType))
		case .destructor:
			printEntity(&output, extraName: "deinit", options: options)
		case .deallocator:
			printEntity(&output, extraName: ((children.count > 0 && children[0].kind == .class) ? "__deallocating_deinit" : "deinit"), options: options)
		case .iVarInitializer:
			printEntity(&output, extraName: "__ivar_initializer", options: options)
		case .iVarDestroyer:
			printEntity(&output, extraName: "__ivar_destroyer", options: options)
		case .protocolConformance:
			output.write(sequence: children.prefix(3), labels: [nil, " : ", " in "]) { $1.print(&$0) }
		case .typeList:
			output.write(sequence: children) { $1.print(&$0) }
		case .implConvention:
			output.write(contents.description)
		case .implFunctionAttribute:
			output.write(contents.description)
		case .implErrorResult:
			output.write("@error ")
			fallthrough
		case .implParameter: fallthrough
		case .implResult:
			output.write(sequence: children, separator: " ") { $1.print(&$0) }
		case .implFunctionType:
			printImplFunctionType(&output)
		case .errorType:
			output.write("<ERROR TYPE>")
		case .dependentGenericSignature:
			let filteredChildren = children.filter { $0.kind == .dependentGenericParamCount }.enumerated()
			var lastDepth = 0
			output.write(sequence: filteredChildren, prefix: "<", separator: "><") { o, t in
				lastDepth = t.offset
				o.write(sequence: 0..<t.element.indexFromContents(), separator: ", ") {
					$0.write(archetypeName($1, UInt32(t.offset)))
				}
			}
			let prefix: String? = (lastDepth + 1 < children.endIndex) ? " where " : nil
			let s = children.slice(lastDepth + 1, children.endIndex)
			output.write(sequence: s, prefix: prefix, separator: ", ", suffix: ">") { $1.print(&$0) }
		case .dependentGenericParamCount: return
		case .dependentGenericConformanceRequirement:
			output.write(sequence: children, separator: ": ") { $1.print(&$0) }
		case .dependentGenericSameTypeRequirement:
			output.write(sequence: children, separator: " == ") { $1.print(&$0) }
		case .dependentGenericParamType: output.write(contents.description)
		case .dependentGenericType:
			output.write(sequence: children, separator: " ") { $1.print(&$0) }
		case .dependentMemberType:
			output.write(sequence: children, separator: ".") { $1.print(&$0) }
		case .dependentAssociatedTypeRef: output.write(contents.description)
		case .throwsAnnotation:
			output.write(" throws ")
		}
	}
	
	func useColonForType(_ type: SwiftName) -> Bool {
		switch kind {
		case .variable: fallthrough
		case .initializer: fallthrough
		case .defaultArgumentInitializer: fallthrough
		case .iVarInitializer: fallthrough
		case .class: fallthrough
		case .structure: fallthrough
		case .enum: fallthrough
		case .protocol: fallthrough
		case .typeAlias: fallthrough
		case .owningAddressor: fallthrough
		case .owningMutableAddressor: fallthrough
		case .nativeOwningAddressor: fallthrough
		case .nativeOwningMutableAddressor: fallthrough
		case .nativePinningAddressor: fallthrough
		case .nativePinningMutableAddressor: fallthrough
		case .unsafeAddressor: fallthrough
		case .unsafeMutableAddressor: fallthrough
		case .globalGetter: fallthrough
		case .getter: fallthrough
		case .setter: fallthrough
		case .materializeForSet: fallthrough
		case .willSet: fallthrough
		case .didSet: return true
		case .subscript: fallthrough
		case .function: fallthrough
		case .explicitClosure: fallthrough
		case .implicitClosure: fallthrough
		case .allocator: fallthrough
		case .constructor: fallthrough
		case .destructor: fallthrough
		case .deallocator: fallthrough
		case .iVarDestroyer:
			var ty = type.children.first
			while case .some(let t) = ty, t.kind == .genericType || t.kind == .dependentGenericType {
				if t.children.count > 1 {
					ty = t.children[1].children.first
				}
			}
			if let t = ty, t.kind != .functionType && t.kind != .uncurriedFunctionType && t.kind != .cFunctionPointer && t.kind != .thinFunctionType {
				return true
			} else {
				return false
			}
		default: return false
		}
	}

	public enum Kind {
		case allocator
		case archetype
		case archetypeRef
		case argumentTuple
		case associatedType
		case associatedTypeRef
		case associatedTypeMetadataAccessor
		case associatedTypeWitnessTableAccessor
		case autoClosureType
		case boundGenericClass
		case boundGenericEnum
		case boundGenericStructure
		case builtinTypeName
		case cFunctionPointer
		case `class`
		case constructor
		case deallocator
		case declContext
		case defaultArgumentInitializer
		case dependentAssociatedTypeRef
		case dependentGenericSignature
		case dependentGenericParamCount
		case dependentGenericConformanceRequirement
		case dependentGenericSameTypeRequirement
		case dependentGenericType
		case dependentMemberType
		case dependentGenericParamType
		case destructor
		case didSet
		case directness
		case dynamicAttribute
		case directMethodReferenceAttribute
		case dynamicSelf
		case `enum`
		case errorType
		case existentialMetatype
		case explicitClosure
		case `extension`
		case fieldOffset
		case fullTypeMetadata
		case function
		case functionSignatureSpecialization
		case functionSignatureSpecializationParam
		case functionSignatureSpecializationParamKind
		case functionSignatureSpecializationParamPayload
		case functionType
		case generics
		case genericProtocolWitnessTable
		case genericProtocolWitnessTableInstantiationFunction
		case genericSpecialization
		case genericSpecializationNotReAbstracted
		case genericSpecializationParam
		case genericType
		case genericTypeMetadataPattern
		case getter
		case global
		case globalGetter
		case identifier
		case index
		case iVarInitializer
		case iVarDestroyer
		case implConvention
		case implFunctionAttribute
		case implFunctionType
		case implicitClosure
		case implParameter
		case implResult
		case implErrorResult
		case inOut
		case infixOperator
		case initializer
		case lazyProtocolWitnessTableAccessor
		case lazyProtocolWitnessTableCacheVariable
		case localDeclName
		case materializeForSet
		case metatype
		case metatypeRepresentation
		case metaclass
		case module
		case nativeOwningAddressor
		case nativeOwningMutableAddressor
		case nativePinningAddressor
		case nativePinningMutableAddressor
		case nominalTypeDescriptor
		case nonObjCAttribute
		case nonVariadicTuple
		case number
		case objCAttribute
		case objCBlock
		case owningAddressor
		case owningMutableAddressor
		case partialApplyForwarder
		case partialApplyObjCForwarder
		case postfixOperator
		case prefixOperator
		case privateDeclName
		case `protocol`
		case protocolConformance
		case protocolDescriptor
		case protocolList
		case protocolWitness
		case protocolWitnessTable
		case protocolWitnessTableAccessor
		case qualifiedArchetype
		case reabstractionThunk
		case reabstractionThunkHelper
		case returnType
		case silBoxType
		case selfTypeRef
		case setter
		case specializationPassID
		case specializationIsFragile
		case `static`
		case structure
		case `subscript`
		case suffix
		case thinFunctionType
		case tupleElement
		case tupleElementName
		case type
		case typeAlias
		case typeList
		case typeMangling
		case typeMetadata
		case typeMetadataAccessFunction
		case typeMetadataLazyCache
		case uncurriedFunctionType
		case unmanaged
		case unowned
		case unsafeAddressor
		case unsafeMutableAddressor
		case valueWitness
		case valueWitnessTable
		case variable
		case variadicTuple
		case vTableAttribute
		case weak
		case willSet
		case witnessTableOffset
		case throwsAnnotation
		
		var isSimpleType: Bool {
			switch self {
			case .archetype: fallthrough
			case .archetypeRef: fallthrough
			case .associatedType: fallthrough
			case .associatedTypeRef: fallthrough
			case .boundGenericClass: fallthrough
			case .boundGenericEnum: fallthrough
			case .boundGenericStructure: fallthrough
			case .builtinTypeName: fallthrough
			case .class: fallthrough
			case .dependentGenericType: fallthrough
			case .dependentMemberType: fallthrough
			case .dependentGenericParamType: fallthrough
			case .dynamicSelf: fallthrough
			case .enum: fallthrough
			case .errorType: fallthrough
			case .existentialMetatype: fallthrough
			case .metatype: fallthrough
			case .metatypeRepresentation: fallthrough
			case .module: fallthrough
			case .nonVariadicTuple: fallthrough
			case .protocol: fallthrough
			case .qualifiedArchetype: fallthrough
			case .returnType: fallthrough
			case .selfTypeRef: fallthrough
			case .silBoxType: fallthrough
			case .structure: fallthrough
			case .tupleElementName: fallthrough
			case .type: fallthrough
			case .typeAlias: fallthrough
			case .typeList: fallthrough
			case .variadicTuple: return true
			default: return false
			}
		}
	}
}

let stdlibName = "Swift"
let objcModule = "__ObjC"
let cModule = "__C"

enum ValueWitnessKind: UInt32 {
	case allocateBuffer
	case assignWithCopy
	case assignWithTake
	case deallocateBuffer
	case destroy
	case destroyBuffer
	case initializeBufferWithCopyOfBuffer
	case initializeBufferWithCopy
	case initializeWithCopy
	case initializeBufferWithTake
	case initializeWithTake
	case projectBuffer
	case initializeBufferWithTakeOfBuffer
	case destroyArray
	case initializeArrayWithCopy
	case initializeArrayWithTakeFrontToBack
	case initializeArrayWithTakeBackToFront
	case storeExtraInhabitant
	case getExtraInhabitantIndex
	case getEnumTag
	case destructiveProjectEnumData
	
	var description: String {
		switch self {
		case .allocateBuffer: return "allocateBuffer"
		case .assignWithCopy: return "assignWithCopy"
		case .assignWithTake: return "assignWithTake"
		case .deallocateBuffer: return "deallocateBuffer"
		case .destroy: return "destroy"
		case .destroyBuffer: return "destroyBuffer"
		case .initializeBufferWithCopyOfBuffer: return "initializeBufferWithCopyOfBuffer"
		case .initializeBufferWithCopy: return "initializeBufferWithCopy"
		case .initializeWithCopy: return "initializeWithCopy"
		case .initializeBufferWithTake: return "initializeBufferWithTake"
		case .initializeWithTake: return "initializeWithTake"
		case .projectBuffer: return "projectBuffer"
		case .initializeBufferWithTakeOfBuffer: return "initializeBufferWithTakeOfBuffer"
		case .destroyArray: return "destroyArray"
		case .initializeArrayWithCopy: return "initializeArrayWithCopy"
		case .initializeArrayWithTakeFrontToBack: return "initializeArrayWithTakeFrontToBack"
		case .initializeArrayWithTakeBackToFront: return "initializeArrayWithTakeBackToFront"
		case .storeExtraInhabitant: return "storeExtraInhabitant"
		case .getExtraInhabitantIndex: return "getExtraInhabitantIndex"
		case .getEnumTag: return "getEnumTag"
		case .destructiveProjectEnumData: return "destructiveProjectEnumData"
		}
	}
}

enum FunctionSigSpecializationParamKind: UInt32 {
	case constantPropFunction = 0
	case constantPropGlobal = 1
	case constantPropInteger = 2
	case constantPropFloat = 3
	case constantPropString = 4
	case closureProp = 5
	case boxToValue = 6
	case boxToStack = 7
	case dead = 64
	case ownedToGuaranteed = 128
	case sroa = 256
}

enum SugarType {
	case none
	case optional
	case implicitlyUnwrappedOptional
	case array
	case dictionary
}

/// Rough adaptation of the pseudocode from 6.2 "Decoding procedure" in RFC3492
private func decodeSwiftPunycode(_ value: String) -> String {
	let input = value.unicodeScalars
	var output = [UnicodeScalar]()
	
	var pos = input.startIndex
	
	// Unlike RFC3492, Swift uses underscore for delimiting
	if let ipos = input.index(of: "_" as UnicodeScalar) {
		output.append(contentsOf: input[input.startIndex..<ipos].map { UnicodeScalar($0) })
		pos = input.index(ipos, offsetBy: 1)
	}
	
	// Magic numbers from RFC3492
	var n = 128
	var i = 0
	var bias = 72
	let symbolCount = 36
	let alphaCount = 26
	while pos != input.endIndex {
		let oldi = i
		var w = 1
		for k in stride(from: symbolCount, to: Int.max, by: symbolCount) {
			// Unlike RFC3492, Swift uses letters A-J for values 26-35
			let digit = input[pos] >= UnicodeScalar("a") ? Int(input[pos].value - UnicodeScalar("a").value) : Int((input[pos].value - UnicodeScalar("A").value) + UInt32(alphaCount))
			
			if pos != input.endIndex {
				pos = input.index(pos, offsetBy: 1)
			}
			
			i = i + (digit * w)
			let t = max(min(k - bias, alphaCount), 1)
			if (digit < t) {
				break
			}
			w = w * (symbolCount - t)
		}
		
		// Bias adaptation function
		var delta = (i - oldi) / ((oldi == 0) ? 700 : 2)
		delta = delta + delta / (output.count + 1)
		var k = 0
		while (delta > 455) {
			delta = delta / (symbolCount - 1)
			k = k + symbolCount
		}
		k += (symbolCount * delta) / (delta + symbolCount + 2)
		
		bias = k
		n = n + i / (output.count + 1)
		i = i % (output.count + 1)
		output.insert(UnicodeScalar(n), at: i)
		i += 1
	}
	return String(output.map { Character($0) })
}

