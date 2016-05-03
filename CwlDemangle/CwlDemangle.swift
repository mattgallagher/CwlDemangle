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
	
	try scanner.requireMatch("_T")
	var children = [SwiftName]()
	
	if scanner.conditionalString("TS") {
		repeat {
			children.append(try demangleSpecializedAttribute(&scanner))
			scanner.context.removeAll()
		} while scanner.conditionalString("_TTS")
		try scanner.requireMatch("_T")
	} else if scanner.conditionalString("To") {
		children.append(SwiftName(kind: .ObjCAttribute))
	} else if scanner.conditionalString("TO") {
		children.append(SwiftName(kind: .NonObjCAttribute))
	} else if scanner.conditionalString("TD") {
		children.append(SwiftName(kind: .DynamicAttribute))
	} else if scanner.conditionalString("Td") {
		children.append(SwiftName(kind: .DirectMethodReferenceAttribute))
	} else if scanner.conditionalString("TV") {
		children.append(SwiftName(kind: .VTableAttribute))
	}

	children.append(try demangleGlobal(&scanner))
	
	let remainder = scanner.remainder()
	if !remainder.isEmpty {
		children.append(SwiftName(kind: .Suffix, contents: .Name(remainder)))
	}
	
	return SwiftName(kind: .Global, children: children)
}

