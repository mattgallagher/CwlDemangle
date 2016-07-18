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

public func demangleSwiftName(mangled: String) throws -> SwiftName {
	return try demangleSwiftName(Array<UnicodeScalar>(mangled.unicodeScalars))
}

public func demangleSwiftName(mangled: Array<UnicodeScalar>) throws -> SwiftName {
	var scanner = ScalarScanner(scalars: mangled, context: [SwiftName]())
	
	try scanner.matchString("_T")
	var children = [SwiftName]()
	
	switch (try scanner.readScalar(), try scanner.readScalar()) {
	case ("T", "S"):
		repeat {
			children.append(try demangleSpecializedAttribute(&scanner))
			scanner.context.removeAll()
		} while scanner.conditionalString("_TTS")
		try scanner.matchString("_T")
	case ("T", "o"): children.append(SwiftName(kind: .ObjCAttribute))
	case ("T", "O"): children.append(SwiftName(kind: .NonObjCAttribute))
	case ("T", "D"): children.append(SwiftName(kind: .DynamicAttribute))
	case ("T", "d"): children.append(SwiftName(kind: .DirectMethodReferenceAttribute))
	case ("T", "v"): children.append(SwiftName(kind: .VTableAttribute))
	default: try scanner.backtrack(2)
	}

	children.append(try demangleGlobal(&scanner))
	
	let remainder = scanner.remainder()
	if !remainder.isEmpty {
		children.append(SwiftName(kind: .Suffix, contents: .Name(remainder)))
	}
	
	return SwiftName(kind: .Global, children: children)
}

func demangleGlobal<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let c1 = try scanner.readScalar()
	let c2 = try scanner.readScalar()
	switch (c1, c2) {
	case ("M", "P"): return SwiftName(kind: .GenericTypeMetadataPattern, children: [try demangleType(&scanner)])
	case ("M", "a"): return SwiftName(kind: .TypeMetadataAccessFunction, children: [try demangleType(&scanner)])
	case ("M", "L"): return SwiftName(kind: .TypeMetadataLazyCache, children: [try demangleType(&scanner)])
	case ("M", "m"): return SwiftName(kind: .Metaclass, children: [try demangleType(&scanner)])
	case ("M", "n"): return SwiftName(kind: .NominalTypeDescriptor, children: [try demangleType(&scanner)])
	case ("M", "f"): return SwiftName(kind: .FullTypeMetadata, children: [try demangleType(&scanner)])
	case ("M", "p"): return SwiftName(kind: .ProtocolDescriptor, children: [try demangleProtocolName(&scanner)])
	case ("M", _):
		try scanner.backtrack()
		return SwiftName(kind: .TypeMetadata, children: [try demangleType(&scanner)])
	case ("P", "A"):
		return SwiftName(kind: scanner.conditionalScalar("o") ? .PartialApplyObjCForwarder : .PartialApplyForwarder, children: scanner.conditionalString("__T") ? [try demangleGlobal(&scanner)] : [])
	case ("P", _): throw scanner.unexpectedError()
	case ("t", _):
		try scanner.backtrack()
		return SwiftName(kind: .TypeMangling, children: [try demangleType(&scanner)])
	case ("w", _):
		let c3 = try scanner.readScalar()
		let value: UInt32
		switch (c2, c3) {
		case ("a", "l"): value = ValueWitnessKind.AllocateBuffer.rawValue
		case ("c", "a"): value = ValueWitnessKind.AssignWithCopy.rawValue
		case ("t", "a"): value = ValueWitnessKind.AssignWithTake.rawValue
		case ("d", "e"): value = ValueWitnessKind.DeallocateBuffer.rawValue
		case ("x", "x"): value = ValueWitnessKind.Destroy.rawValue
		case ("X", "X"): value = ValueWitnessKind.DestroyBuffer.rawValue
		case ("C", "P"): value = ValueWitnessKind.InitializeBufferWithCopyOfBuffer.rawValue
		case ("C", "p"): value = ValueWitnessKind.InitializeBufferWithCopy.rawValue
		case ("c", "p"): value = ValueWitnessKind.InitializeWithCopy.rawValue
		case ("C", "c"): value = ValueWitnessKind.InitializeArrayWithCopy.rawValue
		case ("T", "K"): value = ValueWitnessKind.InitializeBufferWithTakeOfBuffer.rawValue
		case ("T", "k"): value = ValueWitnessKind.InitializeBufferWithTake.rawValue
		case ("t", "k"): value = ValueWitnessKind.InitializeWithTake.rawValue
		case ("T", "t"): value = ValueWitnessKind.InitializeArrayWithTakeFrontToBack.rawValue
		case ("t", "T"): value = ValueWitnessKind.InitializeArrayWithTakeBackToFront.rawValue
		case ("p", "r"): value = ValueWitnessKind.ProjectBuffer.rawValue
		case ("X", "x"): value = ValueWitnessKind.DestroyArray.rawValue
		case ("x", "s"): value = ValueWitnessKind.StoreExtraInhabitant.rawValue
		case ("x", "g"): value = ValueWitnessKind.GetExtraInhabitantIndex.rawValue
		case ("u", "g"): value = ValueWitnessKind.GetEnumTag.rawValue
		case ("u", "p"): value = ValueWitnessKind.DestructiveProjectEnumData.rawValue
		default: throw scanner.unexpectedError()
		}
		return SwiftName(kind: .ValueWitness, children: [try demangleType(&scanner)], contents: .Index(value))
	case ("W", "V"): return SwiftName(kind: .ValueWitnessTable, children: [try demangleType(&scanner)])
	case ("W", "o"): return SwiftName(kind: .WitnessTableOffset, children: [try demangleEntity(&scanner)])
	case ("W", "v"): return SwiftName(kind: .FieldOffset, children: [SwiftName(kind: .Directness, contents: .Index(try scanner.readScalar() == "d" ? 0 : 1)), try demangleEntity(&scanner)])
	case ("W", "P"): return SwiftName(kind: .ProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner)])
	case ("W", "G"): return SwiftName(kind: .GenericProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner)])
	case ("W", "I"): return SwiftName(kind: .GenericProtocolWitnessTableInstantiationFunction, children: [try demangleProtocolConformance(&scanner)])
	case ("W", "l"): return SwiftName(kind: .LazyProtocolWitnessTableAccessor, children: [try demangleType(&scanner), try demangleProtocolConformance(&scanner)])
	case ("W", "L"): return SwiftName(kind: .LazyProtocolWitnessTableCacheVariable, children: [try demangleType(&scanner), try demangleProtocolConformance(&scanner)])
	case ("W", "a"): return SwiftName(kind: .ProtocolWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner)])
	case ("W", "t"): return SwiftName(kind: .AssociatedTypeMetadataAccessor, children: [try demangleProtocolConformance(&scanner), try demangleDeclName(&scanner)])
	case ("W", "T"): return SwiftName(kind: .AssociatedTypeWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner), try demangleDeclName(&scanner), try demangleProtocolName(&scanner)])
	case ("W", _): throw scanner.unexpectedError()
	case ("T","W"): return SwiftName(kind: .ProtocolWitness, children: [try demangleProtocolConformance(&scanner), try demangleEntity(&scanner)])
	case ("T", "R"): fallthrough
	case ("T", "r"): return SwiftName(kind: c2 == "R" ? SwiftName.Kind.ReabstractionThunkHelper : SwiftName.Kind.ReabstractionThunk, children: scanner.conditionalScalar("G") ? [try demangleGenericSignature(&scanner), try demangleType(&scanner), try demangleType(&scanner)] : [try demangleType(&scanner), try demangleType(&scanner)])
	default:
		try scanner.backtrack(2)
		return try demangleEntity(&scanner)
	}
}

func demangleSpecializedAttribute<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let c = try scanner.readScalar()
	var children = [SwiftName]()
	if scanner.conditionalScalar("q") {
		children.append(SwiftName(kind: .SpecializationIsFragile))
	}
	children.append(SwiftName(kind: .SpecializationPassID, contents: .Index(try scanner.readScalar().value - 48)))
	switch c {
	case "r": fallthrough
	case "g":
		while !scanner.conditionalScalar("_") {
			var parameterChildren = [SwiftName]()
			parameterChildren.append(try demangleType(&scanner))
			while !scanner.conditionalScalar("_") {
				parameterChildren.append(try demangleProtocolConformance(&scanner))
			}
			children.append(SwiftName(kind: .GenericSpecializationParam, children: parameterChildren))
		}
		return SwiftName(kind: c == "r" ? .GenericSpecializationNotReAbstracted : .GenericSpecialization, children: children)
	case "f":
		var count: UInt32 = 0
		while !scanner.conditionalScalar("_") {
			var paramChildren = [SwiftName]()
			let c = try scanner.readScalar()
			switch (c, try scanner.readScalar()) {
			case ("n", "_"): break
			case ("c", "p"): paramChildren.appendContentsOf(try demangleFuncSigSpecializationConstantProp(&scanner))
			case ("c", "l"):
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ClosureProp.rawValue)))
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents))
				while !scanner.conditionalScalar("_") {
					paramChildren.append(try demangleType(&scanner))
				}
			case ("i", "_"): fallthrough
			case ("k", "_"): paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(c == "i" ? FunctionSigSpecializationParamKind.BoxToValue.rawValue : FunctionSigSpecializationParamKind.BoxToStack.rawValue)))
			default:
				try scanner.backtrack(2)
				var value: UInt32 = 0
				value |= scanner.conditionalScalar("d") ? FunctionSigSpecializationParamKind.Dead.rawValue : 0
				value |= scanner.conditionalScalar("g") ? FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue : 0
				value |= scanner.conditionalScalar("s") ? FunctionSigSpecializationParamKind.SROA.rawValue : 0
				try scanner.matchScalar("_")
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(value)))
			}
			children.append(SwiftName(kind: .FunctionSignatureSpecializationParam, children: paramChildren, contents: .Index(count)))
			count += 1
		}
		return SwiftName(kind: .FunctionSignatureSpecialization, children: children)
	default: throw scanner.unexpectedError()
	}
}