func demangleGlobal(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("M") {
		if scanner.conditionalScalar("P") {
			return SwiftName(kind: .GenericTypeMetadataPattern, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("a") {
			return SwiftName(kind: .TypeMetadataAccessFunction, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("L") {
			return SwiftName(kind: .TypeMetadataLazyCache, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("m") {
			return SwiftName(kind: .Metaclass, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("n") {
			return SwiftName(kind: .NominalTypeDescriptor, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("f") {
			return SwiftName(kind: .FullTypeMetadata, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("p") {
			return SwiftName(kind: .ProtocolDescriptor, children: [try demangleProtocolName(&scanner)])
		} else{
			return SwiftName(kind: .TypeMetadata, children: [try demangleType(&scanner)])
		}
	} else if scanner.conditionalScalar("P") {
		try scanner.requireMatch("A")
		return SwiftName(kind: scanner.conditionalScalar("o") ? .PartialApplyObjCForwarder : .PartialApplyForwarder, children: scanner.conditionalString("__T") ? [try demangleGlobal(&scanner)] : [])
	} else if scanner.conditionalScalar("t") {
		return SwiftName(kind: .TypeMangling, children: [try demangleType(&scanner)])
	} else if scanner.conditionalScalar("w") {
		let twoChars = try scanner.requireScalars(2)
		let value: UInt32
		switch twoChars {
		case "al": value = ValueWitnessKind.AllocateBuffer.rawValue
		case "ca": value = ValueWitnessKind.AssignWithCopy.rawValue
		case "ta": value = ValueWitnessKind.AssignWithTake.rawValue
		case "de": value = ValueWitnessKind.DeallocateBuffer.rawValue
		case "xx": value = ValueWitnessKind.Destroy.rawValue
		case "XX": value = ValueWitnessKind.DestroyBuffer.rawValue
		case "CP": value = ValueWitnessKind.InitializeBufferWithCopyOfBuffer.rawValue
		case "Cp": value = ValueWitnessKind.InitializeBufferWithCopy.rawValue
		case "cp": value = ValueWitnessKind.InitializeWithCopy.rawValue
		case "Cc": value = ValueWitnessKind.InitializeArrayWithCopy.rawValue
		case "TK": value = ValueWitnessKind.InitializeBufferWithTakeOfBuffer.rawValue
		case "Tk": value = ValueWitnessKind.InitializeBufferWithTake.rawValue
		case "tk": value = ValueWitnessKind.InitializeWithTake.rawValue
		case "Tt": value = ValueWitnessKind.InitializeArrayWithTakeFrontToBack.rawValue
		case "tT": value = ValueWitnessKind.InitializeArrayWithTakeBackToFront.rawValue
		case "pr": value = ValueWitnessKind.ProjectBuffer.rawValue
		case "Xx": value = ValueWitnessKind.DestroyArray.rawValue
		case "xs": value = ValueWitnessKind.StoreExtraInhabitant.rawValue
		case "xg": value = ValueWitnessKind.GetExtraInhabitantIndex.rawValue
		case "ug": value = ValueWitnessKind.GetEnumTag.rawValue
		case "up": value = ValueWitnessKind.DestructiveProjectEnumData.rawValue
		default: throw scanner.unexpectedError()
		}
		return SwiftName(kind: .ValueWitness, children: [try demangleType(&scanner)], contents: .Index(value))
	} else if scanner.conditionalScalar("W") {
		if scanner.conditionalScalar("V") {
			return SwiftName(kind: .ValueWitnessTable, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("o") {
			return SwiftName(kind: .WitnessTableOffset, children: [try demangleEntity(&scanner)])
		} else if scanner.conditionalScalar("v") {
			let directness: UInt32
			if scanner.conditionalScalar("d") {
				directness = 0
			} else {
				try scanner.requireMatch("i")
				directness = 1
			}
			let child = SwiftName(kind: .Directness, contents: .Index(directness))
			return SwiftName(kind: .FieldOffset, children: [child, try demangleEntity(&scanner)])
		} else if scanner.conditionalScalar("P") {
			return SwiftName(kind: .ProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalScalar("G") {
			return SwiftName(kind: .GenericProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalScalar("I") {
			return SwiftName(kind: .GenericProtocolWitnessTableInstantiationFunction, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalScalar("l") {
			return SwiftName(kind: .LazyProtocolWitnessTableAccessor, children: [try demangleType(&scanner), try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalScalar("L") {
			return SwiftName(kind: .LazyProtocolWitnessTableCacheVariable, children: [try demangleType(&scanner), try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalScalar("a") {
			return SwiftName(kind: .ProtocolWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalScalar("t") {
			return SwiftName(kind: .AssociatedTypeMetadataAccessor, children: [try demangleProtocolConformance(&scanner), try demangleDeclName(&scanner)])
		} else if scanner.conditionalScalar("T") {
			return SwiftName(kind: .AssociatedTypeWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner), try demangleDeclName(&scanner), try demangleProtocolName(&scanner)])
		} else {
			throw scanner.unexpectedError()
		}
	} else if scanner.conditionalScalar("T") {
		if scanner.conditionalScalar("W") {
			return SwiftName(kind: .ProtocolWitness, children: [try demangleProtocolConformance(&scanner), try demangleEntity(&scanner)])
		}
		
		let kind: SwiftName.Kind
		if scanner.conditionalScalar("R") {
			kind = .ReabstractionThunkHelper
		} else {
			try scanner.requireMatch("r")
			kind = .ReabstractionThunk
		}
		var children = [SwiftName]()
		if scanner.conditionalScalar("G") {
			children.append(try demangleGenericSignature(&scanner))
		}
		children.append(try demangleType(&scanner))
		children.append(try demangleType(&scanner))
		return SwiftName(kind: kind, children: children)
	} else {
		return try demangleEntity(&scanner)
	}
}


func demangleSpecializedAttribute(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let c = try scanner.requireScalar()
	var children = [SwiftName]()
	if scanner.conditionalScalar("q") {
		children.append(SwiftName(kind: .SpecializationIsFragile))
	}
	children.append(SwiftName(kind: .SpecializationPassID, contents: .Index(try scanner.requireScalar().value - 48)))
	if c == "r" || c == "g" {
		while !scanner.conditionalScalar("_") {
			var parameterChildren = [SwiftName]()
			parameterChildren.append(try demangleType(&scanner))
			while !scanner.conditionalScalar("_") {
				parameterChildren.append(try demangleProtocolConformance(&scanner))
			}
			children.append(SwiftName(kind: .GenericSpecializationParam, children: parameterChildren))
		}
		return SwiftName(kind: c == "r" ? .GenericSpecializationNotReAbstracted : .GenericSpecialization, children: children)
	} else if c == "f" {
		var count: UInt32 = 0
		while !scanner.conditionalScalar("_") {
			var paramChildren = [SwiftName]()
			if scanner.conditionalString("n_") {
				// empty
			} else if scanner.conditionalString("cp") {
				paramChildren.appendContentsOf(try demangleFuncSigSpecializationConstantProp(&scanner))
			} else if scanner.conditionalString("cl") {
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ClosureProp.rawValue)))
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents))
				while !scanner.conditionalScalar("_") {
					paramChildren.append(try demangleType(&scanner))
				}
			} else if scanner.conditionalString("i_") {
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.BoxToValue.rawValue)))
			} else if scanner.conditionalString("k_") {
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.BoxToStack.rawValue)))
			} else {
				var value: UInt32 = 0
				if scanner.conditionalScalar("d") {
					value |= FunctionSigSpecializationParamKind.Dead.rawValue
				}
				if scanner.conditionalScalar("g") {
					value |= FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue
				}
				if scanner.conditionalScalar("s") {
					value |= FunctionSigSpecializationParamKind.SROA.rawValue
				}
				try scanner.requireMatch("_")
				paramChildren.append(SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(value)))
			}
			children.append(SwiftName(kind: .FunctionSignatureSpecializationParam, children: paramChildren, contents: .Index(count)))
			count += 1
		}
		return SwiftName(kind: .FunctionSignatureSpecialization, children: children)
	} else {
		throw scanner.unexpectedError()
	}
}

func demangleFuncSigSpecializationConstantProp(inout scanner: ScalarScanner<[SwiftName]>) throws -> [SwiftName] {
	if scanner.conditionalString("fr") {
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		try scanner.requireMatch("_")
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropFunction.rawValue))
		return [kind, name]
	} else if scanner.conditionalScalar("g") {
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		try scanner.requireMatch("_")
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropGlobal.rawValue))
		return [kind, name]
	} else if scanner.conditionalScalar("i") {
		var string: String = ""
		while !scanner.conditionalScalar("_") {
			string.append(try scanner.requireScalar())
		}
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropInteger.rawValue))
		return [kind, name]
	} else if scanner.conditionalScalar("i") {
		let string = try scanner.readUntil("_")
		try scanner.requireMatch("_")
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropInteger.rawValue))
		return [kind, name]
	} else if scanner.conditionalString("fl") {
		let string = try scanner.readUntil("_")
		try scanner.requireMatch("_")
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropFloat.rawValue))
		return [kind, name]
	} else if scanner.conditionalScalar("s") {
		try scanner.requireMatch("e")
		var string: String
		switch try scanner.requireScalar() {
		case "0": string = "u8"
		case "1": string = "u16"
		default: throw scanner.unexpectedError()
		}
		try scanner.requireMatch("v")
		let name = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		let encoding = SwiftName(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftName(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropString.rawValue))
		try scanner.requireMatch("_")
		return [kind, encoding, name]
	}
	throw scanner.unexpectedError()
}


func demangleProtocolConformance(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let type = try demangleType(&scanner)
	let prot = try demangleProtocolName(&scanner)
	let context = try demangleContext(&scanner)
	return SwiftName(kind: .ProtocolConformance, children: [type, prot, context])
}

func demangleProtocolName(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
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

func demangleProtocolNameGivenContext(inout scanner: ScalarScanner<[SwiftName]>, context: SwiftName) throws -> SwiftName {
	let name = try demangleDeclName(&scanner)
	let result = SwiftName(kind: .Protocol, children: [context, name])
	scanner.context.append(result)
	return result
}

func demangleEntity(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let isStatic = scanner.conditionalScalar("Z")
	
	let basicKind: SwiftName.Kind
	if scanner.conditionalScalar("F") {
		basicKind = .Function
	} else if scanner.conditionalScalar("v") {
		basicKind = .Variable
	} else if scanner.conditionalScalar("I") {
		basicKind = .Initializer
	} else if scanner.conditionalScalar("i") {
		basicKind = .Subscript
	} else if scanner.conditionalScalar("S") {
		return try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalScalar("V") {
		return try demangleDeclarationName(&scanner, kind: .Structure)
	} else if scanner.conditionalScalar("O") {
		return try demangleDeclarationName(&scanner, kind: .Enum)
	} else if scanner.conditionalScalar("C") {
		return try demangleDeclarationName(&scanner, kind: .Class)
	} else if scanner.conditionalScalar("P") {
		return try demangleDeclarationName(&scanner, kind: .Protocol)
	} else {
		throw scanner.unexpectedError()
	}
	
	let context = try demangleContext(&scanner)

	let kind: SwiftName.Kind
	let hasType: Bool
	var name: SwiftName? = nil
	
	if scanner.conditionalScalar("D") {
		kind = .Deallocator
		hasType = false
	} else if scanner.conditionalScalar("d") {
		kind = .Destructor
		hasType = false
	} else if scanner.conditionalScalar("e") {
		kind = .IVarInitializer
		hasType = false
	} else if scanner.conditionalScalar("E") {
		kind = .IVarDestroyer
		hasType = false
	} else if scanner.conditionalScalar("C") {
		kind = .Allocator
		hasType = true
	} else if scanner.conditionalScalar("c") {
		kind = .Constructor
		hasType = true
	} else if scanner.conditionalScalar("a") {
		if scanner.conditionalScalar("O") {
			kind = .OwningMutableAddressor
		} else if scanner.conditionalScalar("o") {
			kind = .NativeOwningMutableAddressor
		} else if scanner.conditionalScalar("p") {
			kind = .NativePinningMutableAddressor
		} else if scanner.conditionalScalar("u") {
			kind = .UnsafeMutableAddressor
		} else {
			throw scanner.unexpectedError()
		}
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("l") {
		if scanner.conditionalScalar("O") {
			kind = .OwningAddressor
		} else if scanner.conditionalScalar("o") {
			kind = .NativeOwningAddressor
		} else if scanner.conditionalScalar("p") {
			kind = .NativePinningAddressor
		} else if scanner.conditionalScalar("u") {
			kind = .UnsafeAddressor
		} else {
			throw scanner.unexpectedError()
		}
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("g") {
		kind = .Getter
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("G") {
		kind = .GlobalGetter
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("s") {
		kind = .Setter
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("m") {
		kind = .MaterializeForSet
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("w") {
		kind = .WillSet
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("W") {
		kind = .DidSet
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalScalar("U") {
		kind = .ExplicitClosure
		hasType = true
		name = SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
	} else if scanner.conditionalScalar("u") {
		kind = .ImplicitClosure
		hasType = true
		name = SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
	} else if case .Initializer = basicKind {
		if scanner.conditionalScalar("A") {
			kind = .DefaultArgumentInitializer
			name = SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
		} else if scanner.conditionalScalar("i") {
			kind = .Initializer
		} else {
			throw scanner.unexpectedError()
		}
		hasType = false
	} else {
		kind = basicKind
		hasType = true
		name = try demangleDeclName(&scanner)
	}
	
	var children = [context]
	if let n = name {
		children.append(n)
	}
	if hasType {
		children.append(try demangleType(&scanner))
	}
	let entity = SwiftName(kind: kind, children: children)
	if isStatic {
		return SwiftName(kind: .Static, children: [entity])
	} else {
		return entity
	}
}

func demangleDeclarationName(inout scanner: ScalarScanner<[SwiftName]>, kind: SwiftName.Kind) throws -> SwiftName {
	let result = SwiftName(kind: kind, children: [try demangleContext(&scanner), try demangleDeclName(&scanner)])
	scanner.context.append(result)
	return result
}

func demangleContext(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("E") {
		let module = try demangleModule(&scanner)
		let type = try demangleContext(&scanner)
		return SwiftName(kind: .Extension, children: [module, type])
	} else if scanner.conditionalScalar("e") {
		let module = try demangleModule(&scanner)
		let signature = try demangleGenericSignature(&scanner)
		let type = try demangleContext(&scanner)
		return SwiftName(kind: .Extension, children: [module, type, signature])
	} else if scanner.conditionalScalar("S") {
		return try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalScalar("s") {
		return SwiftName(kind: .Module, children: [], contents: .Name(stdlibName))
	}
	
	let c = try scanner.requirePeek()
	switch c {
	case "F": fallthrough
	case "I": fallthrough
	case "v": fallthrough
	case "P": fallthrough
	case "s": fallthrough
	case "Z": fallthrough
	case "C": fallthrough
	case "V": fallthrough
	case "O": return try demangleEntity(&scanner)
	default: break
	}
	
	return try demangleModule(&scanner)
}

func demangleModule(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("S") {
		return try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalScalar("s") {
		return SwiftName(kind: .Module, children: [], contents: .Name("Swift"))
	}
	let module = try demangleIdentifier(&scanner, kind: .Module)
	scanner.context.append(module)
	return module
}


func demangleSubstitutionIndex(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("o") {
		return SwiftName(kind: .Module, contents: .Name(objcModule))
	} else if scanner.conditionalScalar("C") {
		return SwiftName(kind: .Module, contents: .Name(cModule))
	} else if scanner.conditionalScalar("a") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("Array"))])
	} else if scanner.conditionalScalar("b") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("Bool"))])
	} else if scanner.conditionalScalar("c") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("UnicodeScalar"))])
	} else if scanner.conditionalScalar("d") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("Double"))])
	} else if scanner.conditionalScalar("f") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("Float"))])
	} else if scanner.conditionalScalar("i") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("Int"))])
	} else if scanner.conditionalScalar("P") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("UnsafePointer"))])
	} else if scanner.conditionalScalar("p") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("UnsafeMutablePointer"))])
	} else if scanner.conditionalScalar("q") {
		return SwiftName(kind: .Enum, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("Optional"))])
	} else if scanner.conditionalScalar("Q") {
		return SwiftName(kind: .Enum, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("ImplicitlyUnwrappedOptional"))])
	} else if scanner.conditionalScalar("R") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("UnsafeBufferPointer"))])
	} else if scanner.conditionalScalar("r") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("UnsafeMutableBufferPointer"))])
	} else if scanner.conditionalScalar("S") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("String"))])
	} else if scanner.conditionalScalar("u") {
		return SwiftName(kind: .Structure, children: [SwiftName(kind: .Module, contents: .Name(stdlibName)), SwiftName(kind: .Identifier, contents: .Name("UInt"))])
	}
	let index = try demangleIndex(&scanner)
	if Int(index) >= scanner.context.count {
		throw scanner.unexpectedError()
	}
	return scanner.context[Int(index)]
}