func demangleFuncSigSpecializationConstantProp<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> [SwiftName] {
	switch (try scanner.readScalar(), try scanner.readScalar()) {
	case ("f", "r"):
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		try scanner.matchScalar("_")
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropFunction.rawValue))
		return [kind, name]
	case ("g", _):
		try scanner.backtrack()
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		try scanner.matchScalar("_")
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropGlobal.rawValue))
		return [kind, name]
	case ("i", _):
		try scanner.backtrack()
		let string = try scanner.readUntil("_")
		try scanner.matchScalar("_")
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropInteger.rawValue))
		return [kind, name]
	case ("f", "l"):
		let string = try scanner.readUntil("_")
		try scanner.matchScalar("_")
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropFloat.rawValue))
		return [kind, name]
	case ("s", "e"):
		var string: String
		switch try scanner.readScalar() {
		case "0": string = "u8"
		case "1": string = "u16"
		default: throw scanner.unexpectedError()
		}
		try scanner.matchScalar("v")
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		let encoding = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropString.rawValue))
		try scanner.matchScalar("_")
		return [kind, encoding, name]
	default: throw scanner.unexpectedError()
	}
}


func demangleProtocolConformance<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let type = try demangleType(&scanner)
	let prot = try demangleProtocolName(&scanner)
	let context = try demangleContext(&scanner)
	return SwiftName(kind: .ProtocolConformance, children: [type, prot, context])
}

func demangleProtocolName<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let name: SwiftName
	if scanner.conditionalScalar("S") {
		let index = try demangleSubstitutionIndex(&scanner)
		switch index.kind {
		case .Protocol: name = index
		case .Module: name = try demangleProtocolNameGivenContext(&scanner, context: index)
		default: throw scanner.unexpectedError()
		}
	} else if scanner.conditionalScalar("s") {
		let stdlib = SwiftName(kind: .Module, contents: .Name(stdlibName))
		name = try demangleProtocolNameGivenContext(&scanner, context: stdlib)
	} else {
		name = try demangleDeclarationName(&scanner, kind: .Protocol)
	}

	return SwiftName(kind: .Type, children: [name])
}

func demangleProtocolNameGivenContext<C>(inout scanner: ScalarScanner<C, [SwiftName]>, context: SwiftName) throws -> SwiftName {
	let name = try demangleDeclName(&scanner)
	let result = SwiftName(kind: .Protocol, children: [context, name])
	scanner.context.append(result)
	return result
}

func demangleEntity<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let isStatic = scanner.conditionalScalar("Z")
	
	let basicKind: SwiftName.Kind
	switch try scanner.readScalar() {
	case "F": basicKind = .Function
	case "v": basicKind = .Variable
	case "I": basicKind = .Initializer
	case "i": basicKind = .Subscript
	case "S": return try demangleSubstitutionIndex(&scanner)
	case "V": return try demangleDeclarationName(&scanner, kind: .Structure)
	case "O": return try demangleDeclarationName(&scanner, kind: .Enum)
	case "C": return try demangleDeclarationName(&scanner, kind: .Class)
	case "P": return try demangleDeclarationName(&scanner, kind: .Protocol)
	default: throw scanner.unexpectedError()
	}
	
	let context = try demangleContext(&scanner)
	let kind: SwiftName.Kind
	let hasType: Bool
	var name: SwiftName? = nil
	
	let c = try scanner.readScalar()
	switch c {
	case "D": (kind, hasType) = (.Deallocator, false)
	case "d": (kind, hasType) = (.Destructor, false)
	case "e": (kind, hasType) = (.IVarInitializer, false)
	case "E": (kind, hasType) = (.IVarDestroyer, false)
	case "C": (kind, hasType) = (.Allocator, true)
	case "c": (kind, hasType) = (.Constructor, true)
	case "a": fallthrough
	case "l":
		switch try scanner.readScalar() {
		case "O": (kind, hasType, name) = (c == "a" ? .OwningMutableAddressor : .OwningAddressor, true, try demangleDeclName(&scanner))
		case "o": (kind, hasType, name) = (c == "a" ? .NativeOwningMutableAddressor : .NativeOwningAddressor, true, try demangleDeclName(&scanner))
		case "p": (kind, hasType, name) = (c == "a" ? .NativePinningMutableAddressor : .NativePinningAddressor, true, try demangleDeclName(&scanner))
		case "u": (kind, hasType, name) = (c == "a" ? .UnsafeMutableAddressor : .UnsafeAddressor, true, try demangleDeclName(&scanner))
		default: throw scanner.unexpectedError()
		}
	case "g": (kind, hasType, name) = (.Getter, true, try demangleDeclName(&scanner))
	case "G": (kind, hasType, name) = (.GlobalGetter, true, try demangleDeclName(&scanner))
	case "s": (kind, hasType, name) = (.Setter, true, try demangleDeclName(&scanner))
	case "m": (kind, hasType, name) = (.MaterializeForSet, true, try demangleDeclName(&scanner))
	case "w": (kind, hasType, name) = (.WillSet, true, try demangleDeclName(&scanner))
	case "W": (kind, hasType, name) = (.DidSet, true, try demangleDeclName(&scanner))
	case "U": (kind, hasType, name) = (.ExplicitClosure, true, SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner))))
	case "u": (kind, hasType, name) = (.ImplicitClosure, true, SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner))))
	case "A" where basicKind == .Initializer: (kind, hasType, name) = (.DefaultArgumentInitializer, false, SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner))))
	case "i" where basicKind == .Initializer: (kind, hasType) = (.Initializer, false)
	case _ where basicKind == .Initializer: throw scanner.unexpectedError()
	default:
		try scanner.backtrack()
		(kind, hasType, name) = (basicKind, true, try demangleDeclName(&scanner))
	}
	
	var children = [context]
	if let n = name {
		children.append(n)
	}
	if hasType {
		children.append(try demangleType(&scanner))
	}
	let entity = SwiftName(kind: kind, children: children)
	return isStatic ? SwiftName(kind: .Static, children: [entity]) : entity
}

func demangleDeclarationName<C>(inout scanner: ScalarScanner<C, [SwiftName]>, kind: SwiftName.Kind) throws -> SwiftName {
	let result = SwiftName(kind: kind, children: [try demangleContext(&scanner), try demangleDeclName(&scanner)])
	scanner.context.append(result)
	return result
}

func demangleContext<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "E": return SwiftName(kind: .Extension, children: [try demangleModule(&scanner), try demangleContext(&scanner)])
	case "e":
		let module = try demangleModule(&scanner)
		let signature = try demangleGenericSignature(&scanner)
		let type = try demangleContext(&scanner)
		return SwiftName(kind: .Extension, children: [module, type, signature])
	case "S": return try demangleSubstitutionIndex(&scanner)
	case "s": return SwiftName(kind: .Module, children: [], contents: .Name(stdlibName))
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
		return try demangleEntity(&scanner)
	default:
		try scanner.backtrack()
		return try demangleModule(&scanner)
	}
}

func demangleModule<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "S": return try demangleSubstitutionIndex(&scanner)
	case "s": return SwiftName(kind: .Module, children: [], contents: .Name("Swift"))
	default:
		try scanner.backtrack()
		let module = try demangleIdentifier(&scanner, kind: .Module)
		scanner.context.append(module)
		return module
	}
}

func swiftStdLibType(kind: SwiftName.Kind, named: String) -> SwiftName {
	return SwiftName(kind: kind, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name(named))])
}

func demangleSubstitutionIndex<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "o": return SwiftName(kind: .Module, contents: .Name(objcModule))
	case "C": return SwiftName(kind: .Module, contents: .Name(cModule))
	case "a": return swiftStdLibType(.Structure, named: "Array")
	case "b": return swiftStdLibType(.Structure, named: "Bool")
	case "c": return swiftStdLibType(.Structure, named: "UnicodeScalar")
	case "d": return swiftStdLibType(.Structure, named: "Double")
	case "f": return swiftStdLibType(.Structure, named: "Float")
	case "i": return swiftStdLibType(.Structure, named: "Int")
	case "P": return swiftStdLibType(.Structure, named: "UnsafePointer")
	case "p": return swiftStdLibType(.Structure, named: "UnsafeMutablePointer")
	case "q": return swiftStdLibType(.Enum, named: "Optional")
	case "Q": return swiftStdLibType(.Enum, named: "ImplicitlyUnwrappedOptional")
	case "R": return swiftStdLibType(.Structure, named: "UnsafeBufferPointer")
	case "r": return swiftStdLibType(.Structure, named: "UnsafeMutableBufferPointer")
	case "S": return swiftStdLibType(.Structure, named: "String")
	case "u": return swiftStdLibType(.Structure, named: "UInt")
	default:
		try scanner.backtrack()
		let index = try demangleIndex(&scanner)
		if Int(index) >= scanner.context.count {
			throw scanner.unexpectedError()
		}
		return scanner.context[Int(index)]
	}
}

func demangleGenericSignature<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	var children = [SwiftName]()
	var c = try scanner.requirePeek()
	while c != "R" && c != "r" {
		children.append(SwiftName(kind: .DependentGenericParamCount, contents: .Index(scanner.conditionalScalar("z") ? 0 : (try demangleIndex(&scanner) + 1))))
		c = try scanner.requirePeek()
	}
	if children.isEmpty {
		children.append(SwiftName(kind: .DependentGenericParamCount, contents: .Index(1)))
	}
	if !scanner.conditionalScalar("r") {
		try scanner.matchScalar("R")
		while !scanner.conditionalScalar("r") {
			children.append(try demangleGenericRequirement(&scanner))
		}
	}
	return SwiftName(kind: .DependentGenericSignature, children: children)
}

func demangleGenericRequirement<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let constrainedType = try demangleConstrainedType(&scanner)
	if scanner.conditionalScalar("z") {
		return SwiftName(kind: .DependentGenericSameTypeRequirement, children: [constrainedType, try demangleType(&scanner)])
	}
	let c = try scanner.requirePeek()
	let constraint: SwiftName
	if c == "C" {
		constraint = try demangleType(&scanner)
	} else if c == "S" {
		try scanner.matchScalar("S")
		let index = try demangleSubstitutionIndex(&scanner)
		let typename: SwiftName
		switch index.kind {
		case .Protocol: fallthrough
		case .Class: typename = index
		case .Module: typename = try demangleProtocolNameGivenContext(&scanner, context: index)
		default: throw scanner.unexpectedError()
		}
		constraint = SwiftName(kind: .Type, children: [typename])
	} else {
		constraint = try demangleProtocolName(&scanner)
	}
	return SwiftName(kind: .DependentGenericConformanceRequirement, children: [constrainedType, constraint])
}

func demangleConstrainedType<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("w") {
		return try demangleAssociatedTypeSimple(&scanner)
	} else if scanner.conditionalScalar("W") {
		return try demangleAssociatedTypeCompound(&scanner)
	}
	return try demangleGenericParamIndex(&scanner)
}

func demangleAssociatedTypeSimple<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let base = try demangleGenericParamIndex(&scanner)
	return try demangleDependentMemberTypeName(&scanner, base: SwiftName(kind: .Type, children: [base]))
}

func demangleAssociatedTypeCompound<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	var base = try demangleGenericParamIndex(&scanner)
	while !scanner.conditionalScalar("_") {
		let type = SwiftName(kind: .Type, children: [base])
		base = try demangleDependentMemberTypeName(&scanner, base: type)
	}
	return base
}

func demangleGenericParamIndex<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let depth: UInt32
	let index: UInt32
	switch try scanner.readScalar() {
	case "d": (depth, index) = (try demangleIndex(&scanner) + 1, try demangleIndex(&scanner))
	case "x": (depth, index) = (0, 0)
	default:
		try scanner.backtrack()
		(depth, index) = (0, try demangleIndex(&scanner) + 1)
	}
	return SwiftName(kind: .DependentGenericParamType, children: [SwiftName(kind: .Index, contents: .Index(depth)), SwiftName(kind: .Index, contents: .Index(index))], contents: .Name(archetypeName(index, depth)))
}

func demangleDependentMemberTypeName<C>(inout scanner: ScalarScanner<C, [SwiftName]>, base: SwiftName) throws -> SwiftName {
	let associatedType: SwiftName
	if scanner.conditionalScalar("S") {
		associatedType = try demangleSubstitutionIndex(&scanner)
	} else {
		var prot: SwiftName? = nil
		if scanner.conditionalScalar("P") {
			prot = try demangleProtocolName(&scanner)
		}
		let at = try demangleIdentifier(&scanner, kind: .DependentAssociatedTypeRef)
		if let p = prot {
			var children = at.children
			children.append(p)
			associatedType = SwiftName(kind: at.kind, children: children, contents: at.contents)
		} else {
			associatedType = at
		}
		scanner.context.append(associatedType)
	}
	
	return SwiftName(kind: .DependentMemberType, children: [base, associatedType])
}

func demangleDeclName<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "L": return SwiftName(kind: .LocalDeclName, children: [SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner))), try demangleIdentifier(&scanner)])
	case "P": return SwiftName(kind: .PrivateDeclName, children: [try demangleIdentifier(&scanner), try demangleIdentifier(&scanner)])
	default:
		try scanner.backtrack()
		return try demangleIdentifier(&scanner)
	}
}

func demangleIndex<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> UInt32 {
	if scanner.conditionalScalar("_") {
		return 0
	}
	let value = UInt32(try scanner.readInt()) + 1
	try scanner.matchScalar("_")
	return value
}

func demangleType<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	let type: SwiftName
	switch try scanner.readScalar() {
	case "B":
		switch try scanner.readScalar() {
		case "b": type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.BridgeObject"))
		case "B": type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.UnsafeValueBuffer"))
		case "f":
			let size = try scanner.readInt()
			try scanner.matchScalar("_")
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Float\(size)"))
		case "i":
			let size = try scanner.readInt()
			try scanner.matchScalar("_")
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Int\(size)"))
		case "v":
			let elements = try scanner.readInt()
			try scanner.matchScalar("B")
			let name: String
			let size: String
			let c = try scanner.readScalar()
			switch c {
			case "p": (name, size) = ("xRawPointer", "")
			case "i": fallthrough
			case "f":
				(name, size) = (c == "i" ? "xInt" : "xFloat", try "\(scanner.readInt())")
				try scanner.matchScalar("_")
			default: throw scanner.unexpectedError()
			}
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Vec\(elements)\(name)\(size)"))
		case "O": type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.UnknownObject"))
		case "o": type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.NativeObject"))
		case "p": type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.RawPointer"))
		case "w": type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Word"))
		default: throw scanner.unexpectedError()
		}
	case "a": type = try demangleDeclarationName(&scanner, kind: .TypeAlias)
	case "b": type = try demangleFunctionType(&scanner, kind: .ObjCBlock)
	case "c": type = try demangleFunctionType(&scanner, kind: .CFunctionPointer)
	case "D": type = SwiftName(kind: .DynamicSelf, children: [try demangleType(&scanner)])
	case "E":
		guard try scanner.readScalars(2) == "RR" else { throw scanner.unexpectedError() }
		type = SwiftName(kind: .ErrorType, children: [], contents: .Name(""))
	case "F": type = try demangleFunctionType(&scanner, kind: .FunctionType)
	case "f": type = try demangleFunctionType(&scanner, kind: .UncurriedFunctionType)
	case "G":
		let unboundType = try demangleType(&scanner)
		var children = [SwiftName]()
		while !scanner.conditionalScalar("_") {
			children.append(try demangleType(&scanner))
		}
		let kind: SwiftName.Kind
		switch unboundType.children.first?.kind {
		case .Some(.Class): kind = .BoundGenericClass
		case .Some(.Structure): kind = .BoundGenericStructure
		case .Some(.Enum): kind = .BoundGenericEnum
		default: throw scanner.unexpectedError()
		}
		type = SwiftName(kind: kind, children: [unboundType, SwiftName(kind: .TypeList, children: children)])
	case "X":
		let c = try scanner.readScalar()
		switch c {
		case "b": type = SwiftName(kind: .SILBoxType, children: [try demangleType(&scanner)])
		case "P" where scanner.conditionalScalar("M"): fallthrough
		case "M":
			let value: String
			switch try scanner.readScalar() {
			case "t": value = "@thick"
			case "T": value = "@thin"
			case "o": value = "@objc_metatype"
			default: throw scanner.unexpectedError()
			}
			type = SwiftName(kind: c == "P" ? .ExistentialMetatype : .Metatype, children: [SwiftName(kind: .MetatypeRepresentation, contents: .Name(value)), try demangleType(&scanner)])
		case "P":
			var children = [SwiftName]()
			while !scanner.conditionalScalar("_") {
				children.append(try demangleProtocolName(&scanner))
			}
			type = SwiftName(kind: .ProtocolList, children: [SwiftName(kind: .TypeList)])
		case "f": type = try demangleFunctionType(&scanner, kind: .ThinFunctionType)
		case "o": type = SwiftName(kind: .Unowned, children: [try demangleType(&scanner)])
		case "u": type = SwiftName(kind: .Unmanaged, children: [try demangleType(&scanner)])
		case "w": type = SwiftName(kind: .Weak, children: [try demangleType(&scanner)])
		case "F":
			var children = [SwiftName]()
			children.append(SwiftName(kind: .ImplConvention, contents: .Name(try demangleImplConvention(&scanner, kind: .ImplConvention))))
			if scanner.conditionalScalar("C") {
				let name: String
				switch try scanner.readScalar() {
				case "b": name = "@convention(block)"
				case "c": name = "@convention(c)"
				case "m": name = "@convention(method)"
				case "O": name = "@convention(objc_method)"
				case "w": name = "@convention(witness_method)"
				default: throw scanner.unexpectedError()
				}
				children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name(name)))
			}
			if scanner.conditionalScalar("N") {
				children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@noreturn")))
			}
			if scanner.conditionalScalar("G") {
				children.append(try demangleGenericSignature(&scanner))
			}
			try scanner.matchScalar("_")
			while !scanner.conditionalScalar("_") {
				children.append(try demangleImplParameterOrResult(&scanner, kind: .ImplParameter))
			}
			while !scanner.conditionalScalar("_") {
				children.append(try demangleImplParameterOrResult(&scanner, kind: .ImplResult))
			}
			type = SwiftName(kind: .ImplFunctionType, children: children)
		default: throw scanner.unexpectedError()
		}
	case "K": type = try demangleFunctionType(&scanner, kind: .AutoClosureType)
	case "M": type = SwiftName(kind: .Metatype, children: [try demangleType(&scanner)])
	case "P" where scanner.conditionalScalar("M"): type = SwiftName(kind: .ExistentialMetatype, children: [try demangleType(&scanner)])
	case "P":
		var children = [SwiftName]()
		while !scanner.conditionalScalar("_") {
			children.append(try demangleProtocolName(&scanner))
		}
		type = SwiftName(kind: .ProtocolList, children: [SwiftName(kind: .TypeList, children: children)])
	case "Q": type = try demangleArchetypeType(&scanner)
	case "q":
		let c = try scanner.requirePeek()
		if c != "d" && c != "_" && c < "0" && c > "9" {
			type = try demangleDependentMemberTypeName(&scanner, base: demangleType(&scanner))
		} else {
			type = try demangleGenericParamIndex(&scanner)
		}
	case "x": type = SwiftName(kind: .DependentGenericParamType, children: [SwiftName(kind: .Index, contents: .Index(0)), SwiftName(kind: .Index, contents: .Index(0))], contents: .Name(archetypeName(0, 0)))
	case "w": type = try demangleAssociatedTypeSimple(&scanner)
	case "W": type = try demangleAssociatedTypeCompound(&scanner)
	case "R": type = SwiftName(kind: .InOut, children: try demangleType(&scanner).children)
	case "S": type = try demangleSubstitutionIndex(&scanner)
	case "T": type = try demangleTuple(&scanner, variadic: false)
	case "t": type = try demangleTuple(&scanner, variadic: true)
	case "u": type = SwiftName(kind: .DependentGenericType, children: [try demangleGenericSignature(&scanner), try demangleType(&scanner)])
	case "C": type = try demangleDeclarationName(&scanner, kind: .Class)
	case "V": type = try demangleDeclarationName(&scanner, kind: .Structure)
	case "O": type = try demangleDeclarationName(&scanner, kind: .Enum)
	default: throw scanner.unexpectedError()
	}
	return SwiftName(kind: .Type, children: [type])
}