func demangleGenericSignature(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	var count: UInt32 = ~0
	var children = [SwiftName]()
	while try scanner.requirePeek() != "R" && scanner.requirePeek() != "r" {
		if scanner.conditionalScalar("z") {
			count = 0
		} else {
			count = try demangleIndex(&scanner) + 1
		}
		children.append(SwiftName(kind: .DependentGenericParamCount, contents: .Index(count)))
	}
	if count == ~0 {
		children.append(SwiftName(kind: .DependentGenericParamCount, contents: .Index(1)))
	}
	if !scanner.conditionalScalar("r") {
		try scanner.requireMatch("R")
		while !scanner.conditionalScalar("r") {
			children.append(try demangleGenericRequirement(&scanner))
		}
	}
	return SwiftName(kind: .DependentGenericSignature, children: children)
}

func demangleGenericRequirement(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let constrainedType = try demangleConstrainedType(&scanner)
	if scanner.conditionalScalar("z") {
		return SwiftName(kind: .DependentGenericSameTypeRequirement, children: [constrainedType, try demangleType(&scanner)])
	}
	let c = try scanner.requirePeek()
	let constraint: SwiftName
	if c == "C" {
		constraint = try demangleType(&scanner)
	} else if c == "S" {
		try scanner.requireMatch("S")
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

func demangleConstrainedType(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("w") {
		return try demangleAssociatedTypeSimple(&scanner)
	} else if scanner.conditionalScalar("W") {
		return try demangleAssociatedTypeCompound(&scanner)
	}
	return try demangleGenericParamIndex(&scanner)
}

func demangleAssociatedTypeSimple(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let base = try demangleGenericParamIndex(&scanner)
	return try demangleDependentMemberTypeName(&scanner, base: SwiftName(kind: .Type, children: [base]))
}

func demangleAssociatedTypeCompound(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	var base = try demangleGenericParamIndex(&scanner)
	while !scanner.conditionalScalar("_") {
		let type = SwiftName(kind: .Type, children: [base])
		base = try demangleDependentMemberTypeName(&scanner, base: type)
	}
	return base
}

func demangleGenericParamIndex(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let depth: UInt32
	let index: UInt32
	if scanner.conditionalScalar("d") {
		depth = try demangleIndex(&scanner) + 1
		index = try demangleIndex(&scanner)
	} else if scanner.conditionalScalar("x") {
		depth = 0
		index = 0
	} else {
		index = try demangleIndex(&scanner) + 1
		depth = 0
	}
	let depthChild = SwiftName(kind: .Index, contents: .Index(depth))
	let indexChild = SwiftName(kind: .Index, contents: .Index(index))
	return SwiftName(kind: .DependentGenericParamType, children: [depthChild, indexChild], contents: .Name(archetypeName(index, depth)))
}

func demangleDependentMemberTypeName(inout scanner: ScalarScanner<[SwiftName]>, base: SwiftName) throws -> SwiftName {
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

func demangleDeclName(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("L") {
		let discriminator = SwiftName(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
		let name = try demangleIdentifier(&scanner)
		return SwiftName(kind: .LocalDeclName, children: [discriminator, name])
	} else if scanner.conditionalScalar("P") {
		let discriminator = try demangleIdentifier(&scanner)
		let name = try demangleIdentifier(&scanner)
		return SwiftName(kind: .PrivateDeclName, children: [discriminator, name])
	}
	
	return try demangleIdentifier(&scanner)
}

func demangleIndex(inout scanner: ScalarScanner<[SwiftName]>) throws -> UInt32 {
	if scanner.conditionalScalar("_") {
		return 0
	}
	let value = UInt32(try scanner.requireInt()) + 1
	try scanner.requireMatch("_")
	return value
}

func demangleType(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	let type: SwiftName
	if scanner.conditionalScalar("B") {
		if scanner.conditionalScalar("b") {
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.BridgeObject"))
		} else if scanner.conditionalScalar("B") {
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.UnsafeValueBuffer"))
		} else if scanner.conditionalScalar("f") {
			let size = try scanner.requireInt()
			try scanner.requireMatch("_")
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Float\(size)"))
		} else if scanner.conditionalScalar("i") {
			let size = try scanner.requireInt()
			try scanner.requireMatch("_")
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Int\(size)"))
		} else if scanner.conditionalScalar("v") {
			let elements = try scanner.requireInt()
			try scanner.requireMatch("B")
			let name: String
			let size: String
			if scanner.conditionalScalar("i") {
				name = "xInt"
				size = try "\(scanner.requireInt())"
				try scanner.requireMatch("_")
			} else if scanner.conditionalScalar("f") {
				name = "xFloat"
				size = try "\(scanner.requireInt())"
				try scanner.requireMatch("_")
			} else {
				try scanner.requireMatch("p")
				name = "xRawPointer"
				size = ""
			}
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Vec\(elements)\(name)\(size)"))
		} else if scanner.conditionalScalar("O") {
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.UnknownObject"))
		} else if scanner.conditionalScalar("o") {
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.NativeObject"))
		} else if scanner.conditionalScalar("p") {
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.RawPointer"))
		} else if scanner.conditionalScalar("w") {
			type = SwiftName(kind: .BuiltinTypeName, contents: .Name("Builtin.Word"))
		} else {
			throw scanner.unexpectedError()
		}
	} else if scanner.conditionalScalar("a") {
		type = try demangleDeclarationName(&scanner, kind: .TypeAlias)
	} else if scanner.conditionalScalar("b") {
		type = try demangleFunctionType(&scanner, kind: .ObjCBlock)
	} else if scanner.conditionalScalar("c") {
		type = try demangleFunctionType(&scanner, kind: .CFunctionPointer)
	} else if scanner.conditionalScalar("D") {
		type = SwiftName(kind: .DynamicSelf, children: [try demangleType(&scanner)])
	} else if scanner.conditionalScalar("E") {
		guard try scanner.requireScalars(2) == "RR" else { throw scanner.unexpectedError() }
		type = SwiftName(kind: .ErrorType, children: [], contents: .Name(""))
	} else if scanner.conditionalScalar("F") {
		type = try demangleFunctionType(&scanner, kind: .FunctionType)
	} else if scanner.conditionalScalar("f") {
		type = try demangleFunctionType(&scanner, kind: .UncurriedFunctionType)
	} else if scanner.conditionalScalar("G") {
		let unboundType = try demangleType(&scanner)
		var children = [SwiftName]()
		while !scanner.conditionalScalar("_") {
			children.append(try demangleType(&scanner))
		}
		let typeList = SwiftName(kind: .TypeList, children: children)
		let kind: SwiftName.Kind
		switch unboundType.children.first?.kind {
		case .Some(.Class): kind = .BoundGenericClass
		case .Some(.Structure): kind = .BoundGenericStructure
		case .Some(.Enum): kind = .BoundGenericEnum
		default: throw scanner.unexpectedError()
		}
		type = SwiftName(kind: kind, children: [unboundType, typeList])
	} else if scanner.conditionalScalar("X") {
		if scanner.conditionalScalar("b") {
			type = SwiftName(kind: .SILBoxType, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("M") {
			let value: String
			if scanner.conditionalScalar("t") {
				value = "@thick"
			} else if scanner.conditionalScalar("T") {
				value = "@thin"
			} else {
				try scanner.requireMatch("o")
				value = "@objc_metatype"
			}
			let metatypeRepresentation = SwiftName(kind: .MetatypeRepresentation, contents: .Name(value))
			type = SwiftName(kind: .Metatype, children: [metatypeRepresentation, try demangleType(&scanner)])
		} else if scanner.conditionalScalar("P") {
			if scanner.conditionalScalar("M") {
				let value: String
				if scanner.conditionalScalar("t") {
					value = "@thick"
				} else if scanner.conditionalScalar("T") {
					value = "@thin"
				} else {
					try scanner.requireMatch("o")
					value = "@objc_metatype"
				}
				let metatypeRepresentation = SwiftName(kind: .MetatypeRepresentation, contents: .Name(value))
				type = SwiftName(kind: .ExistentialMetatype, children: [metatypeRepresentation, try demangleType(&scanner)])
			} else {
				var children = [SwiftName]()
				while !scanner.conditionalScalar("_") {
					children.append(try demangleProtocolName(&scanner))
				}
				let typeList = SwiftName(kind: .TypeList)
				type = SwiftName(kind: .ProtocolList, children: [typeList])
			}
		} else if scanner.conditionalScalar("f") {
			type = try demangleFunctionType(&scanner, kind: .ThinFunctionType)
		} else if scanner.conditionalScalar("o") {
			type = SwiftName(kind: .Unowned, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("u") {
			type = SwiftName(kind: .Unmanaged, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("w") {
			type = SwiftName(kind: .Weak, children: [try demangleType(&scanner)])
		} else if scanner.conditionalScalar("F") {
			var children = [SwiftName]()
			var attr: String
			if scanner.conditionalScalar("t") {
				attr = "@convention(thin)"
			} else {
				switch try scanner.requireScalar() {
				case "d": attr = "@callee_unowned"
				case "g": attr = "@callee_guaranteed"
				case "o": attr = "@callee_owned"
				default: attr = ""
				}
			}
			children.append(SwiftName(kind: .ImplConvention, contents: .Name(attr)))
			if scanner.conditionalScalar("C") {
				if scanner.conditionalScalar("b") {
					children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@convention(block)")))
				} else if scanner.conditionalScalar("c") {
					children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@convention(c)")))
				} else if scanner.conditionalScalar("m") {
					children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@convention(method)")))
				} else if scanner.conditionalScalar("O") {
					children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@convention(objc_method)")))
				} else if scanner.conditionalScalar("w") {
					children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@convention(witness_method)")))
				} else {
					throw scanner.unexpectedError()
				}
			}
			if scanner.conditionalScalar("N") {
				children.append(SwiftName(kind: .ImplFunctionAttribute, contents: .Name("@noreturn")))
			}
			if scanner.conditionalScalar("G") {
				children.append(try demangleGenericSignature(&scanner))
			}
			try scanner.requireMatch("_")
			while !scanner.conditionalScalar("_") {
				children.append(try demangleImplParameterOrResult(&scanner, kind: .ImplParameter))
			}
			while !scanner.conditionalScalar("_") {
				children.append(try demangleImplParameterOrResult(&scanner, kind: .ImplResult))
			}
			type = SwiftName(kind: .ImplFunctionType, children: children)
		} else {
			throw scanner.unexpectedError()
		}
	} else if scanner.conditionalScalar("K") {
		type = try demangleFunctionType(&scanner, kind: .AutoClosureType)
	} else if scanner.conditionalScalar("M") {
		type = SwiftName(kind: .Metatype, children: [try demangleType(&scanner)])
	} else if scanner.conditionalScalar("P") {
		if scanner.conditionalScalar("M") {
			type = SwiftName(kind: .ExistentialMetatype, children: [try demangleType(&scanner)])
		} else {
			var children = [SwiftName]()
			while !scanner.conditionalScalar("_") {
				children.append(try demangleProtocolName(&scanner))
			}
			let typeList = SwiftName(kind: .TypeList, children: children)
			type = SwiftName(kind: .ProtocolList, children: [typeList])
		}
	} else if scanner.conditionalScalar("Q") {
		type = try demangleArchetypeType(&scanner)
	} else if scanner.conditionalScalar("q") {
		let c = try scanner.requirePeek()
		if c != "d" && c != "_" && c < "0" && c > "9" {
			type = try demangleDependentMemberTypeName(&scanner, base: demangleType(&scanner))
		} else {
			type = try demangleGenericParamIndex(&scanner)
		}
	} else if scanner.conditionalScalar("x") {
		let depthChild = SwiftName(kind: .Index, contents: .Index(0))
		let indexChild = SwiftName(kind: .Index, contents: .Index(0))
		type = SwiftName(kind: .DependentGenericParamType, children: [depthChild, indexChild], contents: .Name(archetypeName(0, 0)))
	} else if scanner.conditionalScalar("w") {
		type = try demangleAssociatedTypeSimple(&scanner)
	} else if scanner.conditionalScalar("W") {
		type = try demangleAssociatedTypeCompound(&scanner)
	} else if scanner.conditionalScalar("R") {
		let t = try demangleType(&scanner)
		type = SwiftName(kind: .InOut, children: t.children)
	} else if scanner.conditionalScalar("S") {
		type = try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalScalar("T") {
		type = try demangleTuple(&scanner, variadic: false)
	} else if scanner.conditionalScalar("t") {
		type = try demangleTuple(&scanner, variadic: true)
	} else if scanner.conditionalScalar("u") {
		let sig = try demangleGenericSignature(&scanner)
		let sub = try demangleType(&scanner)
		type = SwiftName(kind: .DependentGenericType, children: [sig, sub])
	} else {
		let kind: SwiftName.Kind
		switch try scanner.requireScalar() {
		case "C": kind = .Class
		case "V": kind = .Structure
		case "O": kind = .Enum
		default: throw scanner.unexpectedError()
		}
		type = try demangleDeclarationName(&scanner, kind: kind)
	}
	return SwiftName(kind: .Type, children: [type])
}

func demangleArchetypeType(inout scanner: ScalarScanner<[SwiftName]>) throws -> SwiftName {
	if scanner.conditionalScalar("P") {
		return SwiftName(kind: .SelfTypeRef, children: [try demangleProtocolName(&scanner)])
	} else if scanner.conditionalScalar("Q") {
		let result = SwiftName(kind: .AssociatedTypeRef, children: [try demangleArchetypeType(&scanner), try demangleIdentifier(&scanner)])
		scanner.context.append(result)
		return result
	} else if scanner.conditionalScalar("S") {
		let index = try demangleSubstitutionIndex(&scanner)
		if case .Protocol = index.kind {
			return SwiftName(kind: .SelfTypeRef, children: [index])
		} else {
			let result = SwiftName(kind: .AssociatedTypeRef, children: [index, try demangleIdentifier(&scanner)])
			scanner.context.append(result)
			return result
		}
	} else if scanner.conditionalScalar("s") {
		let root = SwiftName(kind: .Module, contents: .Name(stdlibName))
		let result = SwiftName(kind: .AssociatedTypeRef, children: [root, try demangleIdentifier(&scanner)])
		scanner.context.append(result)
		return result
	} else if scanner.conditionalScalar("d") {
		let depth = try demangleIndex(&scanner) + 1
		let index = try demangleIndex(&scanner)
		let depthChild = SwiftName(kind: .Index, contents: .Index(depth))
		let indexChild = SwiftName(kind: .Index, contents: .Index(index))
		return SwiftName(kind: .ArchetypeRef, children: [depthChild, indexChild], contents: .Name(archetypeName(index, depth)))
	} else if scanner.conditionalScalar("q") {
		let index = SwiftName(kind: .Index, contents: .Index(try demangleIndex(&scanner)))
		let context = try demangleContext(&scanner)
		let declContext = SwiftName(kind: .DeclContext, children: [context])
		return SwiftName(kind: .QualifiedArchetype, children: [index, declContext])
	}

	let index = try demangleIndex(&scanner)
	let depthChild = SwiftName(kind: .Index, contents: .Index(0))
	let indexChild = SwiftName(kind: .Index, contents: .Index(index))
	return SwiftName(kind: .ArchetypeRef, children: [depthChild, indexChild], contents: .Name(archetypeName(index, 0)))
}

func demangleImplParameterOrResult(inout scanner: ScalarScanner<[SwiftName]>, kind: SwiftName.Kind) throws -> SwiftName {
	var k = kind
	if scanner.conditionalScalar("z") {
		if case .ImplResult = k {
			k = .ImplErrorResult
		} else {
			throw scanner.unexpectedError()
		}
	}
	
	let convention: String
	switch (try scanner.requireScalar(), k) {
	case ("a", .ImplResult): convention = "@autoreleased"
	case ("d", _): convention = "@unowned"
	case ("D", .ImplResult): convention = "@unowned_inner_pointer"
	case ("g", .ImplParameter): convention = "@guaranteed"
	case ("e", .ImplParameter): convention = "@deallocating"
	case ("i", .ImplParameter): convention = "@in"
	case ("i", .ImplResult): convention = "@out"
	case ("l", .ImplParameter): convention = "@inout"
	case ("o", _): convention = "@owned"
	default: throw scanner.unexpectedError()
	}
	let type = try demangleType(&scanner)
	let conventionNode = SwiftName(kind: .ImplConvention, contents: .Name(convention))
	return SwiftName(kind: k, children: [conventionNode, type])
}


func demangleTuple(inout scanner: ScalarScanner<[SwiftName]>, variadic: Bool) throws -> SwiftName {
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

func demangleFunctionType(inout scanner: ScalarScanner<[SwiftName]>, kind: SwiftName.Kind) throws -> SwiftName {
	var children = [SwiftName]()
	if scanner.conditionalScalar("z") {
		children.append(SwiftName(kind: .ThrowsAnnotation))
	}
	children.append(SwiftName(kind: .ArgumentTuple, children: [try demangleType(&scanner)]))
	children.append(SwiftName(kind: .ReturnType, children: [try demangleType(&scanner)]))
	return SwiftName(kind: kind, children: children)
}

func demangleIdentifier(inout scanner: ScalarScanner<[SwiftName]>, kind: SwiftName.Kind? = nil) throws -> SwiftName {
	let isPunycode: Bool
	if scanner.conditionalScalar("X") {
		isPunycode = true
	} else {
		isPunycode = false
	}

	let k: SwiftName.Kind
	let isOperator: Bool
	if scanner.conditionalScalar("o") {
		guard kind == nil else { throw scanner.unexpectedError() }
		isOperator = true
		
		if scanner.conditionalScalar("p") {
			k = .PrefixOperator
		} else if scanner.conditionalScalar("P") {
			k = .PostfixOperator
		} else if scanner.conditionalScalar("i") {
			k = .InfixOperator
		} else {
			throw scanner.unexpectedError()
		}
	} else {
		isOperator = false
		k = kind ?? SwiftName.Kind.Identifier
	}
	
	var identifier = try scanner.requireScalars(scanner.requireInt())
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
		result += "\(depth)"
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
public struct ScalarScanner<T> {
	public typealias Index = String.UnicodeScalarView.Index
	public typealias Collection = String.UnicodeScalarView
	
	/// Entirely for user use
	public var context: T

	let scalars: Array<UnicodeScalar>
	var index: Int
	
	/// Construct from a String.UnicodeScalarView and a context value
	public init(scalars: Array<UnicodeScalar>, context: T) {
		self.scalars = scalars
		self.index = self.scalars.startIndex
		self.context = context
	}
	
	/// Construct from a String and a context value
	public init(string: String, context: T) {
		self.scalars = Array(string.unicodeScalars)
		self.index = self.scalars.startIndex
		self.context = context
	}
	
	/// Throw if the scalars at the current `index` don't match the scalars in `value`. Advance the `index` to the end of the match.
	public mutating func requireMatch(value: String) throws {
		index = try value.unicodeScalars.reduce(index) { i, scalar in
			if i == self.scalars.endIndex || scalar != self.scalars[i] {
				throw ScalarScannerError.MatchFailed(wanted: value, at: self.scalars.startIndex.distanceTo(index))
			}
			return i.successor()
		}
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
			throw ScalarScannerError.SearchFailed(wanted: String(scalar), after: self.scalars.startIndex.distanceTo(index))
		}
		index = i
		return string
	}
	
	/// Peeks at the scalar at the current `index`, testing it with function `f`. If `f` returns `true`, the `index` increased.
	public mutating func skipWhileTrue(f: UnicodeScalar -> Bool) {
		while index != scalars.endIndex {
			if !f(scalars[index]) {
				break
			}
			index += 1
		}
	}
	
	/// Peeks at the scalar at the current `index`, testing it with function `f`. If `f` returns `true`, the scalar is appended to a `String` and the `index` increased. The `String` is returned at the end.
	public mutating func readWhileTrue(f: UnicodeScalar -> Bool) -> String {
		var string = ""
		while index != scalars.endIndex {
			if !f(scalars[index]) {
				break
			}
			string.append(scalars[index])
			index += 1
		}
		return string
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
			if i >= scalars.endIndex || c != scalars[i] {
				return false
			}
			i += 1
		}
		index = i
		return true
	}
	
	/// If the next scalar after the current `index` match `value`, advance over it and return `true`, otherwise, leave `index` unchanged and return `false`.
	public mutating func conditionalScalar(value: UnicodeScalar) -> Bool {
		if index >= scalars.endIndex || value != scalars[index] {
			return false
		}
		index += 1
		return true
	}
	
	/// If the `index` is at the end, throw, otherwise, return the next scalar at the current `index` without advancing `index`.
	public func requirePeek() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: 1, at: scalars.count)
		}
		return scalars[index]
	}
	
	/// If `index` + `ahead` is within bounds, return the scalar at that location, otherwise return `nil`. The `index` will not be changed in any case.
	public func conditionalPeek(ahead: Int = 0) -> UnicodeScalar? {
		let targetIndex = index + ahead
		if targetIndex >= scalars.endIndex || targetIndex < 0 {
			return nil
		}
		return scalars[targetIndex]
	}
	
	/// If the `index` is at the end, throw, otherwise, return the next scalar at the current `index`, advancing `index` by one.
	public mutating func requireScalar() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: 1, at: scalars.count)
		}
		let result = scalars[index]
		index = index.successor()
		return result
	}
	
	/// Throws if scalar at the current `index` is not in the range `"0"` to `"9"`. Consume scalars `"0"` to `"9"` until a scalar outside that range is encountered. Return the integer representation of the value scanned, interpreted as a base 10 integer. `index` is advanced to the end of the number.
	public mutating func requireInt() throws -> Int {
		var result = 0
		var i = index
		while i != scalars.endIndex && scalars[i] >= "0" && scalars[i] <= "9" {
			result = result * 10 + Int(scalars[i].value - UnicodeScalar("0").value)
			i = i.successor()
		}
		if i == index {
			throw ScalarScannerError.ExpectedInt(at: self.scalars.startIndex.distanceTo(index))
		}
		index = i
		return result
	}
	
	/// Consume and return `count` scalars. `index` will be advanced by count. Throws if end of `scalars` occurs before consuming `count` scalars.
	public mutating func requireScalars(count: Int) throws -> String {
		if index + count > scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: count, at: self.scalars.startIndex.distanceTo(index))
		}
		var result = String()
		result.reserveCapacity(count)
		for _ in 0..<count {
			result.append(scalars[index])
			index = index.successor()
		}
		return result
	}

	/// Returns a throwable error capturing the current scanner progress point.
	public func unexpectedError() -> ScalarScannerError {
		return ScalarScannerError.Unexpected(at: self.scalars.startIndex.distanceTo(index))
	}
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
			case .Index(let i): return "\(i)"
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
	
	func printChild<T: OutputStreamType>(inout output: T, index: Int, asContext: Bool = false, suppressType: Bool = false) {
		if index >= 0 && children.count > index {
			children[index].print(&output, asContext: asContext, suppressType: suppressType)
		}
	}
	
	func printFunction<T: OutputStreamType>(inout output: T) {
		let startIndex = children.count == 3 ? 1 : 0
		let suffix = children.count == 3 ? " throws" : ""
		printChild(&output, index: startIndex)
		output.write(suffix)
		printChild(&output, index: startIndex + 1)
	}

	func printEntity<T: OutputStreamType>(inout output: T, hasName: Bool, hasType: Bool, extraName: String, asContext: Bool, suppressType: Bool) {
		printChild(&output, index: 0, asContext: true)
		output.write(".")
		if hasType && !suppressType && asContext {
			output.write("(")
		}
		if hasName {
			printChild(&output, index: 1)
		}
		output.write(extraName)
		if hasType && !suppressType && children.count > (1 + (hasName ? 1 : 0)) {
			let type = children[1 + (hasName ? 1 : 0)]
			output.write(useColonForType(type) ? " : " : " ")
			type.print(&output)
		}
		if hasType && !suppressType && asContext {
			output.write(")")
		}
	}
	
	@warn_unused_result
	func indexFromChild(childIndex: Int = 1) -> UInt32 {
		let index: UInt32
		if children.count > childIndex, case .Index(let i) = children[childIndex].contents {
			index = i
		} else {
			index = 0
		}
		return index
	}
	
	@warn_unused_result
	func findSugar() -> SugarType {
		guard children.count != 1 || kind != .Type else { return children[0].findSugar() }
		guard children.count == 2 else { return .None }
		guard kind == .BoundGenericEnum || kind == .BoundGenericStructure else { return .None }
		
		guard let unboundType = children[0].children.first where unboundType.children.count > 1 else { return .None }
		let typeArgs = children[1]
		if kind == .BoundGenericEnum {
			if unboundType.children[1].kind == .Identifier, case .Name(let s) = unboundType.children[1].contents where s == "Optional" && typeArgs.children.count == 1 && unboundType.children[0].kind == .Module, case .Name(let m) = unboundType.children[0].contents where m == stdlibName {
				return .Optional
			}
			if unboundType.children[1].kind == .Identifier, case .Name(let s) = unboundType.children[1].contents where s == "ImplicitlyUnwrappedOptional" && typeArgs.children.count == 1 && unboundType.children[0].kind == .Module, case .Name(let m) = unboundType.children[0].contents where m == stdlibName {
				return .ImplicitlyUnwrappedOptional
			}
			return .None
		}
		if unboundType.children[1].kind == .Identifier, case .Name(let s) = unboundType.children[1].contents where s == "Array" && typeArgs.children.count == 1 && unboundType.children[0].kind == .Module, case .Name(let m) = unboundType.children[0].contents where m == stdlibName {
			return .Array
		}
		if unboundType.children[1].kind == .Identifier, case .Name(let s) = unboundType.children[1].contents where s == "Dictionary" && typeArgs.children.count == 2 && unboundType.children[0].kind == .Module, case .Name(let m) = unboundType.children[0].contents where m == stdlibName {
			return .Dictionary
		}
		return .None
	}
	
	func printBoundGenericNoSugar<T: OutputStreamType>(inout output: T) {
		guard children.count >= 2 else { return }
		printChild(&output, index: 0)
		output.write("<")
		for i in 1..<children.endIndex {
			if i != 1 {
				output.write(", ")
			}
			children[i].print(&output)
		}
		output.write(">")
	}
	
	func printBoundGeneric<T: OutputStreamType>(inout output: T) {
		guard children.count >= 2 else { return }
		guard children.count == 2 else { printBoundGenericNoSugar(&output); return }
		let sugarType = findSugar()
		switch sugarType {
		case .Optional where !children[0].children.isEmpty: fallthrough
		case .ImplicitlyUnwrappedOptional where !children[0].children.isEmpty:
			let type = children[1].children[0]
			let needParens = !type.kind.isSimpleType
			if needParens {
				output.write("(")
			}
			type.print(&output)
			if needParens {
				output.write(")")
			}
			output.write(sugarType == .Optional ? "?" : "!")
		case .Array where !children[1].children.isEmpty:
			let type = children[1].children[0]
			output.write("[")
			type.print(&output)
			output.write("]")
		case .Dictionary where children[1].children.count > 1:
			let keyType = children[1].children[0]
			let valueType = children[1].children[1]
			output.write("[")
			keyType.print(&output)
			output.write(" : ")
			valueType.print(&output)
			output.write("]")
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
	
	public func print<T: OutputStreamType>(inout output: T, asContext: Bool = false, suppressType: Bool = false) {
		switch kind {
		case .Static:
			output.write("static ")
			printChild(&output, index: 0, asContext: asContext, suppressType: suppressType)
		case .Directness:
			if case .Index(let i) = contents where i == 1 {
				output.write("indirect ")
			} else {
				output.write("direct ")
			}
		case .Extension:
			output.write("(extension in ")
			printChild(&output, index: 0, asContext: true)
			output.write("):")
			printChild(&output, index: 1, asContext: asContext)
			printChild(&output, index: 2, asContext: true)
		case .Variable: fallthrough
		case .Function: fallthrough
		case .Subscript: printEntity(&output, hasName: true, hasType: true, extraName: "", asContext: asContext, suppressType: suppressType)
		case .ExplicitClosure: fallthrough
		case .ImplicitClosure:
			var extraName: String = "("
			if case .ImplicitClosure = kind {
				extraName += "implicit "
			}
			extraName += "closure #\(indexFromChild(1) + 1))"
			printEntity(&output, hasName: false, hasType: false, extraName: extraName, asContext: asContext, suppressType: suppressType)
		case .Global: children.forEach { $0.print(&output) }
		case .Suffix:
			output.write(" with unmangled suffix ")
			quotedString(&output, value: contents.description)
		case .Initializer: printEntity(&output, hasName: false, hasType: false, extraName: "(variable initialization expression)", asContext: asContext, suppressType: suppressType)
		case .DefaultArgumentInitializer: printEntity(&output, hasName: false, hasType: false, extraName: "(default argument \(indexFromChild(1)))", asContext: asContext, suppressType: suppressType)
		case .DeclContext: printChild(&output, index: 0, asContext: asContext)
		case .Type: printChild(&output, index: 0, asContext: asContext)
		case .TypeMangling: printChild(&output, index: 0)
		case .Class: fallthrough
		case .Structure: fallthrough
		case .Enum: fallthrough
		case .Protocol: fallthrough
		case .TypeAlias: printEntity(&output, hasName: true, hasType: false, extraName: "", asContext: asContext, suppressType: suppressType)
		case .LocalDeclName:
			output.write("(")
			printChild(&output, index: 1)
			output.write(" #\(indexFromChild(0) + 1))")
		case .PrivateDeclName:
			output.write("(")
			printChild(&output, index: 1)
			output.write(" in \(children.first?.contents.description ?? String()))")
		case .Module: fallthrough
		case .Identifier: fallthrough
		case .Index: output.write(contents.description)
		case .AutoClosureType:
			output.write("@autoclosure ")
			printFunction(&output)
		case .ThinFunctionType:
			output.write("@convention(thin) ")
			printFunction(&output)
		case .FunctionType: fallthrough
		case .UncurriedFunctionType: printFunction(&output)
		case .ArgumentTuple:
			let needParens = children.count != 1 || (children[0].children.count != 0 && children[0].children[0].kind != .VariadicTuple && children[0].children[0].kind != .NonVariadicTuple)
			output.write(needParens ? "(" : "")
			children.forEach { $0.print(&output) }
			output.write(needParens ? ")" : "")
		case .NonVariadicTuple: fallthrough
		case .VariadicTuple:
			output.write("(")
			for i in children.indices {
				if i != 0 {
					output.write(", ")
				}
				children[i].print(&output)
			}
			output.write(kind == .VariadicTuple ? "...)" : ")")
		case .TupleElement:
			if children.count == 1 {
				printChild(&output, index: 0)
			} else if children.count == 2 {
				printChild(&output, index: 0)
				printChild(&output, index: 1)
			}
		case .TupleElementName:
			output.write(contents.description)
			output.write(" : ")
		case .ReturnType:
			if children.count == 0 {
				output.write(" -> ")
				output.write(contents.description)
			} else {
				output.write(" -> ")
				children.forEach { $0.print(&output) }
			}
		case .Weak:
			output.write("weak ")
			printChild(&output, index: 0)
		case .Unowned:
			output.write("unowned ")
			printChild(&output, index: 0)
		case .Unmanaged:
			output.write("unowned(unsafe) ")
			printChild(&output, index: 0)
		case .InOut:
			output.write("inout ")
			printChild(&output, index: 0)
		case .NonObjCAttribute: output.write("@nonobjc ")
		case .ObjCAttribute: output.write("@objc ")
		case .DirectMethodReferenceAttribute: output.write("super ")
		case .DynamicAttribute: output.write("dynamic ")
		case .VTableAttribute: output.write("override ")
		case .FunctionSignatureSpecialization: fallthrough
		case .GenericSpecialization: fallthrough
		case .GenericSpecializationNotReAbstracted:
			switch kind {
			case .FunctionSignatureSpecialization: output.write("function signature specialization <")
			case .GenericSpecialization: output.write("generic specialization <")
			default: output.write("generic not re-abstracted specialization <")
			}
			var hasPrevious = false
			for i in children.indices {
				switch children[i].kind {
				case .SpecializationPassID: continue
				case .SpecializationIsFragile: break
				case _ where children[i].children.count == 0: continue
				default: break
				}
				if hasPrevious {
					output.write(", ")
				}
				children[i].print(&output)
				hasPrevious = true
			}
			output.write("> of ")
		case .SpecializationIsFragile: output.write("preserving fragile attribute")
		case .GenericSpecializationParam:
			for i in children.indices {
				if i == 1 {
					output.write(" with ")
				} else if i > 1 {
					output.write(" and ")
				}
				children[i].print(&output)
			}
		case .FunctionSignatureSpecializationParam:
			output.write("Arg[\(contents.description)] = ")
			var childGenerator = children.generate()
			var child = childGenerator.next()
			while child != nil {
				let k: FunctionSigSpecializationParamKind?
				if case .Some(.Index(let i)) = child?.contents, let possibleK = FunctionSigSpecializationParamKind(rawValue: i) {
					k = possibleK
				} else {
					k = nil
				}
				switch k {
				case .Some(.BoxToValue): fallthrough
				case .Some(.BoxToStack): child?.print(&output)
				case .Some(.ConstantPropFunction): fallthrough
				case .Some(.ConstantPropGlobal):
					output.write("[")
					child?.print(&output)
					output.write(" : ")
					child = childGenerator.next()
					let t = child?.contents.description ?? ""
					do {
						output.write(try demangleSwiftName(t).description)
					} catch {
						output.write(t)
					}
					output.write("]")
				case .Some(.ConstantPropInteger): fallthrough
				case .Some(.ConstantPropFloat):
					output.write("[")
					child?.print(&output)
					output.write(" : ")
					child = childGenerator.next()
					child?.print(&output)
					output.write("]")
				case .Some(.ConstantPropString):
					output.write("[")
					child?.print(&output)
					output.write(" : ")
					child = childGenerator.next()
					child?.print(&output)
					output.write("'")
					child = childGenerator.next()
					child?.print(&output)
					output.write("']")
				case .Some(.ClosureProp):
					output.write("[")
					child?.print(&output)
					output.write(" : ")
					child = childGenerator.next()
					child?.print(&output)
					output.write(", Argument Types : [")
					child = childGenerator.next()
					while child != nil {
						if let c = child where c.kind != .Type {
							fallthrough
						}
						child?.print(&output)
						child = childGenerator.next()
						if let c = child, case .Name = c.contents {
							output.write(", ")
						}
					}
					output.write("]")
				default: child?.print(&output)
				}
				child = childGenerator.next()
			}
		case .FunctionSignatureSpecializationParamPayload: output.write((try? demangleSwiftName(contents.description).description) ?? contents.description)
		case .FunctionSignatureSpecializationParamKind:
			let raw: UInt32
			if case .Index(let i) = contents {
				raw = i
			} else {
				raw = 0
			}
			var printedOptionSet = false
			if raw & FunctionSigSpecializationParamKind.Dead.rawValue != 0 {
				printedOptionSet = true
				output.write("Dead")
			}
			if raw & FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue != 0 {
				if printedOptionSet {
					output.write(" and ")
				} else {
					printedOptionSet = true
				}
				output.write("Owned To Guaranteed")
			}
			if raw & FunctionSigSpecializationParamKind.SROA.rawValue != 0 {
				if printedOptionSet {
					output.write(" and ")
				} else {
					printedOptionSet = true
				}
				output.write("Exploded")
			}
			if printedOptionSet {
				return
			}
			switch FunctionSigSpecializationParamKind(rawValue: raw) {
			case .Some(.BoxToValue): output.write("Value Promoted from Box")
			case .Some(.BoxToStack): output.write("Stack Promoted from Box")
			case .Some(.ConstantPropFunction): output.write("Constant Propagated Function")
			case .Some(.ConstantPropGlobal): output.write("Constant Propagated Global")
			case .Some(.ConstantPropInteger): output.write("Constant Propagated Integer")
			case .Some(.ConstantPropFloat): output.write("Constant Propagated Float")
			case .Some(.ConstantPropString): output.write("Constant Propagated String")
			case .Some(.ClosureProp): output.write("Closure Propagated")
			default: break
			}
		case .SpecializationPassID: output.write(contents.description)
		case .BuiltinTypeName: output.write(contents.description)
		case .Number: output.write(contents.description)
		case .InfixOperator: output.write(contents.description + " infix")
		case .PrefixOperator: output.write(contents.description + " prefix")
		case .PostfixOperator: output.write(contents.description + " postfix")
		case .LazyProtocolWitnessTableAccessor:
			output.write("lazy protocol witness table accessor for type ")
			printChild(&output, index: 0)
			output.write(" and conformance ")
			printChild(&output, index: 1)
		case .LazyProtocolWitnessTableCacheVariable:
			output.write("lazy protocol witness table cache variable for type ")
			printChild(&output, index: 0)
			output.write(" and conformance ")
			printChild(&output, index: 1)
		case .ProtocolWitnessTableAccessor:
			output.write("protocol witness table accessor for ")
			printChild(&output, index: 0)
		case .ProtocolWitnessTable:
			output.write("protocol witness table for ")
			printChild(&output, index: 0)
		case .GenericProtocolWitnessTable:
			output.write("generic protocol witness table for ")
			printChild(&output, index: 0)
		case .GenericProtocolWitnessTableInstantiationFunction:
			output.write("instantiation function for generic protocol witness table for ")
			printChild(&output, index: 0)
		case .ProtocolWitness:
			output.write("protocol witness for ")
			printChild(&output, index: 1)
			output.write(" in conformance ")
			printChild(&output, index: 0)
		case .PartialApplyForwarder:
			output.write("partial apply forwarder")
			output.write(children.isEmpty ? "" : " for ")
			printChild(&output, index: 0)
		case .PartialApplyObjCForwarder:
			output.write("partial apply ObjC forwarder" )
			output.write(children.isEmpty ? "" : " for ")
			printChild(&output, index: 0)
		case .FieldOffset:
			printChild(&output, index: 0)
			output.write("field offset for ")
			printChild(&output, index: 1)
		case .ReabstractionThunk: fallthrough
		case .ReabstractionThunkHelper:
			output.write("reabstraction thunk ")
			output.write(kind == .ReabstractionThunkHelper ? "helper " : "")
			if let c = children.filter({ $0.kind == .DependentGenericSignature }).first {
				c.print(&output)
				output.write(" ")
			}
			output.write("from ")
			printChild(&output, index: children.count - 2)
			output.write(" to ")
			printChild(&output, index: children.count - 1)
		case .GenericTypeMetadataPattern:
			output.write("generic type metadata pattern for ")
			printChild(&output, index: 0)
		case .Metaclass:
			output.write("metaclass for ")
			printChild(&output, index: 0)
		case .ProtocolDescriptor:
			output.write("protocol descriptor for ")
			printChild(&output, index: 0)
		case .FullTypeMetadata:
			output.write("full type metadata for ")
			printChild(&output, index: 0)
		case .TypeMetadata:
			output.write("type metadata for ")
			printChild(&output, index: 0)
		case .TypeMetadataAccessFunction:
			output.write("type metadata accessor for ")
			printChild(&output, index: 0)
		case .TypeMetadataLazyCache:
			output.write("lazy cache variable for type metadata for ")
			printChild(&output, index: 0)
		case .AssociatedTypeMetadataAccessor:
			output.write("associated type metadata accessor for ")
			printChild(&output, index: 1)
			output.write(" in ")
			printChild(&output, index: 0)
		case .AssociatedTypeWitnessTableAccessor:
			output.write("associated type witness table accessor for ")
			printChild(&output, index: 1)
			output.write(" : ")
			printChild(&output, index: 2)
			output.write(" in ")
			printChild(&output, index: 0)
		case .NominalTypeDescriptor:
			output.write("nominal type descriptor for ")
			printChild(&output, index: 0)
		case .ValueWitness:
			if case .Index(let i) = contents, let vwk = ValueWitnessKind(rawValue: i) {
				output.write(vwk.description)
			}
			output.write(" value witness for ")
			printChild(&output, index: 0)
		case .ValueWitnessTable:
			output.write("value witness table for ")
			printChild(&output, index: 0)
		case .WitnessTableOffset:
			output.write("witness table offset for ")
			printChild(&output, index: 0)
		case .BoundGenericClass: fallthrough
		case .BoundGenericStructure: fallthrough
		case .BoundGenericEnum: printBoundGeneric(&output)
		case .DynamicSelf: output.write("Self")
		case .CFunctionPointer:
			output.write("@convention(c) ")
			printFunction(&output)
		case .ObjCBlock:
			output.write("@convention(block) ")
			printFunction(&output)
		case .SILBoxType:
			output.write("@box ")
			printChild(&output, index: 0)
		case .Metatype:
			var childIndex = 0
			switch children.count {
			case 2:
				printChild(&output, index: childIndex)
				output.write(" ")
				childIndex += 1
				fallthrough
			case 1:
				let t = children[0]
				t.print(&output)
				if t.kind == .Type, let f = t.children.first where f.kind == .ExistentialMetatype || f.kind == .ProtocolList {
					output.write(".Protocol")
				} else {
					output.write(".Type")
				}
			default: break
			}
		case .ExistentialMetatype:
			var childIndex = 0
			switch children.count {
			case 2:
				printChild(&output, index: childIndex)
				output.write(" ")
				childIndex += 1
				fallthrough
			case 1:
				printChild(&output, index: childIndex)
				output.write(".Type")
			default: break
			}
		case .MetatypeRepresentation: output.write(contents.description)
		case .ArchetypeRef: output.write(contents.description)
		case .AssociatedTypeRef:
			printChild(&output, index: 0)
			output.write(".")
			if children.count > 1 {
				output.write(children[1].contents.description)
			}
		case .SelfTypeRef:
			printChild(&output, index: 0)
			output.write(".Self")
		case .ProtocolList:
			if let c = children.first {
				if c.children.count != 1 {
					output.write("protocol<")
				}
				for i in c.children.indices {
					if i != 0 {
						output.write(", ")
					}
					c.children[i].print(&output)
				}
				if c.children.count != 1 {
					output.write(">")
				}
			}
		case .Generics:
			guard !children.isEmpty else { return }
			output.write("<")
			printChild(&output, index: 0)
			var index = 1
			while index < children.count && children[index].kind == .Archetype {
				output.write(", ")
				children[index].print(&output)
				index += 1
			}
			output.write(">")
		case .Archetype:
			output.write(contents.description)
			if !children.isEmpty {
				output.write(" : ")
			}
			printChild(&output, index: 0)
		case .AssociatedType: return
		case .QualifiedArchetype:
			guard children.count >= 2 else { return }
			output.write("(archetype ")
			output.write(children[0].contents.description)
			output.write(" of ")
			printChild(&output, index: 1)
			output.write(")")
		case .GenericType:
			printChild(&output, index: 0)
			if children.count > 1 {
				children[1].printChild(&output, index: 0)
			}
		case .OwningAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".owningAddressor", asContext: asContext, suppressType: suppressType)
		case .OwningMutableAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".owningMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .NativeOwningAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".nativeOwningAddressor", asContext: asContext, suppressType: suppressType)
		case .NativeOwningMutableAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".nativeOwningMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .NativePinningAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".nativePinningAddressor", asContext: asContext, suppressType: suppressType)
		case .NativePinningMutableAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".nativePinningMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .UnsafeAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".unsafeAddressor", asContext: asContext, suppressType: suppressType)
		case .UnsafeMutableAddressor:
			printEntity(&output, hasName: true, hasType: true, extraName: ".unsafeMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .GlobalGetter:
			printEntity(&output, hasName: true, hasType: true, extraName: ".getter", asContext: asContext, suppressType: suppressType)
		case .Getter:
			printEntity(&output, hasName: true, hasType: true, extraName: ".getter", asContext: asContext, suppressType: suppressType)
		case .Setter:
			printEntity(&output, hasName: true, hasType: true, extraName: ".setter", asContext: asContext, suppressType: suppressType)
		case .MaterializeForSet:
			printEntity(&output, hasName: true, hasType: true, extraName: ".materializeForSet", asContext: asContext, suppressType: suppressType)
		case .WillSet:
			printEntity(&output, hasName: true, hasType: true, extraName: ".willset", asContext: asContext, suppressType: suppressType)
		case .DidSet:
			printEntity(&output, hasName: true, hasType: true, extraName: ".didset", asContext: asContext, suppressType: suppressType)
		case .Allocator:
			printEntity(&output, hasName: false, hasType: true, extraName: ((children.count > 0 && children[0].kind == .Class) ? "__allocating_init" : "init"), asContext: asContext, suppressType: suppressType)
		case .Constructor:
			printEntity(&output, hasName: false, hasType: true, extraName: "init", asContext: asContext, suppressType: suppressType)
		case .Destructor:
			printEntity(&output, hasName: false, hasType: false, extraName: "deinit", asContext: asContext, suppressType: suppressType)
		case .Deallocator:
			printEntity(&output, hasName: false, hasType: false, extraName: ((children.count > 0 && children[0].kind == .Class) ? "__deallocating_deinit" : "deinit"), asContext: asContext, suppressType: suppressType)
		case .IVarInitializer:
			printEntity(&output, hasName: false, hasType: false, extraName: "__ivar_initializer", asContext: asContext, suppressType: suppressType)
		case .IVarDestroyer:
			printEntity(&output, hasName: false, hasType: false, extraName: "__ivar_destroyer", asContext: asContext, suppressType: suppressType)
		case .ProtocolConformance:
			printChild(&output, index: 0)
			output.write(" : ")
			printChild(&output, index: 1)
			output.write(" in ")
			printChild(&output, index: 2)
		case .TypeList: children.forEach { $0.print(&output) }
		case .ImplConvention: output.write(contents.description)
		case .ImplFunctionAttribute: output.write(contents.description)
		case .ImplErrorResult:
			output.write("@error ")
			fallthrough
		case .ImplParameter: fallthrough
		case .ImplResult:
			for i in children.indices {
				if i != 0 {
					output.write(" ")
				}
				children[i].print(&output)
			}
		case .ImplFunctionType: printImplFunctionType(&output)
		case .ErrorType: output.write("<ERROR TYPE>")
		case .DependentGenericSignature:
			output.write("<")
			var depth: UInt32 = 0
			while depth < UInt32(children.count) {
				let c = children[Int(depth)]
				if c.kind != .DependentGenericParamCount { break }
				if depth != 0 {
					output.write("><")
				}
				if case .Index(let index) = c.contents {
					for i in 0..<index {
						if i != 0 { output.write(", ") }
						output.write(archetypeName(i, depth))
					}
				}
				depth += 1
			}
			if depth != UInt32(children.count) {
				output.write(" where ")
				var i = depth
				while i < UInt32(children.count) {
					if i > depth {
						output.write(", ")
					}
					printChild(&output, index: Int(i))
					i += 1
				}
			}
			output.write(">")
		case .DependentGenericParamCount: return
		case .DependentGenericConformanceRequirement:
			printChild(&output, index: 0)
			output.write(": ")
			printChild(&output, index: 1)
		case .DependentGenericSameTypeRequirement:
			printChild(&output, index: 0)
			output.write(" == ")
			printChild(&output, index: 1)
		case .DependentGenericParamType: output.write(contents.description)
		case .DependentGenericType:
			printChild(&output, index: 0)
			output.write(" ")
			printChild(&output, index: 1)
		case .DependentMemberType:
			printChild(&output, index: 0)
			output.write(".")
			printChild(&output, index: 1)
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