func demangleArchetypeType<C>(inout scanner: ScalarScanner<C, [SwiftName]>) throws -> SwiftName {
	switch try scanner.readScalar() {
	case "P": return SwiftName(kind: .SelfTypeRef, children: [try demangleProtocolName(&scanner)])
	case "Q":
		let result = SwiftName(kind: .AssociatedTypeRef, children: [try demangleArchetypeType(&scanner), try demangleIdentifier(&scanner)])
		scanner.context.append(result)
		return result
	case "S":
		let index = try demangleSubstitutionIndex(&scanner)
		if case .Protocol = index.kind {
			return SwiftName(kind: .SelfTypeRef, children: [index])
		} else {
			let result = SwiftName(kind: .AssociatedTypeRef, children: [index, try demangleIdentifier(&scanner)])
			scanner.context.append(result)
			return result
		}
	case "s":
		let root = SwiftName(kind: .Module, contents: .Name(stdlibName))
		let result = SwiftName(kind: .AssociatedTypeRef, children: [root, try demangleIdentifier(&scanner)])
		scanner.context.append(result)
		return result
	case "d":
		let depth = try demangleIndex(&scanner) + 1
		let index = try demangleIndex(&scanner)
		let depthChild = SwiftName(kind: .Index, contents: .Index(depth))
		let indexChild = SwiftName(kind: .Index, contents: .Index(index))
		return SwiftName(kind: .ArchetypeRef, children: [depthChild, indexChild], contents: .Name(archetypeName(index, depth)))
	case "q":
		let index = SwiftName(kind: .Index, contents: .Index(try demangleIndex(&scanner)))
		let context = try demangleContext(&scanner)
		let declContext = SwiftName(kind: .DeclContext, children: [context])
		return SwiftName(kind: .QualifiedArchetype, children: [index, declContext])
	default:
		try scanner.backtrack()
		let index = try demangleIndex(&scanner)
		let depthChild = SwiftName(kind: .Index, contents: .Index(0))
		let indexChild = SwiftName(kind: .Index, contents: .Index(index))
		return SwiftName(kind: .ArchetypeRef, children: [depthChild, indexChild], contents: .Name(archetypeName(index, 0)))
	}
}

func demangleImplConvention<C>(inout scanner: ScalarScanner<C, [SwiftName]>, kind: SwiftName.Kind) throws -> String {
	switch (try scanner.readScalar(), (kind == .ImplErrorResult ? .ImplResult : kind)) {
	case ("a", .ImplResult): return "@autoreleased"
	case ("d", .ImplConvention): return "@callee_unowned"
	case ("d", _): return "@unowned"
	case ("D", .ImplResult): return "@unowned_inner_pointer"
	case ("g", .ImplParameter): return "@guaranteed"
	case ("e", .ImplParameter): return "@deallocating"
	case ("g", .ImplConvention): return "@callee_guaranteed"
	case ("i", .ImplParameter): return "@in"
	case ("i", .ImplResult): return "@out"
	case ("l", .ImplParameter): return "@inout"
	case ("o", .ImplConvention): return "@callee_owned"
	case ("o", _): return "@owned"
	case ("t", .ImplConvention): return "@convention(thin)"
	default: throw scanner.unexpectedError()
	}
}

func demangleImplParameterOrResult<C>(inout scanner: ScalarScanner<C, [SwiftName]>, kind: SwiftName.Kind) throws -> SwiftName {
	var k: SwiftName.Kind
	if scanner.conditionalScalar("z") {
		if case .ImplResult = kind {
			k = .ImplErrorResult
		} else {
			throw scanner.unexpectedError()
		}
	} else {
		k = kind
	}
	
	let convention = try demangleImplConvention(&scanner, kind: k)
	let type = try demangleType(&scanner)
	let conventionNode = SwiftName(kind: .ImplConvention, contents: .Name(convention))
	return SwiftName(kind: k, children: [conventionNode, type])
}


func demangleTuple<C>(inout scanner: ScalarScanner<C, [SwiftName]>, variadic: Bool) throws -> SwiftName {
	var children = [SwiftName]()
	while !scanner.conditionalScalar("_") {
		var elementChildren = [SwiftName]()
		let peek = try scanner.requirePeek()
		if (peek >= "0" && peek <= "9") || peek == "o" {
			elementChildren.append(try demangleIdentifier(&scanner, kind: .TupleElementName))
		}
		elementChildren.append(try demangleType(&scanner))
		children.append(SwiftName(kind: .TupleElement, children: elementChildren))
	}
	return SwiftName(kind: variadic ? .VariadicTuple : .NonVariadicTuple, children: children)
}

func demangleFunctionType<C>(inout scanner: ScalarScanner<C, [SwiftName]>, kind: SwiftName.Kind) throws -> SwiftName {
	var children = [SwiftName]()
	if scanner.conditionalScalar("z") {
		children.append(SwiftName(kind: .ThrowsAnnotation))
	}
	children.append(SwiftName(kind: .ArgumentTuple, children: [try demangleType(&scanner)]))
	children.append(SwiftName(kind: .ReturnType, children: [try demangleType(&scanner)]))
	return SwiftName(kind: kind, children: children)
}

func demangleIdentifier<C>(inout scanner: ScalarScanner<C, [SwiftName]>, kind: SwiftName.Kind? = nil) throws -> SwiftName {
	let isPunycode = scanner.conditionalScalar("X")
	let k: SwiftName.Kind
	let isOperator: Bool
	if scanner.conditionalScalar("o") {
		guard kind == nil else { throw scanner.unexpectedError() }
		switch try scanner.readScalar() {
		case "p": (isOperator, k) = (true, .PrefixOperator)
		case "P": (isOperator, k) = (true, .PostfixOperator)
		case "i": (isOperator, k) = (true, .InfixOperator)
		default: throw scanner.unexpectedError()
		}
	} else {
		(isOperator, k) = (false, kind ?? SwiftName.Kind.Identifier)
	}
	
	var identifier = try scanner.readScalars(scanner.readInt())
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

	return SwiftName(kind: k, children: [], contents: .Name(identifier))
}

func archetypeName(index: UInt32, _ depth: UInt32) -> String {
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
public enum ScalarScannerError: ErrorType {
	/// The scalar at the specified index doesn't match the expected grammar
	case Unexpected(at: Int)
	
	/// Expected `wanted` at offset `at`
	case MatchFailed(wanted: String, at: Int)
	
	/// Expected numerals at offset `at`
	case ExpectedInt(at: Int)
	
	/// Attempted to read `count` scalars from position `at` but hit the end of the sequence
	case EndedPrematurely(count: Int, at: Int)
	
	/// Unable to find search patter `wanted` at or after `after` in the sequence
	case SearchFailed(wanted: String, after: Int)
}

/// A structure for traversing a `String.UnicodeScalarView`. A `context` field is provided but is not used by the scanner (it is entirely for storage by the scanner's user).
public struct ScalarScanner<C: CollectionType, T where C.Generator.Element == UnicodeScalar, C.Index: BidirectionalIndexType, C.Index: Comparable> {
	// The underlying storage
	let scalars: C
	
	// Current scanning index
	var index: C.Index
	
	/// Entirely for user use
	public var context: T

	/// Construct from a String.UnicodeScalarView and a context value
	public init(scalars: C, context: T) {
		self.scalars = scalars
		self.index = self.scalars.startIndex
		self.context = context
	}
	
	// Private utility for getting the index as an Int (used in errors)
	var absoluteIndex: Int {
		var i = index
		var count = 0
		while i > scalars.startIndex {
			i = i.predecessor()
			count += 1
		}
		return count
	}
	
	/// Throw if the scalars at the current `index` don't match the scalars in `value`. Advance the `index` to the end of the match.
	public mutating func matchString(value: String) throws {
		index = try value.unicodeScalars.reduce(index) { i, scalar in
			if i == self.scalars.endIndex || scalar != self.scalars[i] {
				throw ScalarScannerError.MatchFailed(wanted: value, at: absoluteIndex)
			}
			return i.successor()
		}
	}
	
	/// Throw if the scalars at the current `index` don't match the scalars in `value`. Advance the `index` to the end of the match.
	public mutating func matchScalar(value: UnicodeScalar) throws {
		if index == scalars.endIndex || scalars[index] != value {
			throw ScalarScannerError.MatchFailed(wanted: String(value), at: absoluteIndex)
		}
		index = index.advancedBy(1)
	}
	
	/// Consume scalars from the contained collection until `scalar` is found. `index` is advanced to immediately after `scalar`. Throws if `scalar` is never found.
	public mutating func readUntil(scalar: UnicodeScalar) throws -> String {
		var string = ""
		var i = index
		while i != scalars.endIndex {
			let s = scalars[i]
			if s == scalar {
				break
			} else {
				string.append(s)
				i = i.successor()
			}
		}
		if i == scalars.endIndex {
			throw ScalarScannerError.SearchFailed(wanted: String(scalar), after: absoluteIndex)
		}
		index = i
		return string
	}
	
	/// Peeks at the scalar at the current `index`, testing it with function `f`. If `f` returns `true`, the scalar is appended to a `String` and the `index` increased. The `String` is returned at the end.
	public mutating func readWhileTrue(@noescape f: UnicodeScalar -> Bool) -> String {
		var string = ""
		while index != scalars.endIndex {
			if !f(scalars[index]) {
				break
			}
			string.append(scalars[index])
			index = index.advancedBy(1)
		}
		return string
	}
	
	/// Repeatedly peeks at the scalar at the current `index`, testing it with function `f`. If `f` returns `true`, the `index` increased. If `false`, the function returns.
	public mutating func skipWhileTrue(@noescape f: UnicodeScalar -> Bool) {
		while index != scalars.endIndex {
			if !f(scalars[index]) {
				return
			}
			index = index.advancedBy(1)
		}
	}
	
	/// Attempt to advance the `index` by count, returning `false` and `index` unchanged if `index` would advance past the end, otherwise returns `true` and `index` is advanced.
	public mutating func skip(count: Int = 1) throws {
		var i = index
		var c = count
		while c > 0 && i != scalars.endIndex {
			i = i.successor()
			c -= 1
		}
		if c > 0 {
			throw ScalarScannerError.EndedPrematurely(count: count, at: absoluteIndex)
		} else {
			index = i
		}
	}
	
	/// Attempt to advance the `index` by count, returning `false` and `index` unchanged if `index` would advance past the end, otherwise returns `true` and `index` is advanced.
	public mutating func backtrack(count: Int = 1) throws {
		var i = index
		var c = count
		while c > 0 && i != scalars.startIndex {
			i = i.predecessor()
			c -= 1
		}
		if c > 0 {
			throw ScalarScannerError.EndedPrematurely(count: -count, at: absoluteIndex)
		} else {
			index = i
		}
	}
	
	/// Returns all content after the current `index`. `index` is advanced to the end.
	public mutating func remainder() -> String {
		var string: String = ""
		while index != scalars.endIndex {
			string.append(scalars[index])
			index = index.successor()
		}
		return string
	}
	
	/// If the next scalars after the current `index` match `value`, advance over them and return `true`, otherwise, leave `index` unchanged and return `false`.
	public mutating func conditionalString(value: String) -> Bool {
		var i = index
		for c in value.unicodeScalars {
			if i == scalars.endIndex || c != scalars[i] {
				return false
			}
			i = i.successor()
		}
		index = i
		return true
	}
	
	/// If the next scalar after the current `index` match `value`, advance over it and return `true`, otherwise, leave `index` unchanged and return `false`.
	public mutating func conditionalScalar(value: UnicodeScalar) -> Bool {
		if index == scalars.endIndex || value != scalars[index] {
			return false
		}
		index = index.successor()
		return true
	}
	
	/// If the `index` is at the end, throw, otherwise, return the next scalar at the current `index` without advancing `index`.
	public func requirePeek() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: 1, at: absoluteIndex)
		}
		return scalars[index]
	}
	
	/// If `index` + `ahead` is within bounds, return the scalar at that location, otherwise return `nil`. The `index` will not be changed in any case.
	public func peek(ahead: Int = 0) -> UnicodeScalar? {
		var i = index
		var c = ahead
		while c > 0 && i != scalars.endIndex {
			i = i.successor()
			c -= 1
		}
		if i == scalars.endIndex {
			return nil
		}
		return scalars[i]
	}
	
	/// If the `index` is at the end, throw, otherwise, return the next scalar at the current `index`, advancing `index` by one.
	public mutating func readScalar() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: 1, at: absoluteIndex)
		}
		let result = scalars[index]
		index = index.successor()
		return result
	}
	
	/// Throws if scalar at the current `index` is not in the range `"0"` to `"9"`. Consume scalars `"0"` to `"9"` until a scalar outside that range is encountered. Return the integer representation of the value scanned, interpreted as a base 10 integer. `index` is advanced to the end of the number.
	public mutating func readInt() throws -> Int {
		var result = 0
		var i = index
		while i != scalars.endIndex && scalars[i] >= "0" && scalars[i] <= "9" {
			result = result * 10 + Int(scalars[i].value - UnicodeScalar("0").value)
			i = i.successor()
		}
		if i == index {
			throw ScalarScannerError.ExpectedInt(at: absoluteIndex)
		}
		index = i
		return result
	}
	
	/// Consume and return `count` scalars. `index` will be advanced by count. Throws if end of `scalars` occurs before consuming `count` scalars.
	public mutating func readScalars(count: Int) throws -> String {
		var result = String()
		result.reserveCapacity(count)
		var i = index
		for _ in 0..<count {
			if i == scalars.endIndex {
				throw ScalarScannerError.EndedPrematurely(count: count, at: absoluteIndex)
			}
			result.append(scalars[i])
			i = i.successor()
		}
		index = i
		return result
	}

	/// Returns a throwable error capturing the current scanner progress point.
	public func unexpectedError() -> ScalarScannerError {
		return ScalarScannerError.Unexpected(at: absoluteIndex)
	}
}

extension Array {
	func at(index: Int) -> Element? {
		return self.indices.contains(index) ? self[index] : nil
	}
	func slice(from: Int, _ to: Int) -> ArraySlice<Element> {
		if from > to || from > self.endIndex || to < self.startIndex {
			return ArraySlice()
		} else {
			return self[max(from, self.startIndex)..<min(to, self.endIndex)]
		}
	}
}

extension OutputStreamType {
	mutating func write<S: SequenceType, T: SequenceType where T.Generator.Element == String?>(sequence: S, labels: T, @noescape render: (inout Self, S.Generator.Element) -> ()) {
		var lg = labels.generate()
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

	mutating func write<S: SequenceType>(sequence: S, prefix: String? = nil, separator: String? = nil, suffix: String? = nil, @noescape render: (inout Self, S.Generator.Element) -> ()) {
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

    mutating func write<T>(optional: Optional<T>, prefix: String? = nil, suffix: String? = nil, @noescape render: (inout Self, T) -> ()) {
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
}

struct PrintOptions: OptionSetType {
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
		case None
		case Index(UInt32)
		case Name(String)
		var description: String {
			switch self {
			case .None: return ""
			case .Index(let i): return i.description
			case .Name(let s): return s
			}
		}
	}
	public let contents: Contents
	
	init(kind: Kind, children: [SwiftName] = [], contents: Contents = .None) {
		self.kind = kind
		self.children = children
		self.contents = contents
	}
	
	public var description: String {
		var result = ""
		print(&result)
		return result
	}
	
	func printFunction<T: OutputStreamType>(inout output: T) {
		let startIndex = children.count == 3 ? 1 : 0
		let separator: String? = children.count == 3 ? " throws" : nil
		output.write(children[startIndex...(startIndex + 1)], separator: separator) { $1.print(&$0) }
	}

	func printEntity<T: OutputStreamType>(inout output: T, extraName: String, options: PrintOptions) {
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
	
	@warn_unused_result
	func indexFromChild(childIndex: Int = 1) -> UInt32 {
		return children.at(childIndex)?.indexFromContents() ?? 0
	}
	
	@warn_unused_result
	func indexFromContents() -> UInt32 {
		if case .Index(let i) = contents {
			return i
		} else {
			return 0
		}
	}
	
	@warn_unused_result
	func findSugar() -> SugarType {
		guard children.count != 1 || kind != .Type else { return children[0].findSugar() }
		guard children.count == 2 else { return .None }
		guard kind == .BoundGenericEnum || kind == .BoundGenericStructure else { return .None }
		
		guard let unboundType = children[0].children.first where unboundType.children.count > 1 else { return .None }
		let typeArgs = children[1]
		let c0 = unboundType.children[0]
		let c1 = unboundType.children[1]
		
		if kind == .BoundGenericEnum {
			if c1.kind == .Identifier, case .Name(let s) = c1.contents where s == "Optional" && typeArgs.children.count == 1 && c0.kind == .Module, case .Name(let m) = c0.contents where m == stdlibName {
				return .Optional
			}
			if c1.kind == .Identifier, case .Name(let s) = c1.contents where s == "ImplicitlyUnwrappedOptional" && typeArgs.children.count == 1 && c0.kind == .Module, case .Name(let m) = c0.contents where m == stdlibName {
				return .ImplicitlyUnwrappedOptional
			}
			return .None
		}
		if c1.kind == .Identifier, case .Name(let s) = c1.contents where s == "Array" && typeArgs.children.count == 1 && c0.kind == .Module, case .Name(let m) = c0.contents where m == stdlibName {
			return .Array
		}
		if c1.kind == .Identifier, case .Name(let s) = c1.contents where s == "Dictionary" && typeArgs.children.count == 2 && c0.kind == .Module, case .Name(let m) = c0.contents where m == stdlibName {
			return .Dictionary
		}
		return .None
	}
	
	func printBoundGenericNoSugar<T: OutputStreamType>(inout output: T) {
		children.at(0)?.print(&output)
		output.write(children.slice(1, children.endIndex), prefix: "<", separator: ", ", suffix: ">") { $1.print(&$0) }
	}
	
	func printBoundGeneric<T: OutputStreamType>(inout output: T) {
		guard children.count >= 2 else { return }
		guard children.count == 2 else { printBoundGenericNoSugar(&output); return }
		let sugarType = findSugar()
		switch sugarType {
		case .Optional: fallthrough
		case .ImplicitlyUnwrappedOptional:
			if let type = children.at(1)?.children.at(0) {
				let needParens = !type.kind.isSimpleType
				output.write(Optional(type), prefix: needParens ? "(" : nil, suffix: needParens ? ")" : nil) { $1.print(&$0) }
				output.write(sugarType == .Optional ? "?" : "!")
			}
		case .Array: fallthrough
		case .Dictionary:
			output.write(children[1].children, prefix: "[", separator: " : ", suffix: "]") { $1.print(&$0) }
		default: printBoundGenericNoSugar(&output)
		}
	}

	enum State { case Attrs, Inputs, Results }
	func printImplFunctionType<T: OutputStreamType>(inout output: T) {
		var curState: State = .Attrs
		childLoop: for c in children {
			if c.kind == .ImplParameter {
				switch curState {
				case .Inputs: output.write(", ")
				case .Attrs: output.write("(")
				case .Results: break childLoop
				}
				curState = .Inputs
				c.print(&output)
			} else if c.kind == .ImplResult || c.kind == .ImplErrorResult {
				switch curState {
				case .Inputs: output.write(") -> (")
				case .Attrs: output.write("() -> (")
				case .Results: output.write(", ")
				}
				curState = .Results
				c.print(&output)
			} else {
				c.print(&output)
				output.write(" ")
			}
		}
		switch curState {
		case .Inputs: output.write(") -> ()")
		case .Attrs: output.write("() -> ()")
		case .Results: output.write(")")
		}
	}
	
	func quotedString<T: OutputStreamType>(inout output: T, value: String) {
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
	
	func print<T: OutputStreamType>(inout output: T, _ options: PrintOptions = PrintOptions()) {
		switch kind {
		case .Static:
			output.write(children.at(0), prefix: "static ") { $1.print(&$0, options) }
		case .Directness:
			output.write(indexFromContents() == 1 ? "indirect " : "direct ")
		case .Extension:
			var index = 0
			output.write(children.prefix(3), labels: ["(extension in ", "):"]) { o, e in
				e.print(&o, index == 2 ? PrintOptions.asContext : options)
				index += 1
			}
		case .Variable: fallthrough
		case .Function: fallthrough
		case .Subscript:
			printEntity(&output, extraName: "", options: options.union(PrintOptions.hasTypeAndName))
		case .ExplicitClosure: fallthrough
		case .ImplicitClosure:
			printEntity(&output, extraName: "(\(kind == .ImplicitClosure ? "implicit " : "")closure #\((indexFromChild(1) + 1).description))", options: options)
		case .Global:
			output.write(children) { $1.print(&$0) }
		case .Suffix:
			output.write(" with unmangled suffix ")
			quotedString(&output, value: contents.description)
		case .Initializer:
			printEntity(&output, extraName: "(variable initialization expression)", options: options)
		case .DefaultArgumentInitializer:
			printEntity(&output, extraName: "(default argument \(indexFromChild(1)))", options: options)
		case .DeclContext:
			children.at(0)?.print(&output, options.subtract(PrintOptions.suppressType))
		case .Type:
			children.at(0)?.print(&output, options.subtract(PrintOptions.suppressType))
		case .TypeMangling:
			children.at(0)?.print(&output)
		case .Class: fallthrough
		case .Structure: fallthrough
		case .Enum: fallthrough
		case .Protocol: fallthrough
		case .TypeAlias:
			printEntity(&output, extraName: "", options: options.union(PrintOptions.hasName))
		case .LocalDeclName:
			output.write(children.at(1), prefix: "(") { $1.print(&$0) }
			output.write(" #")
			output.write((indexFromChild(0) + 1).description)
			output.write(")")
		case .PrivateDeclName:
			output.write(children.at(1), prefix: "(") { $1.print(&$0) }
			if let c = children.first {
				output.write(" in ")
				output.write(c.contents.description)
				output.write(")")
			}
		case .Module: fallthrough
		case .Identifier: fallthrough
		case .Index:
			output.write(contents.description)
		case .AutoClosureType:
			output.write("@autoclosure ")
			printFunction(&output)
		case .ThinFunctionType:
			output.write("@convention(thin) ")
			printFunction(&output)
		case .FunctionType: fallthrough
		case .UncurriedFunctionType:
			printFunction(&output)
		case .ArgumentTuple:
			let needParens: Bool
			if let k = children.at(0)?.children.at(0)?.kind where k == .VariadicTuple || k == .NonVariadicTuple {
				needParens = false
			} else {
				needParens = true
			}
			output.write(children, prefix: needParens ? "(" : nil, suffix: needParens ? ")" : nil) { $1.print(&$0) }
		case .NonVariadicTuple: fallthrough
		case .VariadicTuple:
			output.write(children, prefix: "(", separator: ", ", suffix: kind == .VariadicTuple ? "...)" : ")") { $1.print(&$0) }
		case .TupleElement:
			output.write(children.prefix(2)) { $1.print(&$0) }
		case .TupleElementName:
			output.write(contents.description)
			output.write(" : ")
		case .ReturnType:
			output.write(children.count == 0 ? [self] : children, prefix: " -> ") { children.count == 0 ? $0.write(contents.description) : $1.print(&$0) }
		case .Weak:
			output.write(children.at(0), prefix: "weak ") { $1.print(&$0) }
		case .Unowned:
			output.write(children.at(0), prefix: "unowned ") { $1.print(&$0) }
		case .Unmanaged:
			output.write(children.at(0), prefix: "unowned(unsafe) ") { $1.print(&$0) }
		case .InOut:
			output.write(children.at(0), prefix: "inout ") { $1.print(&$0) }
		case .NonObjCAttribute:
			output.write("@nonobjc ")
		case .ObjCAttribute:
			output.write("@objc ")
		case .DirectMethodReferenceAttribute:
			output.write("super ")
		case .DynamicAttribute:
			output.write("dynamic ")
		case .VTableAttribute:
			output.write("override ")
		case .FunctionSignatureSpecialization: fallthrough
		case .GenericSpecialization: fallthrough
		case .GenericSpecializationNotReAbstracted:
			let prefix: String
			switch kind {
			case .FunctionSignatureSpecialization: prefix = "function signature specialization <"
			case .GenericSpecialization: prefix = "generic specialization <"
			default: prefix = "generic not re-abstracted specialization <"
			}
			let cs = children.lazy.filter { (c: SwiftName) -> Bool in c.kind != .SpecializationPassID && (c.kind == .SpecializationIsFragile || c.children.count != 0) }
			output.write(cs, prefix: prefix, separator: ", ", suffix: "> of ") { $1.print(&$0) }
		case .SpecializationIsFragile: output.write("preserving fragile attribute")
		case .GenericSpecializationParam:
			var index = 0
			output.write(children) {
				if index == 1 {
					$0.write(" with ")
				} else if index != 0 {
					$0.write(" and ")
				}
				$1.print(&$0)
				index += 1
			}
		case .FunctionSignatureSpecializationParam:
			output.write("Arg[")
			output.write(contents.description)
			output.write("] = ")
			var index = 0
			while index < children.endIndex {
				switch FunctionSigSpecializationParamKind(rawValue: indexFromChild(index)) {
				case .Some(.BoxToValue): fallthrough
				case .Some(.BoxToStack):
					children.at(index)?.print(&output)
				case .Some(.ConstantPropFunction): fallthrough
				case .Some(.ConstantPropGlobal):
					if let t = children.at(index + 1)?.contents.description {
						output.write(children.at(index), prefix: "[", suffix: " : ") { $1.print(&$0) }
						output.write((try? demangleSwiftName(t).description) ?? t)
						output.write("]")
						index += 1
					}
				case .Some(.ConstantPropInteger): fallthrough
				case .Some(.ConstantPropFloat):
					output.write(children.slice(index, (index + 2)), prefix: "[", separator: " : ", suffix: "]") { $1.print(&$0) }
					index += 1
				case .Some(.ConstantPropString):
					output.write(children.slice(index, (index + 3)), labels: ["[", " : ", "'", "']"]) { $1.print(&$0) }
					index += 2
				case .Some(.ClosureProp):
					output.write(children.slice(index, (index + 2)), labels: ["[", " : ", ", Argument Types : ["]) { $1.print(&$0) }
					index += 2
					output.write(children.slice(index, children.endIndex), separator: ", ", suffix: "]") { $1.print(&$0) }
					index = children.endIndex
				default: children.at(index)?.print(&output)
				}
				index += 1
			}
		case .FunctionSignatureSpecializationParamPayload:
			output.write((try? demangleSwiftName(contents.description).description) ?? contents.description)
		case .FunctionSignatureSpecializationParamKind:
			let raw = indexFromContents()
			switch FunctionSigSpecializationParamKind(rawValue: raw) {
			case .Some(.BoxToValue): output.write("Value Promoted from Box")
			case .Some(.BoxToStack): output.write("Stack Promoted from Box")
			case .Some(.ConstantPropFunction): output.write("Constant Propagated Function")
			case .Some(.ConstantPropGlobal): output.write("Constant Propagated Global")
			case .Some(.ConstantPropInteger): output.write("Constant Propagated Integer")
			case .Some(.ConstantPropFloat): output.write("Constant Propagated Float")
			case .Some(.ConstantPropString): output.write("Constant Propagated String")
			case .Some(.ClosureProp): output.write("Closure Propagated")
			default:
				if raw & FunctionSigSpecializationParamKind.Dead.rawValue != 0 {
					output.write("Dead")
				}
				if raw & FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue != 0 {
					if raw & FunctionSigSpecializationParamKind.Dead.rawValue != 0 {
						output.write(" and ")
					}
					output.write("Owned To Guaranteed")
				}
				if raw & FunctionSigSpecializationParamKind.SROA.rawValue != 0 {
					if raw & (FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue | FunctionSigSpecializationParamKind.Dead.rawValue) != 0 {
						output.write(" and ")
					}
					output.write("Exploded")
				}
			}
		case .SpecializationPassID:
			output.write(contents.description)
		case .BuiltinTypeName:
			output.write(contents.description)
		case .Number:
			output.write(contents.description)
		case .InfixOperator:
			output.write(contents.description + " infix")
		case .PrefixOperator:
			output.write(contents.description + " prefix")
		case .PostfixOperator:
			output.write(contents.description + " postfix")
		case .LazyProtocolWitnessTableAccessor:
			output.write(children.prefix(2), labels: ["lazy protocol witness table accessor for type ", " and conformance "]) { $1.print(&$0) }
		case .LazyProtocolWitnessTableCacheVariable:
			output.write(children.prefix(2), labels: ["lazy protocol witness table cache variable for type ", " and conformance "]) { $1.print(&$0) }
		case .ProtocolWitnessTableAccessor:
			output.write(children.at(0), prefix: "protocol witness table accessor for ") { $1.print(&$0) }
		case .ProtocolWitnessTable:
			output.write(children.at(0), prefix: "protocol witness table for ") { $1.print(&$0) }
		case .GenericProtocolWitnessTable:
			output.write(children.at(0), prefix: "generic protocol witness table for ") { $1.print(&$0) }
		case .GenericProtocolWitnessTableInstantiationFunction:
			output.write(children.at(0), prefix: "instantiation function for generic protocol witness table for ") { $1.print(&$0) }
		case .ProtocolWitness:
			output.write([children.at(1), children.at(0)], labels: ["protocol witness for ", " in conformance "]) { $1?.print(&$0) }
		case .PartialApplyForwarder:
			output.write("partial apply forwarder")
			output.write(children.at(0), prefix: children.isEmpty ? nil : " for ") { $1.print(&$0) }
		case .PartialApplyObjCForwarder:
			output.write("partial apply ObjC forwarder")
			output.write(children.at(0), prefix: children.isEmpty ? nil : " for ") { $1.print(&$0) }
		case .FieldOffset:
			output.write(children.prefix(2), separator: "field offset for ") { $1.print(&$0) }
		case .ReabstractionThunk: fallthrough
		case .ReabstractionThunkHelper:
			output.write("reabstraction thunk ")
			output.write(kind == .ReabstractionThunkHelper ? "helper " : "")
			let dgs = children.lazy.filter({ $0.kind == .DependentGenericSignature }).first
			let firstLabel: String? = dgs == nil ? "from " : nil
			let labels: [String?] = (dgs == nil ? [firstLabel, " to "] : [firstLabel, " from ", " to "])
			output.write([dgs, children.at(children.count - 2), children.at(children.count - 1)].flatMap { $0 }, labels: labels) { $1.print(&$0) }
		case .GenericTypeMetadataPattern:
			output.write(children.at(0), prefix: "generic type metadata pattern for ") { $1.print(&$0) }
		case .Metaclass:
			output.write(children.at(0), prefix: "metaclass for ") { $1.print(&$0) }
		case .ProtocolDescriptor:
			output.write(children.at(0), prefix: "protocol descriptor for ") { $1.print(&$0) }
		case .FullTypeMetadata:
			output.write(children.at(0), prefix: "full type metadata for ") { $1.print(&$0) }
		case .TypeMetadata:
			output.write(children.at(0), prefix: "type metadata for ") { $1.print(&$0) }
		case .TypeMetadataAccessFunction:
			output.write(children.at(0), prefix: "type metadata accessor for ") { $1.print(&$0) }
		case .TypeMetadataLazyCache:
			output.write(children.at(0), prefix: "lazy cache variable for type metadata for ") { $1.print(&$0) }
		case .AssociatedTypeMetadataAccessor:
			output.write([children.at(1), children.at(0)], labels: ["associated type metadata accessor for ", " in "]) { $1?.print(&$0) }
		case .AssociatedTypeWitnessTableAccessor:
			output.write([children.at(1), children.at(2), children.at(0)], labels: ["associated type witness table accessor for ", " : ", " in "]) { $1?.print(&$0) }
		case .NominalTypeDescriptor:
			output.write(children.at(0), prefix: "nominal type descriptor for ") { $1.print(&$0) }
		case .ValueWitness:
			output.write(ValueWitnessKind(rawValue: indexFromContents())?.description ?? "")
			output.write(children.at(0), prefix: " value witness for ") { $1.print(&$0) }
		case .ValueWitnessTable:
			output.write(children.at(0), prefix: "value witness table for ") { $1.print(&$0) }
		case .WitnessTableOffset:
			output.write(children.at(0), prefix: "witness table offset for ") { $1.print(&$0) }
		case .BoundGenericClass: fallthrough
		case .BoundGenericStructure: fallthrough
		case .BoundGenericEnum:
			printBoundGeneric(&output)
		case .DynamicSelf:
			output.write("Self")
		case .CFunctionPointer:
			output.write("@convention(c) ")
			printFunction(&output)
		case .ObjCBlock:
			output.write("@convention(block) ")
			printFunction(&output)
		case .SILBoxType:
			output.write("@box ")
			children.at(0)?.print(&output)
		case .Metatype:
			guard let c0 = children.at(0) else { return }
			let suffix: String
			if c0.kind == .Type, let f = c0.children.first where f.kind == .ExistentialMetatype || f.kind == .ProtocolList {
				suffix = ".Protocol"
			} else {
				suffix = ".Type"
			}
			if let c1 = children.at(1) {
				output.write([c1, c0], separator: " ", suffix: suffix) { $1.print(&$0) }
			} else {
				output.write(Optional(c0), suffix: suffix) { $1.print(&$0) }
			}
		case .ExistentialMetatype:
			guard let c0 = children.at(0) else { return }
			if let c1 = children.at(1) {
				output.write([c1, c0], separator: " ", suffix: ".Type") { $1.print(&$0) }
			} else {
				output.write(Optional(c0), suffix: ".Type") { $1.print(&$0) }
			}
		case .MetatypeRepresentation:
			output.write(contents.description)
		case .ArchetypeRef:
			output.write(contents.description)
		case .AssociatedTypeRef:
			guard let c1 = children.at(1) else { return }
			output.write(children.at(0), suffix: ".") { $1.print(&$0) }
			output.write(c1.contents.description)
		case .SelfTypeRef:
			output.write(children.at(0), suffix: ".Self") { $1.print(&$0) }
		case .ProtocolList:
			guard let p = children.at(0) else { return }
			output.write(p.children, prefix: p.children.count != 1 ? "protocol<" : nil, separator: ", ", suffix: p.children.count != 1 ? ">" : nil) { $1.print(&$0) }
		case .Generics:
			output.write(children.lazy.filter { $0.kind == .Archetype }, prefix: "<", separator: ", ", suffix: ">") { $1.print(&$0) }
		case .Archetype:
			output.write(contents.description)
			output.write(children.at(0), prefix: children.isEmpty ? nil : " : ") { $1.print(&$0) }
		case .AssociatedType: return
		case .QualifiedArchetype:
			guard let c0 = children.at(0), let c1 = children.at(1) else { return }
			output.write("(archetype ")
			output.write(c0.contents.description)
			output.write(Optional(c1), prefix: " of ", suffix: ")") { $1.print(&$0) }
		case .GenericType:
			output.write([children.at(0), children.at(1)?.children.at(0)]) { $1?.print(&$0) }
		case .OwningAddressor:
			printEntity(&output, extraName: ".owningAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .OwningMutableAddressor:
			printEntity(&output, extraName: ".owningMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .NativeOwningAddressor:
			printEntity(&output, extraName: ".nativeOwningAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .NativeOwningMutableAddressor:
			printEntity(&output, extraName: ".nativeOwningMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .NativePinningAddressor:
			printEntity(&output, extraName: ".nativePinningAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .NativePinningMutableAddressor:
			printEntity(&output, extraName: ".nativePinningMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .UnsafeAddressor:
			printEntity(&output, extraName: ".unsafeAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .UnsafeMutableAddressor:
			printEntity(&output, extraName: ".unsafeMutableAddressor", options: options.union(PrintOptions.hasTypeAndName))
		case .GlobalGetter:
			printEntity(&output, extraName: ".getter", options: options.union(PrintOptions.hasTypeAndName))
		case .Getter:
			printEntity(&output, extraName: ".getter", options: options.union(PrintOptions.hasTypeAndName))
		case .Setter:
			printEntity(&output, extraName: ".setter", options: options.union(PrintOptions.hasTypeAndName))
		case .MaterializeForSet:
			printEntity(&output, extraName: ".materializeForSet", options: options.union(PrintOptions.hasTypeAndName))
		case .WillSet:
			printEntity(&output, extraName: ".willset", options: options.union(PrintOptions.hasTypeAndName))
		case .DidSet:
			printEntity(&output, extraName: ".didset", options: options.union(PrintOptions.hasTypeAndName))
		case .Allocator:
			printEntity(&output, extraName: ((children.count > 0 && children[0].kind == .Class) ? "__allocating_init" : "init"), options: options.union(PrintOptions.hasType))
		case .Constructor:
			printEntity(&output, extraName: "init", options: options.union(PrintOptions.hasType))
		case .Destructor:
			printEntity(&output, extraName: "deinit", options: options)
		case .Deallocator:
			printEntity(&output, extraName: ((children.count > 0 && children[0].kind == .Class) ? "__deallocating_deinit" : "deinit"), options: options)
		case .IVarInitializer:
			printEntity(&output, extraName: "__ivar_initializer", options: options)
		case .IVarDestroyer:
			printEntity(&output, extraName: "__ivar_destroyer", options: options)
		case .ProtocolConformance:
			output.write(children.prefix(3), labels: [nil, " : ", " in "]) { $1.print(&$0) }
		case .TypeList:
			output.write(children) { $1.print(&$0) }
		case .ImplConvention:
			output.write(contents.description)
		case .ImplFunctionAttribute:
			output.write(contents.description)
		case .ImplErrorResult:
			output.write("@error ")
			fallthrough
		case .ImplParameter: fallthrough
		case .ImplResult:
			output.write(children, separator: " ") { $1.print(&$0) }
		case .ImplFunctionType:
			printImplFunctionType(&output)
		case .ErrorType:
			output.write("<ERROR TYPE>")
		case .DependentGenericSignature:
			let filteredChildren = children.filter { $0.kind == .DependentGenericParamCount }.enumerate()
			var lastDepth = 0
			output.write(filteredChildren, prefix: "<", separator: "><") { o, t in
				lastDepth = t.index
				o.write(0..<t.element.indexFromContents(), separator: ", ") {
					output.write(archetypeName($1, UInt32(t.index)))
				}
			}
			let prefix: String? = (lastDepth + 1 < children.endIndex) ? " where " : nil
			let s = children.slice(lastDepth + 1, children.endIndex)
			output.write(s, prefix: prefix, separator: ", ", suffix: ">") { $1.print(&$0) }
		case .DependentGenericParamCount: return
		case .DependentGenericConformanceRequirement:
			output.write(children, separator: ": ") { $1.print(&$0) }
		case .DependentGenericSameTypeRequirement:
			output.write(children, separator: " == ") { $1.print(&$0) }
		case .DependentGenericParamType: output.write(contents.description)
		case .DependentGenericType:
			output.write(children, separator: " ") { $1.print(&$0) }
		case .DependentMemberType:
			output.write(children, separator: ".") { $1.print(&$0) }
		case .DependentAssociatedTypeRef: output.write(contents.description)
		case .ThrowsAnnotation:
			output.write(" throws ")
		}
	}
	
	func useColonForType(type: SwiftName) -> Bool {
		switch kind {
		case .Variable: fallthrough
		case .Initializer: fallthrough
		case .DefaultArgumentInitializer: fallthrough
		case .IVarInitializer: fallthrough
		case .Class: fallthrough
		case .Structure: fallthrough
		case .Enum: fallthrough
		case .Protocol: fallthrough
		case .TypeAlias: fallthrough
		case .OwningAddressor: fallthrough
		case .OwningMutableAddressor: fallthrough
		case .NativeOwningAddressor: fallthrough
		case .NativeOwningMutableAddressor: fallthrough
		case .NativePinningAddressor: fallthrough
		case .NativePinningMutableAddressor: fallthrough
		case .UnsafeAddressor: fallthrough
		case .UnsafeMutableAddressor: fallthrough
		case .GlobalGetter: fallthrough
		case .Getter: fallthrough
		case .Setter: fallthrough
		case .MaterializeForSet: fallthrough
		case .WillSet: fallthrough
		case .DidSet: return true
		case .Subscript: fallthrough
		case .Function: fallthrough
		case .ExplicitClosure: fallthrough
		case .ImplicitClosure: fallthrough
		case .Allocator: fallthrough
		case .Constructor: fallthrough
		case .Destructor: fallthrough
		case .Deallocator: fallthrough
		case .IVarDestroyer:
			var ty = type.children.first
			while case .Some(let t) = ty where t.kind == .GenericType || t.kind == .DependentGenericType {
				if t.children.count > 1 {
					ty = t.children[1].children.first
				}
			}
			if let t = ty where t.kind != .FunctionType && t.kind != .UncurriedFunctionType && t.kind != .CFunctionPointer && t.kind != .ThinFunctionType {
				return true
			} else {
				return false
			}
		default: return false
		}
	}

	public enum Kind {
		case Allocator
		case Archetype
		case ArchetypeRef
		case ArgumentTuple
		case AssociatedType
		case AssociatedTypeRef
		case AssociatedTypeMetadataAccessor
		case AssociatedTypeWitnessTableAccessor
		case AutoClosureType
		case BoundGenericClass
		case BoundGenericEnum
		case BoundGenericStructure
		case BuiltinTypeName
		case CFunctionPointer
		case Class
		case Constructor
		case Deallocator
		case DeclContext
		case DefaultArgumentInitializer
		case DependentAssociatedTypeRef
		case DependentGenericSignature
		case DependentGenericParamCount
		case DependentGenericConformanceRequirement
		case DependentGenericSameTypeRequirement
		case DependentGenericType
		case DependentMemberType
		case DependentGenericParamType
		case Destructor
		case DidSet
		case Directness
		case DynamicAttribute
		case DirectMethodReferenceAttribute
		case DynamicSelf
		case Enum
		case ErrorType
		case ExistentialMetatype
		case ExplicitClosure
		case Extension
		case FieldOffset
		case FullTypeMetadata
		case Function
		case FunctionSignatureSpecialization
		case FunctionSignatureSpecializationParam
		case FunctionSignatureSpecializationParamKind
		case FunctionSignatureSpecializationParamPayload
		case FunctionType
		case Generics
		case GenericProtocolWitnessTable
		case GenericProtocolWitnessTableInstantiationFunction
		case GenericSpecialization
		case GenericSpecializationNotReAbstracted
		case GenericSpecializationParam
		case GenericType
		case GenericTypeMetadataPattern
		case Getter
		case Global
		case GlobalGetter
		case Identifier
		case Index
		case IVarInitializer
		case IVarDestroyer
		case ImplConvention
		case ImplFunctionAttribute
		case ImplFunctionType
		case ImplicitClosure
		case ImplParameter
		case ImplResult
		case ImplErrorResult
		case InOut
		case InfixOperator
		case Initializer
		case LazyProtocolWitnessTableAccessor
		case LazyProtocolWitnessTableCacheVariable
		case LocalDeclName
		case MaterializeForSet
		case Metatype
		case MetatypeRepresentation
		case Metaclass
		case Module
		case NativeOwningAddressor
		case NativeOwningMutableAddressor
		case NativePinningAddressor
		case NativePinningMutableAddressor
		case NominalTypeDescriptor
		case NonObjCAttribute
		case NonVariadicTuple
		case Number
		case ObjCAttribute
		case ObjCBlock
		case OwningAddressor
		case OwningMutableAddressor
		case PartialApplyForwarder
		case PartialApplyObjCForwarder
		case PostfixOperator
		case PrefixOperator
		case PrivateDeclName
		case Protocol
		case ProtocolConformance
		case ProtocolDescriptor
		case ProtocolList
		case ProtocolWitness
		case ProtocolWitnessTable
		case ProtocolWitnessTableAccessor
		case QualifiedArchetype
		case ReabstractionThunk
		case ReabstractionThunkHelper
		case ReturnType
		case SILBoxType
		case SelfTypeRef
		case Setter
		case SpecializationPassID
		case SpecializationIsFragile
		case Static
		case Structure
		case Subscript
		case Suffix
		case ThinFunctionType
		case TupleElement
		case TupleElementName
		case Type
		case TypeAlias
		case TypeList
		case TypeMangling
		case TypeMetadata
		case TypeMetadataAccessFunction
		case TypeMetadataLazyCache
		case UncurriedFunctionType
		case Unmanaged
		case Unowned
		case UnsafeAddressor
		case UnsafeMutableAddressor
		case ValueWitness
		case ValueWitnessTable
		case Variable
		case VariadicTuple
		case VTableAttribute
		case Weak
		case WillSet
		case WitnessTableOffset
		case ThrowsAnnotation
		
		var isSimpleType: Bool {
			switch self {
			case .Archetype: fallthrough
			case .ArchetypeRef: fallthrough
			case .AssociatedType: fallthrough
			case .AssociatedTypeRef: fallthrough
			case .BoundGenericClass: fallthrough
			case .BoundGenericEnum: fallthrough
			case .BoundGenericStructure: fallthrough
			case .BuiltinTypeName: fallthrough
			case .Class: fallthrough
			case .DependentGenericType: fallthrough
			case .DependentMemberType: fallthrough
			case .DependentGenericParamType: fallthrough
			case .DynamicSelf: fallthrough
			case .Enum: fallthrough
			case .ErrorType: fallthrough
			case .ExistentialMetatype: fallthrough
			case .Metatype: fallthrough
			case .MetatypeRepresentation: fallthrough
			case .Module: fallthrough
			case .NonVariadicTuple: fallthrough
			case .Protocol: fallthrough
			case .QualifiedArchetype: fallthrough
			case .ReturnType: fallthrough
			case .SelfTypeRef: fallthrough
			case .SILBoxType: fallthrough
			case .Structure: fallthrough
			case .TupleElementName: fallthrough
			case .Type: fallthrough
			case .TypeAlias: fallthrough
			case .TypeList: fallthrough
			case .VariadicTuple: return true
			default: return false
			}
		}
	}
}

let stdlibName = "Swift"
let objcModule = "__ObjC"
let cModule = "__C"

enum ValueWitnessKind: UInt32 {
	case AllocateBuffer
	case AssignWithCopy
	case AssignWithTake
	case DeallocateBuffer
	case Destroy
	case DestroyBuffer
	case InitializeBufferWithCopyOfBuffer
	case InitializeBufferWithCopy
	case InitializeWithCopy
	case InitializeBufferWithTake
	case InitializeWithTake
	case ProjectBuffer
	case InitializeBufferWithTakeOfBuffer
	case DestroyArray
	case InitializeArrayWithCopy
	case InitializeArrayWithTakeFrontToBack
	case InitializeArrayWithTakeBackToFront
	case StoreExtraInhabitant
	case GetExtraInhabitantIndex
	case GetEnumTag
	case DestructiveProjectEnumData
	
	var description: String {
		switch self {
		case .AllocateBuffer: return "allocateBuffer"
		case .AssignWithCopy: return "assignWithCopy"
		case .AssignWithTake: return "assignWithTake"
		case .DeallocateBuffer: return "deallocateBuffer"
		case .Destroy: return "destroy"
		case .DestroyBuffer: return "destroyBuffer"
		case .InitializeBufferWithCopyOfBuffer: return "initializeBufferWithCopyOfBuffer"
		case .InitializeBufferWithCopy: return "initializeBufferWithCopy"
		case .InitializeWithCopy: return "initializeWithCopy"
		case .InitializeBufferWithTake: return "initializeBufferWithTake"
		case .InitializeWithTake: return "initializeWithTake"
		case .ProjectBuffer: return "projectBuffer"
		case .InitializeBufferWithTakeOfBuffer: return "initializeBufferWithTakeOfBuffer"
		case .DestroyArray: return "destroyArray"
		case .InitializeArrayWithCopy: return "initializeArrayWithCopy"
		case .InitializeArrayWithTakeFrontToBack: return "initializeArrayWithTakeFrontToBack"
		case .InitializeArrayWithTakeBackToFront: return "initializeArrayWithTakeBackToFront"
		case .StoreExtraInhabitant: return "storeExtraInhabitant"
		case .GetExtraInhabitantIndex: return "getExtraInhabitantIndex"
		case .GetEnumTag: return "getEnumTag"
		case .DestructiveProjectEnumData: return "destructiveProjectEnumData"
		}
	}
}

enum FunctionSigSpecializationParamKind: UInt32 {
	case ConstantPropFunction = 0
	case ConstantPropGlobal = 1
	case ConstantPropInteger = 2
	case ConstantPropFloat = 3
	case ConstantPropString = 4
	case ClosureProp = 5
	case BoxToValue = 6
	case BoxToStack = 7
	case Dead = 64
	case OwnedToGuaranteed = 128
	case SROA = 256
}

enum SugarType {
	case None
	case Optional
	case ImplicitlyUnwrappedOptional
	case Array
	case Dictionary
}

/// Rough adaptation of the pseudocode from 6.2 "Decoding procedure" in RFC3492
private func decodeSwiftPunycode(value: String) -> String {
	let input = value.unicodeScalars
	var output = [UnicodeScalar]()
	
	var pos = input.startIndex
	
	// Unlike RFC3492, Swift uses underscore for delimiting
	if let ipos = input.indexOf("_" as UnicodeScalar) {
		output.appendContentsOf(input[input.startIndex..<ipos].map { UnicodeScalar($0) })
		pos = ipos.advancedBy(1)
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
		for k in symbolCount.stride(to: Int.max, by: symbolCount) {
			// Unlike RFC3492, Swift uses letters A-J for values 26-35
			let digit = input[pos] >= UnicodeScalar("a") ? Int(input[pos].value - UnicodeScalar("a").value) : Int((input[pos].value - UnicodeScalar("A").value) + UInt32(alphaCount))
			
			if pos != input.endIndex {
				pos = pos.advancedBy(1)
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
		output.insert(UnicodeScalar(n), atIndex: i)
		i += 1
	}
	return String(output.map { Character($0) })
}

