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

public func demangle(mangled: String) throws -> SwiftIdentifier {
	var scanner = ScalarScanner(scalars: mangled.unicodeScalars, context: [SwiftIdentifier]())
	
	try scanner.requireMatch("_T")
	var children = [SwiftIdentifier]()
	
	if scanner.conditionalMatch("TS") {
		repeat {
			children.append(try demangleSpecializedAttribute(&scanner))
			scanner.context.removeAll()
		} while scanner.conditionalMatch("_TTS")
		try scanner.requireMatch("_T")
	} else if scanner.conditionalMatch("To") {
		children.append(SwiftIdentifier(kind: .ObjCAttribute))
	} else if scanner.conditionalMatch("TO") {
		children.append(SwiftIdentifier(kind: .NonObjCAttribute))
	} else if scanner.conditionalMatch("TD") {
		children.append(SwiftIdentifier(kind: .DynamicAttribute))
	} else if scanner.conditionalMatch("Td") {
		children.append(SwiftIdentifier(kind: .DirectMethodReferenceAttribute))
	} else if scanner.conditionalMatch("TV") {
		children.append(SwiftIdentifier(kind: .VTableAttribute))
	}

	children.append(try demangleGlobal(&scanner))
	
	let remainder = scanner.remainder()
	if !remainder.isEmpty {
		children.append(SwiftIdentifier(kind: .Suffix, contents: .Name(remainder)))
	}
	
	return SwiftIdentifier(kind: .Global, children: children)
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

func demangleGlobal(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("M") {
		if scanner.conditionalMatch("P") {
			return SwiftIdentifier(kind: .GenericTypeMetadataPattern, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("a") {
			return SwiftIdentifier(kind: .TypeMetadataAccessFunction, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("L") {
			return SwiftIdentifier(kind: .TypeMetadataLazyCache, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("m") {
			return SwiftIdentifier(kind: .Metaclass, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("n") {
			return SwiftIdentifier(kind: .NominalTypeDescriptor, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("f") {
			return SwiftIdentifier(kind: .FullTypeMetadata, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("p") {
			return SwiftIdentifier(kind: .ProtocolDescriptor, children: [try demangleProtocolName(&scanner)])
		} else{
			return SwiftIdentifier(kind: .TypeMetadata, children: [try demangleType(&scanner)])
		}
	} else if scanner.conditionalMatch("P") {
		try scanner.requireMatch("A")
		return SwiftIdentifier(kind: scanner.conditionalMatch("o") ? .PartialApplyObjCForwarder : .PartialApplyForwarder, children: scanner.conditionalMatch("__T") ? [try demangleGlobal(&scanner)] : [])
	} else if scanner.conditionalMatch("t") {
		return SwiftIdentifier(kind: .TypeMangling, children: [try demangleType(&scanner)])
	} else if scanner.conditionalMatch("w") {
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
		return SwiftIdentifier(kind: .ValueWitness, children: [try demangleType(&scanner)], contents: .Index(value))
	} else if scanner.conditionalMatch("W") {
		if scanner.conditionalMatch("V") {
			return SwiftIdentifier(kind: .ValueWitnessTable, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("o") {
			return SwiftIdentifier(kind: .WitnessTableOffset, children: [try demangleEntity(&scanner)])
		} else if scanner.conditionalMatch("v") {
			let directness: UInt32
			if scanner.conditionalMatch("d") {
				directness = 0
			} else {
				try scanner.requireMatch("i")
				directness = 1
			}
			let child = SwiftIdentifier(kind: .Directness, contents: .Index(directness))
			return SwiftIdentifier(kind: .FieldOffset, children: [child, try demangleEntity(&scanner)])
		} else if scanner.conditionalMatch("P") {
			return SwiftIdentifier(kind: .ProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalMatch("G") {
			return SwiftIdentifier(kind: .GenericProtocolWitnessTable, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalMatch("I") {
			return SwiftIdentifier(kind: .GenericProtocolWitnessTableInstantiationFunction, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalMatch("l") {
			return SwiftIdentifier(kind: .LazyProtocolWitnessTableAccessor, children: [try demangleType(&scanner), try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalMatch("L") {
			return SwiftIdentifier(kind: .LazyProtocolWitnessTableCacheVariable, children: [try demangleType(&scanner), try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalMatch("a") {
			return SwiftIdentifier(kind: .ProtocolWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner)])
		} else if scanner.conditionalMatch("t") {
			return SwiftIdentifier(kind: .AssociatedTypeMetadataAccessor, children: [try demangleProtocolConformance(&scanner), try demangleDeclName(&scanner)])
		} else if scanner.conditionalMatch("T") {
			return SwiftIdentifier(kind: .AssociatedTypeWitnessTableAccessor, children: [try demangleProtocolConformance(&scanner), try demangleDeclName(&scanner), try demangleProtocolName(&scanner)])
		} else {
			throw scanner.unexpectedError()
		}
	} else if scanner.conditionalMatch("T") {
		if scanner.conditionalMatch("W") {
			return SwiftIdentifier(kind: .ProtocolWitness, children: [try demangleProtocolConformance(&scanner), try demangleEntity(&scanner)])
		}
		
		let kind: SwiftIdentifier.Kind
		if scanner.conditionalMatch("R") {
			kind = .ReabstractionThunkHelper
		} else {
			try scanner.requireMatch("r")
			kind = .ReabstractionThunk
		}
		var children = [SwiftIdentifier]()
		if scanner.conditionalMatch("G") {
			children.append(try demangleGenericSignature(&scanner))
		}
		children.append(try demangleType(&scanner))
		children.append(try demangleType(&scanner))
		return SwiftIdentifier(kind: kind, children: children)
	} else {
		return try demangleEntity(&scanner)
	}
}


func demangleSpecializedAttribute(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let c = try scanner.requireScalar()
	var children = [SwiftIdentifier]()
	if scanner.conditionalMatch("q") {
		children.append(SwiftIdentifier(kind: .SpecializationIsFragile))
	}
	children.append(SwiftIdentifier(kind: .SpecializationPassID, contents: .Index(try scanner.requireScalar().value - 48)))
	if c == "r" || c == "g" {
		while !scanner.conditionalMatch("_") {
			var parameterChildren = [SwiftIdentifier]()
			parameterChildren.append(try demangleType(&scanner))
			while !scanner.conditionalMatch("_") {
				parameterChildren.append(try demangleProtocolConformance(&scanner))
			}
			children.append(SwiftIdentifier(kind: .GenericSpecializationParam, children: parameterChildren))
		}
		return SwiftIdentifier(kind: c == "r" ? .GenericSpecializationNotReAbstracted : .GenericSpecialization, children: children)
	} else if c == "f" {
		var count: UInt32 = 0
		while !scanner.conditionalMatch("_") {
			var paramChildren = [SwiftIdentifier]()
			if scanner.conditionalMatch("n_") {
				// empty
			} else if scanner.conditionalMatch("cp") {
				paramChildren.appendContentsOf(try demangleFuncSigSpecializationConstantProp(&scanner))
			} else if scanner.conditionalMatch("cl") {
				paramChildren.append(SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ClosureProp.rawValue)))
				paramChildren.append(SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents))
				while !scanner.conditionalMatch("_") {
					paramChildren.append(try demangleType(&scanner))
				}
			} else if scanner.conditionalMatch("i_") {
				paramChildren.append(SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.BoxToValue.rawValue)))
			} else if scanner.conditionalMatch("k_") {
				paramChildren.append(SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.BoxToStack.rawValue)))
			} else {
				var value: UInt32 = 0
				if scanner.conditionalMatch("d") {
					value |= FunctionSigSpecializationParamKind.Dead.rawValue
				}
				if scanner.conditionalMatch("g") {
					value |= FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue
				}
				if scanner.conditionalMatch("s") {
					value |= FunctionSigSpecializationParamKind.SROA.rawValue
				}
				try scanner.requireMatch("_")
				paramChildren.append(SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(value)))
			}
			children.append(SwiftIdentifier(kind: .FunctionSignatureSpecializationParam, children: paramChildren, contents: .Index(count)))
			count += 1
		}
		return SwiftIdentifier(kind: .FunctionSignatureSpecialization, children: children)
	} else {
		throw scanner.unexpectedError()
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

func demangleFuncSigSpecializationConstantProp(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> [SwiftIdentifier] {
	if scanner.conditionalMatch("fr") {
		let name = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		try scanner.requireMatch("_")
		let kind = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropFunction.rawValue))
		return [kind, name]
	} else if scanner.conditionalMatch("g") {
		let name = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		try scanner.requireMatch("_")
		let kind = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropGlobal.rawValue))
		return [kind, name]
	} else if scanner.conditionalMatch("i") {
		var string: String = ""
		while !scanner.conditionalMatch("_") {
			string.append(try scanner.requireScalar())
		}
		let name = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropInteger.rawValue))
		return [kind, name]
	} else if scanner.conditionalMatch("i") {
		let string = try scanner.readUntil("_")
		try scanner.requireMatch("_")
		let name = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropInteger.rawValue))
		return [kind, name]
	} else if scanner.conditionalMatch("fl") {
		let string = try scanner.readUntil("_")
		try scanner.requireMatch("_")
		let name = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropFloat.rawValue))
		return [kind, name]
	} else if scanner.conditionalMatch("s") {
		try scanner.requireMatch("e")
		var string: String
		switch try scanner.requireScalar() {
		case "0": string = "u8"
		case "1": string = "u16"
		default: throw scanner.unexpectedError()
		}
		try scanner.requireMatch("v")
		let name = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: try demangleIdentifier(&scanner).contents)
		let encoding = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamPayload, contents: .Name(string))
		let kind = SwiftIdentifier(kind: .FunctionSignatureSpecializationParamKind, contents: .Index(FunctionSigSpecializationParamKind.ConstantPropString.rawValue))
		try scanner.requireMatch("_")
		return [kind, encoding, name]
	}
	throw scanner.unexpectedError()
}


func demangleProtocolConformance(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let type = try demangleType(&scanner)
	let prot = try demangleProtocolName(&scanner)
	let context = try demangleContext(&scanner)
	return SwiftIdentifier(kind: .ProtocolConformance, children: [type, prot, context])
}

func demangleProtocolName(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let name: SwiftIdentifier
	if scanner.conditionalMatch("S") {
		let index = try demangleSubstitutionIndex(&scanner)
		switch index.kind {
		case .Protocol: name = index
		case .Module: name = try demangleProtocolNameGivenContext(&scanner, context: index)
		default: throw scanner.unexpectedError()
		}
	} else if scanner.conditionalMatch("s") {
		let stdlib = SwiftIdentifier(kind: .Module, contents: .Name(stdlibName))
		name = try demangleProtocolNameGivenContext(&scanner, context: stdlib)
	} else {
		name = try demangleDeclarationName(&scanner, kind: .Protocol)
	}

	return SwiftIdentifier(kind: .Type, children: [name])
}

func demangleProtocolNameGivenContext(inout scanner: ScalarScanner<[SwiftIdentifier]>, context: SwiftIdentifier) throws -> SwiftIdentifier {
	let name = try demangleDeclName(&scanner)
	let result = SwiftIdentifier(kind: .Protocol, children: [context, name])
	scanner.context.append(result)
	return result
}

func demangleEntity(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let isStatic = scanner.conditionalMatch("Z")
	
	let basicKind: SwiftIdentifier.Kind
	if scanner.conditionalMatch("F") {
		basicKind = .Function
	} else if scanner.conditionalMatch("v") {
		basicKind = .Variable
	} else if scanner.conditionalMatch("I") {
		basicKind = .Initializer
	} else if scanner.conditionalMatch("i") {
		basicKind = .Subscript
	} else if scanner.conditionalMatch("S") {
		return try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalMatch("V") {
		return try demangleDeclarationName(&scanner, kind: .Structure)
	} else if scanner.conditionalMatch("O") {
		return try demangleDeclarationName(&scanner, kind: .Enum)
	} else if scanner.conditionalMatch("C") {
		return try demangleDeclarationName(&scanner, kind: .Class)
	} else if scanner.conditionalMatch("P") {
		return try demangleDeclarationName(&scanner, kind: .Protocol)
	} else {
		throw scanner.unexpectedError()
	}
	
	let context = try demangleContext(&scanner)

	let kind: SwiftIdentifier.Kind
	let hasType: Bool
	var name: SwiftIdentifier? = nil
	
	if scanner.conditionalMatch("D") {
		kind = .Deallocator
		hasType = false
	} else if scanner.conditionalMatch("d") {
		kind = .Destructor
		hasType = false
	} else if scanner.conditionalMatch("e") {
		kind = .IVarInitializer
		hasType = false
	} else if scanner.conditionalMatch("E") {
		kind = .IVarDestroyer
		hasType = false
	} else if scanner.conditionalMatch("C") {
		kind = .Allocator
		hasType = true
	} else if scanner.conditionalMatch("c") {
		kind = .Constructor
		hasType = true
	} else if scanner.conditionalMatch("a") {
		if scanner.conditionalMatch("O") {
			kind = .OwningMutableAddressor
		} else if scanner.conditionalMatch("o") {
			kind = .NativeOwningMutableAddressor
		} else if scanner.conditionalMatch("p") {
			kind = .NativePinningMutableAddressor
		} else if scanner.conditionalMatch("u") {
			kind = .UnsafeMutableAddressor
		} else {
			throw scanner.unexpectedError()
		}
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("l") {
		if scanner.conditionalMatch("O") {
			kind = .OwningAddressor
		} else if scanner.conditionalMatch("o") {
			kind = .NativeOwningAddressor
		} else if scanner.conditionalMatch("p") {
			kind = .NativePinningAddressor
		} else if scanner.conditionalMatch("u") {
			kind = .UnsafeAddressor
		} else {
			throw scanner.unexpectedError()
		}
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("g") {
		kind = .Getter
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("G") {
		kind = .GlobalGetter
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("s") {
		kind = .Setter
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("m") {
		kind = .MaterializeForSet
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("w") {
		kind = .WillSet
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("W") {
		kind = .DidSet
		hasType = true
		name = try demangleDeclName(&scanner)
	} else if scanner.conditionalMatch("U") {
		kind = .ExplicitClosure
		hasType = true
		name = SwiftIdentifier(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
	} else if scanner.conditionalMatch("u") {
		kind = .ImplicitClosure
		hasType = true
		name = SwiftIdentifier(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
	} else if case .Initializer = basicKind {
		if scanner.conditionalMatch("A") {
			kind = .DefaultArgumentInitializer
			name = SwiftIdentifier(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
		} else if scanner.conditionalMatch("i") {
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
	let entity = SwiftIdentifier(kind: kind, children: children)
	if isStatic {
		return SwiftIdentifier(kind: .Static, children: [entity])
	} else {
		return entity
	}
}

func demangleDeclarationName(inout scanner: ScalarScanner<[SwiftIdentifier]>, kind: SwiftIdentifier.Kind) throws -> SwiftIdentifier {
	let result = SwiftIdentifier(kind: kind, children: [try demangleContext(&scanner), try demangleDeclName(&scanner)])
	scanner.context.append(result)
	return result
}

func demangleContext(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("E") {
		let module = try demangleModule(&scanner)
		let type = try demangleContext(&scanner)
		return SwiftIdentifier(kind: .Extension, children: [module, type])
	} else if scanner.conditionalMatch("e") {
		let module = try demangleModule(&scanner)
		let signature = try demangleGenericSignature(&scanner)
		let type = try demangleContext(&scanner)
		return SwiftIdentifier(kind: .Extension, children: [module, type, signature])
	} else if scanner.conditionalMatch("S") {
		return try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalMatch("s") {
		return SwiftIdentifier(kind: .Module, children: [], contents: .Name(stdlibName))
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

func demangleModule(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("S") {
		return try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalMatch("s") {
		return SwiftIdentifier(kind: .Module, children: [], contents: .Name("Swift"))
	}
	let module = try demangleIdentifier(&scanner, kind: .Module)
	scanner.context.append(module)
	return module
}


func demangleSubstitutionIndex(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("o") {
		return SwiftIdentifier(kind: .Module, contents: .Name(objcModule))
	} else if scanner.conditionalMatch("C") {
		return SwiftIdentifier(kind: .Module, contents: .Name(cModule))
	} else if scanner.conditionalMatch("a") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("Array"))])
	} else if scanner.conditionalMatch("b") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("Bool"))])
	} else if scanner.conditionalMatch("c") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("UnicodeScalar"))])
	} else if scanner.conditionalMatch("d") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("Double"))])
	} else if scanner.conditionalMatch("f") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("Float"))])
	} else if scanner.conditionalMatch("i") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("Int"))])
	} else if scanner.conditionalMatch("P") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("UnsafePointer"))])
	} else if scanner.conditionalMatch("p") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("UnsafeMutablePointer"))])
	} else if scanner.conditionalMatch("q") {
		return SwiftIdentifier(kind: .Enum, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("Optional"))])
	} else if scanner.conditionalMatch("Q") {
		return SwiftIdentifier(kind: .Enum, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("ImplicitlyUnwrappedOptional"))])
	} else if scanner.conditionalMatch("R") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("UnsafeBufferPointer"))])
	} else if scanner.conditionalMatch("r") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("UnsafeMutableBufferPointer"))])
	} else if scanner.conditionalMatch("S") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("String"))])
	} else if scanner.conditionalMatch("u") {
		return SwiftIdentifier(kind: .Structure, children: [SwiftIdentifier(kind: .Module, contents: .Name(stdlibName)), SwiftIdentifier(kind: .Identifier, contents: .Name("UInt"))])
	}
	let index = try demangleIndex(&scanner)
	if Int(index) >= scanner.context.count {
		throw scanner.unexpectedError()
	}
	return scanner.context[Int(index)]
}

func demangleGenericSignature(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	var count: UInt32 = ~0
	var children = [SwiftIdentifier]()
	while try scanner.requirePeek() != "R" && scanner.requirePeek() != "r" {
		if scanner.conditionalMatch("z") {
			count = 0
		} else {
			count = try demangleIndex(&scanner) + 1
		}
		children.append(SwiftIdentifier(kind: .DependentGenericParamCount, contents: .Index(count)))
	}
	if count == ~0 {
		children.append(SwiftIdentifier(kind: .DependentGenericParamCount, contents: .Index(1)))
	}
	if !scanner.conditionalMatch("r") {
		try scanner.requireMatch("R")
		while !scanner.conditionalMatch("r") {
			children.append(try demangleGenericRequirement(&scanner))
		}
	}
	return SwiftIdentifier(kind: .DependentGenericSignature, children: children)
}

func demangleGenericRequirement(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let constrainedType = try demangleConstrainedType(&scanner)
	if scanner.conditionalMatch("z") {
		return SwiftIdentifier(kind: .DependentGenericSameTypeRequirement, children: [constrainedType, try demangleType(&scanner)])
	}
	let c = try scanner.requirePeek()
	let constraint: SwiftIdentifier
	if c == "C" {
		constraint = try demangleType(&scanner)
	} else if c == "S" {
		try scanner.requireMatch("S")
		let index = try demangleSubstitutionIndex(&scanner)
		let typename: SwiftIdentifier
		switch index.kind {
		case .Protocol: fallthrough
		case .Class: typename = index
		case .Module: typename = try demangleProtocolNameGivenContext(&scanner, context: index)
		default: throw scanner.unexpectedError()
		}
		constraint = SwiftIdentifier(kind: .Type, children: [typename])
	} else {
		constraint = try demangleProtocolName(&scanner)
	}
	return SwiftIdentifier(kind: .DependentGenericConformanceRequirement, children: [constrainedType, constraint])
}

func demangleConstrainedType(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("w") {
		return try demangleAssociatedTypeSimple(&scanner)
	} else if scanner.conditionalMatch("W") {
		return try demangleAssociatedTypeCompound(&scanner)
	}
	return try demangleGenericParamIndex(&scanner)
}

func demangleAssociatedTypeSimple(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let base = try demangleGenericParamIndex(&scanner)
	return try demangleDependentMemberTypeName(&scanner, base: SwiftIdentifier(kind: .Type, children: [base]))
}

func demangleAssociatedTypeCompound(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	var base = try demangleGenericParamIndex(&scanner)
	while !scanner.conditionalMatch("_") {
		let type = SwiftIdentifier(kind: .Type, children: [base])
		base = try demangleDependentMemberTypeName(&scanner, base: type)
	}
	return base
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

func demangleGenericParamIndex(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let depth: UInt32
	let index: UInt32
	if scanner.conditionalMatch("d") {
		depth = try demangleIndex(&scanner) + 1
		index = try demangleIndex(&scanner)
	} else if scanner.conditionalMatch("x") {
		depth = 0
		index = 0
	} else {
		index = try demangleIndex(&scanner) + 1
		depth = 0
	}
	let depthChild = SwiftIdentifier(kind: .Index, contents: .Index(depth))
	let indexChild = SwiftIdentifier(kind: .Index, contents: .Index(index))
	return SwiftIdentifier(kind: .DependentGenericParamType, children: [depthChild, indexChild], contents: .Name(archetypeName(index, depth)))
}

func demangleDependentMemberTypeName(inout scanner: ScalarScanner<[SwiftIdentifier]>, base: SwiftIdentifier) throws -> SwiftIdentifier {
	let associatedType: SwiftIdentifier
	if scanner.conditionalMatch("S") {
		associatedType = try demangleSubstitutionIndex(&scanner)
	} else {
		var prot: SwiftIdentifier? = nil
		if scanner.conditionalMatch("P") {
			prot = try demangleProtocolName(&scanner)
		}
		let at = try demangleIdentifier(&scanner, kind: .DependentAssociatedTypeRef)
		if let p = prot {
			var children = at.children
			children.append(p)
			associatedType = SwiftIdentifier(kind: at.kind, children: children, contents: at.contents)
		} else {
			associatedType = at
		}
		scanner.context.append(associatedType)
	}
	
	return SwiftIdentifier(kind: .DependentMemberType, children: [base, associatedType])
}

func demangleDeclName(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("L") {
		let discriminator = SwiftIdentifier(kind: .Number, contents: .Index(try demangleIndex(&scanner)))
		let name = try demangleIdentifier(&scanner)
		return SwiftIdentifier(kind: .LocalDeclName, children: [discriminator, name])
	} else if scanner.conditionalMatch("P") {
		let discriminator = try demangleIdentifier(&scanner)
		let name = try demangleIdentifier(&scanner)
		return SwiftIdentifier(kind: .PrivateDeclName, children: [discriminator, name])
	}
	
	return try demangleIdentifier(&scanner)
}

func demangleIndex(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> UInt32 {
	if scanner.conditionalMatch("_") {
		return 0
	}
	let value = UInt32(try scanner.requireInt()) + 1
	try scanner.requireMatch("_")
	return value
}

func demangleType(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	let type: SwiftIdentifier
	if scanner.conditionalMatch("B") {
		if scanner.conditionalMatch("b") {
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.BridgeObject"))
		} else if scanner.conditionalMatch("B") {
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.UnsafeValueBuffer"))
		} else if scanner.conditionalMatch("f") {
			let size = try scanner.requireInt()
			try scanner.requireMatch("_")
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.Float\(size)"))
		} else if scanner.conditionalMatch("i") {
			let size = try scanner.requireInt()
			try scanner.requireMatch("_")
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.Int\(size)"))
		} else if scanner.conditionalMatch("v") {
			let elements = try scanner.requireInt()
			try scanner.requireMatch("B")
			let name: String
			let size: String
			if scanner.conditionalMatch("i") {
				name = "xInt"
				size = try "\(scanner.requireInt())"
				try scanner.requireMatch("_")
			} else if scanner.conditionalMatch("f") {
				name = "xFloat"
				size = try "\(scanner.requireInt())"
				try scanner.requireMatch("_")
			} else {
				try scanner.requireMatch("p")
				name = "xRawPointer"
				size = ""
			}
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.Vec\(elements)\(name)\(size)"))
		} else if scanner.conditionalMatch("O") {
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.UnknownObject"))
		} else if scanner.conditionalMatch("o") {
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.NativeObject"))
		} else if scanner.conditionalMatch("p") {
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.RawPointer"))
		} else if scanner.conditionalMatch("w") {
			type = SwiftIdentifier(kind: .BuiltinTypeName, contents: .Name("Builtin.Word"))
		} else {
			throw scanner.unexpectedError()
		}
	} else if scanner.conditionalMatch("a") {
		type = try demangleDeclarationName(&scanner, kind: .TypeAlias)
	} else if scanner.conditionalMatch("b") {
		type = try demangleFunctionType(&scanner, kind: .ObjCBlock)
	} else if scanner.conditionalMatch("c") {
		type = try demangleFunctionType(&scanner, kind: .CFunctionPointer)
	} else if scanner.conditionalMatch("D") {
		type = SwiftIdentifier(kind: .DynamicSelf, children: [try demangleType(&scanner)])
	} else if scanner.conditionalMatch("E") {
		guard try scanner.requireScalars(2) == "RR" else { throw scanner.unexpectedError() }
		type = SwiftIdentifier(kind: .ErrorType, children: [], contents: .Name(""))
	} else if scanner.conditionalMatch("F") {
		type = try demangleFunctionType(&scanner, kind: .FunctionType)
	} else if scanner.conditionalMatch("f") {
		type = try demangleFunctionType(&scanner, kind: .UncurriedFunctionType)
	} else if scanner.conditionalMatch("G") {
		let unboundType = try demangleType(&scanner)
		var children = [SwiftIdentifier]()
		while !scanner.conditionalMatch("_") {
			children.append(try demangleType(&scanner))
		}
		let typeList = SwiftIdentifier(kind: .TypeList, children: children)
		let kind: SwiftIdentifier.Kind
		switch unboundType.children.first?.kind {
		case .Some(.Class): kind = .BoundGenericClass
		case .Some(.Structure): kind = .BoundGenericStructure
		case .Some(.Enum): kind = .BoundGenericEnum
		default: throw scanner.unexpectedError()
		}
		type = SwiftIdentifier(kind: kind, children: [unboundType, typeList])
	} else if scanner.conditionalMatch("X") {
		if scanner.conditionalMatch("b") {
			type = SwiftIdentifier(kind: .SILBoxType, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("M") {
			let value: String
			if scanner.conditionalMatch("t") {
				value = "@thick"
			} else if scanner.conditionalMatch("T") {
				value = "@thin"
			} else {
				try scanner.requireMatch("o")
				value = "@objc_metatype"
			}
			let metatypeRepresentation = SwiftIdentifier(kind: .MetatypeRepresentation, contents: .Name(value))
			type = SwiftIdentifier(kind: .Metatype, children: [metatypeRepresentation, try demangleType(&scanner)])
		} else if scanner.conditionalMatch("P") {
			if scanner.conditionalMatch("M") {
				let value: String
				if scanner.conditionalMatch("t") {
					value = "@thick"
				} else if scanner.conditionalMatch("T") {
					value = "@thin"
				} else {
					try scanner.requireMatch("o")
					value = "@objc_metatype"
				}
				let metatypeRepresentation = SwiftIdentifier(kind: .MetatypeRepresentation, contents: .Name(value))
				type = SwiftIdentifier(kind: .ExistentialMetatype, children: [metatypeRepresentation, try demangleType(&scanner)])
			} else {
				var children = [SwiftIdentifier]()
				while !scanner.conditionalMatch("_") {
					children.append(try demangleProtocolName(&scanner))
				}
				let typeList = SwiftIdentifier(kind: .TypeList)
				type = SwiftIdentifier(kind: .ProtocolList, children: [typeList])
			}
		} else if scanner.conditionalMatch("f") {
			type = try demangleFunctionType(&scanner, kind: .ThinFunctionType)
		} else if scanner.conditionalMatch("o") {
			type = SwiftIdentifier(kind: .Unowned, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("u") {
			type = SwiftIdentifier(kind: .Unmanaged, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("w") {
			type = SwiftIdentifier(kind: .Weak, children: [try demangleType(&scanner)])
		} else if scanner.conditionalMatch("F") {
			var children = [SwiftIdentifier]()
			var attr: String
			if scanner.conditionalMatch("t") {
				attr = "@convention(thin)"
			} else {
				switch try scanner.requireScalar() {
				case "d": attr = "@callee_unowned"
				case "g": attr = "@callee_guaranteed"
				case "o": attr = "@callee_owned"
				default: attr = ""
				}
			}
			children.append(SwiftIdentifier(kind: .ImplConvention, contents: .Name(attr)))
			if scanner.conditionalMatch("C") {
				if scanner.conditionalMatch("b") {
					children.append(SwiftIdentifier(kind: .ImplFunctionAttribute, contents: .Name("@convention(block)")))
				} else if scanner.conditionalMatch("c") {
					children.append(SwiftIdentifier(kind: .ImplFunctionAttribute, contents: .Name("@convention(c)")))
				} else if scanner.conditionalMatch("m") {
					children.append(SwiftIdentifier(kind: .ImplFunctionAttribute, contents: .Name("@convention(method)")))
				} else if scanner.conditionalMatch("O") {
					children.append(SwiftIdentifier(kind: .ImplFunctionAttribute, contents: .Name("@convention(objc_method)")))
				} else if scanner.conditionalMatch("w") {
					children.append(SwiftIdentifier(kind: .ImplFunctionAttribute, contents: .Name("@convention(witness_method)")))
				} else {
					throw scanner.unexpectedError()
				}
			}
			if scanner.conditionalMatch("N") {
				children.append(SwiftIdentifier(kind: .ImplFunctionAttribute, contents: .Name("@noreturn")))
			}
			if scanner.conditionalMatch("G") {
				children.append(try demangleGenericSignature(&scanner))
			}
			try scanner.requireMatch("_")
			while !scanner.conditionalMatch("_") {
				children.append(try demangleImplParameterOrResult(&scanner, kind: .ImplParameter))
			}
			while !scanner.conditionalMatch("_") {
				children.append(try demangleImplParameterOrResult(&scanner, kind: .ImplResult))
			}
			type = SwiftIdentifier(kind: .ImplFunctionType, children: children)
		} else {
			throw scanner.unexpectedError()
		}
	} else if scanner.conditionalMatch("K") {
		type = try demangleFunctionType(&scanner, kind: .AutoClosureType)
	} else if scanner.conditionalMatch("M") {
		type = SwiftIdentifier(kind: .Metatype, children: [try demangleType(&scanner)])
	} else if scanner.conditionalMatch("P") {
		if scanner.conditionalMatch("M") {
			type = SwiftIdentifier(kind: .ExistentialMetatype, children: [try demangleType(&scanner)])
		} else {
			var children = [SwiftIdentifier]()
			while !scanner.conditionalMatch("_") {
				children.append(try demangleProtocolName(&scanner))
			}
			let typeList = SwiftIdentifier(kind: .TypeList, children: children)
			type = SwiftIdentifier(kind: .ProtocolList, children: [typeList])
		}
	} else if scanner.conditionalMatch("Q") {
		type = try demangleArchetypeType(&scanner)
	} else if scanner.conditionalMatch("q") {
		let c = try scanner.requirePeek()
		if c != "d" && c != "_" && c < "0" && c > "9" {
			type = try demangleDependentMemberTypeName(&scanner, base: demangleType(&scanner))
		} else {
			type = try demangleGenericParamIndex(&scanner)
		}
	} else if scanner.conditionalMatch("x") {
		let depthChild = SwiftIdentifier(kind: .Index, contents: .Index(0))
		let indexChild = SwiftIdentifier(kind: .Index, contents: .Index(0))
		type = SwiftIdentifier(kind: .DependentGenericParamType, children: [depthChild, indexChild], contents: .Name(archetypeName(0, 0)))
	} else if scanner.conditionalMatch("w") {
		type = try demangleAssociatedTypeSimple(&scanner)
	} else if scanner.conditionalMatch("W") {
		type = try demangleAssociatedTypeCompound(&scanner)
	} else if scanner.conditionalMatch("R") {
		let t = try demangleType(&scanner)
		type = SwiftIdentifier(kind: .InOut, children: t.children)
	} else if scanner.conditionalMatch("S") {
		type = try demangleSubstitutionIndex(&scanner)
	} else if scanner.conditionalMatch("T") {
		type = try demangleTuple(&scanner, variadic: false)
	} else if scanner.conditionalMatch("t") {
		type = try demangleTuple(&scanner, variadic: true)
	} else if scanner.conditionalMatch("u") {
		let sig = try demangleGenericSignature(&scanner)
		let sub = try demangleType(&scanner)
		type = SwiftIdentifier(kind: .DependentGenericType, children: [sig, sub])
	} else {
		let kind: SwiftIdentifier.Kind
		switch try scanner.requireScalar() {
		case "C": kind = .Class
		case "V": kind = .Structure
		case "O": kind = .Enum
		default: throw scanner.unexpectedError()
		}
		type = try demangleDeclarationName(&scanner, kind: kind)
	}
	return SwiftIdentifier(kind: .Type, children: [type])
}

func demangleArchetypeType(inout scanner: ScalarScanner<[SwiftIdentifier]>) throws -> SwiftIdentifier {
	if scanner.conditionalMatch("P") {
		return SwiftIdentifier(kind: .SelfTypeRef, children: [try demangleProtocolName(&scanner)])
	} else if scanner.conditionalMatch("Q") {
		let result = SwiftIdentifier(kind: .AssociatedTypeRef, children: [try demangleArchetypeType(&scanner), try demangleIdentifier(&scanner)])
		scanner.context.append(result)
		return result
	} else if scanner.conditionalMatch("S") {
		let index = try demangleSubstitutionIndex(&scanner)
		if case .Protocol = index.kind {
			return SwiftIdentifier(kind: .SelfTypeRef, children: [index])
		} else {
			let result = SwiftIdentifier(kind: .AssociatedTypeRef, children: [index, try demangleIdentifier(&scanner)])
			scanner.context.append(result)
			return result
		}
	} else if scanner.conditionalMatch("s") {
		let root = SwiftIdentifier(kind: .Module, contents: .Name(stdlibName))
		let result = SwiftIdentifier(kind: .AssociatedTypeRef, children: [root, try demangleIdentifier(&scanner)])
		scanner.context.append(result)
		return result
	} else if scanner.conditionalMatch("d") {
		let depth = try demangleIndex(&scanner) + 1
		let index = try demangleIndex(&scanner)
		let depthChild = SwiftIdentifier(kind: .Index, contents: .Index(depth))
		let indexChild = SwiftIdentifier(kind: .Index, contents: .Index(index))
		return SwiftIdentifier(kind: .ArchetypeRef, children: [depthChild, indexChild], contents: .Name(archetypeName(index, depth)))
	} else if scanner.conditionalMatch("q") {
		let index = SwiftIdentifier(kind: .Index, contents: .Index(try demangleIndex(&scanner)))
		let context = try demangleContext(&scanner)
		let declContext = SwiftIdentifier(kind: .DeclContext, children: [context])
		return SwiftIdentifier(kind: .QualifiedArchetype, children: [index, declContext])
	}

	let index = try demangleIndex(&scanner)
	let depthChild = SwiftIdentifier(kind: .Index, contents: .Index(0))
	let indexChild = SwiftIdentifier(kind: .Index, contents: .Index(index))
	return SwiftIdentifier(kind: .ArchetypeRef, children: [depthChild, indexChild], contents: .Name(archetypeName(index, 0)))
}

func demangleImplParameterOrResult(inout scanner: ScalarScanner<[SwiftIdentifier]>, kind: SwiftIdentifier.Kind) throws -> SwiftIdentifier {
	var k = kind
	if scanner.conditionalMatch("z") {
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
	let conventionNode = SwiftIdentifier(kind: .ImplConvention, contents: .Name(convention))
	return SwiftIdentifier(kind: k, children: [conventionNode, type])
}


func demangleTuple(inout scanner: ScalarScanner<[SwiftIdentifier]>, variadic: Bool) throws -> SwiftIdentifier {
	var children = [SwiftIdentifier]()
	while !scanner.conditionalMatch("_") {
		var elementChildren = [SwiftIdentifier]()
		let peek = try scanner.requirePeek()
		if (peek >= "0" && peek <= "9") || peek == "o" {
			elementChildren.append(try demangleIdentifier(&scanner, kind: .TupleElementName))
		}
		elementChildren.append(try demangleType(&scanner))
		children.append(SwiftIdentifier(kind: .TupleElement, children: elementChildren))
	}
	return SwiftIdentifier(kind: variadic ? .VariadicTuple : .NonVariadicTuple, children: children)
}

func demangleFunctionType(inout scanner: ScalarScanner<[SwiftIdentifier]>, kind: SwiftIdentifier.Kind) throws -> SwiftIdentifier {
	var children = [SwiftIdentifier]()
	if scanner.conditionalMatch("z") {
		children.append(SwiftIdentifier(kind: .ThrowsAnnotation))
	}
	children.append(SwiftIdentifier(kind: .ArgumentTuple, children: [try demangleType(&scanner)]))
	children.append(SwiftIdentifier(kind: .ReturnType, children: [try demangleType(&scanner)]))
	return SwiftIdentifier(kind: kind, children: children)
}

func demangleIdentifier(inout scanner: ScalarScanner<[SwiftIdentifier]>, kind: SwiftIdentifier.Kind? = nil) throws -> SwiftIdentifier {
	let isPunycode: Bool
	if scanner.conditionalMatch("X") {
		isPunycode = true
	} else {
		isPunycode = false
	}

	let k: SwiftIdentifier.Kind
	let isOperator: Bool
	if scanner.conditionalMatch("o") {
		guard kind == nil else { throw scanner.unexpectedError() }
		isOperator = true
		
		if scanner.conditionalMatch("p") {
			k = .PrefixOperator
		} else if scanner.conditionalMatch("P") {
			k = .PostfixOperator
		} else if scanner.conditionalMatch("i") {
			k = .InfixOperator
		} else {
			throw scanner.unexpectedError()
		}
	} else {
		isOperator = false
		k = kind ?? SwiftIdentifier.Kind.Identifier
	}
	
	var identifier = try scanner.requireScalars(scanner.requireInt())
	if isPunycode {
		identifier = decodeSwiftPunycode(identifier)
	}
	if isOperator {
		let source = identifier
		identifier = ""
		for scalar in source.unicodeScalars {
			switch scalar.value {
			case 128..<UInt32.max: identifier.append(scalar)
			case UInt32("a"): identifier.append(UnicodeScalar("&"))
			case UInt32("c"): identifier.append(UnicodeScalar("@"))
			case UInt32("d"): identifier.append(UnicodeScalar("/"))
			case UInt32("e"): identifier.append(UnicodeScalar("="))
			case UInt32("g"): identifier.append(UnicodeScalar(">"))
			case UInt32("l"): identifier.append(UnicodeScalar("<"))
			case UInt32("m"): identifier.append(UnicodeScalar("*"))
			case UInt32("n"): identifier.append(UnicodeScalar("!"))
			case UInt32("o"): identifier.append(UnicodeScalar("|"))
			case UInt32("p"): identifier.append(UnicodeScalar("+"))
			case UInt32("q"): identifier.append(UnicodeScalar("?"))
			case UInt32("r"): identifier.append(UnicodeScalar("%"))
			case UInt32("s"): identifier.append(UnicodeScalar("-"))
			case UInt32("t"): identifier.append(UnicodeScalar("~"))
			case UInt32("x"): identifier.append(UnicodeScalar("^"))
			case UInt32("z"): identifier.append(UnicodeScalar("."))
			default: throw scanner.unexpectedError()
			}
		}
	}

	return SwiftIdentifier(kind: k, children: [], contents: .Name(identifier))
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

	let scalars: Collection
	var index: Index
	
	/// Construct from a String.UnicodeScalarView and a context value
	public init(scalars: Collection, context: T) {
		self.scalars = scalars
		self.index = scalars.startIndex
		self.context = context
	}
	
	/// Returns a throwable error capturing the current scanner progress point.
	public func unexpectedError() -> ScalarScannerError {
		return ScalarScannerError.Unexpected(at: self.scalars.startIndex.distanceTo(index))
	}
	
	public mutating func requireMatch(value: String) throws {
		index = try value.unicodeScalars.reduce(index) { i, scalar in
			if i == self.scalars.endIndex || scalar != self.scalars[i] {
				throw ScalarScannerError.MatchFailed(wanted: value, at: self.scalars.startIndex.distanceTo(index))
			}
			return i.successor()
		}
	}
	
	public mutating func readUntil(scalar: UnicodeScalar) throws -> String {
		var string: String = ""
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
	
	public mutating func remainder() -> String {
		var string: String = ""
		while index != scalars.endIndex {
			string.append(scalars[index])
			index = index.successor()
		}
		return string
	}
	
	public mutating func conditionalMatch(value: String) -> Bool {
		var i = index
		for scalar in value.unicodeScalars {
			if i == scalars.endIndex || scalar != scalars[i] {
				return false
			}
			i = i.successor()
		}
		index = i
		return true
	}
	
	public func requirePeek() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: 1, at: scalars.count)
		}
		return scalars[index]
	}
	
	mutating func requireScalar() throws -> UnicodeScalar {
		if index == scalars.endIndex {
			throw ScalarScannerError.EndedPrematurely(count: 1, at: scalars.count)
		}
		let result = scalars[index]
		index = index.successor()
		return result
	}
	
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
	
	public mutating func requireScalars(count: Int) throws -> String {
		var result = ""
		var c = count
		while index != scalars.endIndex && c > 0 {
			result.append(scalars[index])
			index = index.successor()
			c -= 1
		}
		if c != 0 {
			throw ScalarScannerError.EndedPrematurely(count: count, at: self.scalars.startIndex.distanceTo(index))
		}
		return result
	}
}

enum SugarType {
	case None
	case Optional
	case ImplicitlyUnwrappedOptional
	case Array
	case Dictionary
}

public struct SwiftIdentifier: CustomStringConvertible {
	public let kind: Kind
	public let children: [SwiftIdentifier]
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
	
	init(kind: Kind, children: [SwiftIdentifier] = [], contents: Contents = .None) {
		self.kind = kind
		self.children = children
		self.contents = contents
	}
	
	public var description: String {
		return print()
	}
	
	@warn_unused_result
	func printChild(index: Int, asContext: Bool = false, suppressType: Bool = false) -> String {
		if index >= 0 && children.count > index {
			return children[index].print(asContext: asContext, suppressType: suppressType)
		} else {
			return ""
		}
	}
	
	@warn_unused_result
	func printFunction() -> String {
		let startIndex = children.count == 3 ? 1 : 0
		let suffix = children.count == 3 ? " throws" : ""
		return printChild(startIndex) + suffix + printChild(startIndex + 1)
	}

	@warn_unused_result
	func printEntity(hasName hasName: Bool, hasType: Bool, extraName: String, asContext: Bool, suppressType: Bool) -> String {
		var result = printChild(0, asContext: true) + "."
		if hasType && !suppressType && asContext {
			result += "("
		}
		if hasName {
			result += printChild(1)
		}
		result += extraName
		if hasType && !suppressType && children.count > (1 + (hasName ? 1 : 0)) {
			let type = children[1 + (hasName ? 1 : 0)]
			result += (useColonForType(type) ? " : " : " ") + type.print()
		}
		if hasType && !suppressType && asContext {
			result += ")"
		}
		return result
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
	
	@warn_unused_result
	func printBoundGenericNoSugar() -> String {
		guard children.count >= 2 else { return "" }
		return printChild(0) + "<" + children[1..<children.endIndex].reduce("") { (r: String, c: SwiftIdentifier) -> String in (r.isEmpty ? "" : (r + ", ")) + c.print() } + ">"
	}
	
	@warn_unused_result
	func printBoundGeneric() -> String {
		guard children.count >= 2 else { return "" }
		guard children.count == 2 else { return printBoundGenericNoSugar() }
		let sugarType = findSugar()
		switch sugarType {
		case .Optional where !children[0].children.isEmpty: fallthrough
		case .ImplicitlyUnwrappedOptional where !children[0].children.isEmpty:
			let type = children[1].children[0]
			let needParens = !type.kind.isSimpleType
			var result = ""
			if needParens {
				result += "("
			}
			result += type.print()
			if needParens {
				result += ")"
			}
			result += sugarType == .Optional ? "?" : "!"
			return result
		case .Array where !children[1].children.isEmpty:
			let type = children[1].children[0]
			return "[" + type.print() + "]"
		case .Dictionary where children[1].children.count > 1:
			let keyType = children[1].children[0]
			let valueType = children[1].children[1]
			return "[" + keyType.print() + " : " + valueType.print() + "]"
		default: return printBoundGenericNoSugar()
		}
	}

	@warn_unused_result
	func printImplFunctionType() -> String {
		enum State { case Attrs, Inputs, Results }
		var curState: State = .Attrs
		var result = ""
		childLoop: for c in children {
			if c.kind == .ImplParameter {
				switch curState {
				case .Inputs: result += ", "
				case .Attrs: result += "("
				case .Results: break childLoop
				}
				curState = .Inputs
				result += c.print()
			} else if c.kind == .ImplResult || c.kind == .ImplErrorResult {
				switch curState {
				case .Inputs: result += ") -> ("
				case .Attrs: result += "() -> ("
				case .Results: result += ", "
				}
				curState = .Results
				result += c.print()
			} else {
				result += c.print() + " "
			}
		}
		switch curState {
		case .Inputs: result += ") -> ()"
		case .Attrs: result += "() -> ()"
		case .Results: result += ")"
		}
		return result
	}
	
	@warn_unused_result
	func quotedString(value: String) -> String {
		var result = "\""
		for c in value.unicodeScalars {
			switch c {
			case "\\": result += "\\\\"
			case "\t": result += "\\t"
			case "\n": result += "\\n"
			case "\r": result += "\\r"
			case "\"": result += "\\\""
			case "\0": result += "\\0"
			default:
				if c < UnicodeScalar(0x20) || c == UnicodeScalar(0x7f) {
					result += "\\x"
					result.append(((c.value >> 4) > 9) ? UnicodeScalar(c.value + UnicodeScalar("A").value) : UnicodeScalar(c.value + UnicodeScalar("0").value))
				} else {
					result.append(c)
				}
			}
		}
		result += "\""
		return result
	}
	
	@warn_unused_result
	func print(asContext asContext: Bool = false, suppressType: Bool = false) -> String {
		switch kind {
		case .Static: return "static " + printChild(0, asContext: asContext, suppressType: suppressType)
		case .Directness:
			if case .Index(let i) = contents where i == 1 {
				return "indirect "
			} else {
				return "direct "
			}
		case .Extension: return "(extension in " + printChild(0, asContext: true) + "):" + printChild(1, asContext: asContext) + printChild(2, asContext: true)
		case .Variable: fallthrough
		case .Function: fallthrough
		case .Subscript: return printEntity(hasName: true, hasType: true, extraName: "", asContext: asContext, suppressType: suppressType)
		case .ExplicitClosure: fallthrough
		case .ImplicitClosure:
			var extraName: String = "("
			if case .ImplicitClosure = kind {
				extraName += "implicit "
			}
			extraName += "closure #\(indexFromChild(1) + 1))"
			return printEntity(hasName: false, hasType: false, extraName: extraName, asContext: asContext, suppressType: suppressType)
		case .Global: return children.reduce("") { $0 + $1.print() }
		case .Suffix: return " with unmangled suffix " + quotedString(contents.description)
		case .Initializer: return printEntity(hasName: false, hasType: false, extraName: "(variable initialization expression)", asContext: asContext, suppressType: suppressType)
		case .DefaultArgumentInitializer: return printEntity(hasName: false, hasType: false, extraName: "(default argument \(indexFromChild(1)))", asContext: asContext, suppressType: suppressType)
		case .DeclContext: return printChild(0, asContext: asContext)
		case .Type: return printChild(0, asContext: asContext)
		case .TypeMangling: return printChild(0)
		case .Class: fallthrough
		case .Structure: fallthrough
		case .Enum: fallthrough
		case .Protocol: fallthrough
		case .TypeAlias: return printEntity(hasName: true, hasType: false, extraName: "", asContext: asContext, suppressType: suppressType)
		case .LocalDeclName: return "(\(printChild(1)) #\(indexFromChild(0) + 1))"
		case .PrivateDeclName: return "(\(printChild(1)) in \(children.first?.contents.description ?? String()))"
		case .Module: fallthrough
		case .Identifier: fallthrough
		case .Index: return contents.description
		case .AutoClosureType: return "@autoclosure \(printFunction())"
		case .ThinFunctionType: return "@convention(thin) \(printFunction())"
		case .FunctionType: fallthrough
		case .UncurriedFunctionType: return printFunction()
		case .ArgumentTuple:
			let needParens = children.count != 1 || (children[0].children.count != 0 && children[0].children[0].kind != .VariadicTuple && children[0].children[0].kind != .NonVariadicTuple)
			return (needParens ? "(" : "") + children.reduce("") { $0 + $1.print() } + (needParens ? ")" : "")
		case .NonVariadicTuple: return "(" + children.reduce("") { $0 + ($0.isEmpty ? "" : ", ") + $1.print() } + ")"
		case .VariadicTuple: return "(" + children.reduce("") { $0 + ($0.isEmpty ? "" : ", ") + $1.print() } + "...)"
		case .TupleElement: return children.count == 1 ? printChild(0) : (children.count == 2 ? printChild(0) + printChild(1) : "")
		case .TupleElementName: return contents.description + " : "
		case .ReturnType: if children.count == 0 { return " -> " + contents.description } else { return " -> " + children.reduce("") { $0 + $1.print() } }
		case .Weak: return "weak " + printChild(0)
		case .Unowned: return "unowned " + printChild(0)
		case .Unmanaged: return "unowned(unsafe) " + printChild(0)
		case .InOut: return "inout " + printChild(0)
		case .NonObjCAttribute: return "@nonobjc "
		case .ObjCAttribute: return "@objc "
		case .DirectMethodReferenceAttribute: return "super "
		case .DynamicAttribute: return "dynamic "
		case .VTableAttribute: return "override "
		case .FunctionSignatureSpecialization: fallthrough
		case .GenericSpecialization: fallthrough
		case .GenericSpecializationNotReAbstracted:
			let s: String
			switch kind {
			case .FunctionSignatureSpecialization: s = "function signature specialization <"
			case .GenericSpecialization: s = "generic specialization <"
			default: s = "generic not re-abstracted specialization <"
			}
			return children.reduce("") { r, c in
				switch c.kind {
				case .SpecializationPassID: return r
				case .SpecializationIsFragile: break
				case _ where c.children.count == 0: return r
				default: break
				}
				return (r.isEmpty ? s : (r + ", ")) + c.print()
			} + "> of "
		case .SpecializationIsFragile: return "preserving fragile attribute"
		case .GenericSpecializationParam: return printChild(0) + (children.count <= 1 ? "" : children[1..<children.endIndex].reduce("") { r, c in (r.isEmpty ? " with " : " and ") + c.print() })
		case .FunctionSignatureSpecializationParam:
			var result = "Arg[\(contents.description)] = "
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
				case .Some(.BoxToStack): result += child?.print() ?? ""
				case .Some(.ConstantPropFunction): fallthrough
				case .Some(.ConstantPropGlobal):
					result += "[" + (child?.print() ?? "") + " : "
					child = childGenerator.next()
					let t = child?.contents.description ?? ""
					do {
						result += try demangle(t).description
					} catch {
						result += t
					}
					result += "]"
				case .Some(.ConstantPropInteger): fallthrough
				case .Some(.ConstantPropFloat):
					result += "[" + (child?.print() ?? "") + " : "
					child = childGenerator.next()
					result += (child?.print() ?? "") + "]"
				case .Some(.ConstantPropString):
					result += "[" + (child?.print() ?? "") + " : "
					child = childGenerator.next()
					result += (child?.print() ?? "") + "'"
					child = childGenerator.next()
					result += (child?.print() ?? "") + "']"
				case .Some(.ClosureProp):
					result += "[" + (child?.print() ?? "") + " : "
					child = childGenerator.next()
					result += (child?.print() ?? "") + ", Argument Types : ["
					child = childGenerator.next()
					while child != nil {
						if let c = child where c.kind != .Type {
							fallthrough
						}
						result += (child?.print() ?? "")
						child = childGenerator.next()
						if let c = child, case .Name = c.contents {
							result += ", "
						}
					}
					result += "]"
				default: result += (child?.print() ?? "")
				}
				child = childGenerator.next()
			}
			return result
		case .FunctionSignatureSpecializationParamPayload: return (try? demangle(contents.description).description) ?? contents.description
		case .FunctionSignatureSpecializationParamKind:
			let raw: UInt32
			if case .Index(let i) = contents {
				raw = i
			} else {
				raw = 0
			}
			var result = ""
			var printedOptionSet = false
			if raw & FunctionSigSpecializationParamKind.Dead.rawValue != 0 {
				printedOptionSet = true
				result += "Dead"
			}
			if raw & FunctionSigSpecializationParamKind.OwnedToGuaranteed.rawValue != 0 {
				if printedOptionSet {
					result += " and "
				} else {
					printedOptionSet = true
				}
				result += "Owned To Guaranteed"
			}
			if raw & FunctionSigSpecializationParamKind.SROA.rawValue != 0 {
				if printedOptionSet {
					result += " and "
				} else {
					printedOptionSet = true
				}
				result += "Exploded"
			}
			if printedOptionSet {
				return result
			}
			switch FunctionSigSpecializationParamKind(rawValue: raw) {
			case .Some(.BoxToValue): return "Value Promoted from Box"
			case .Some(.BoxToStack): return "Stack Promoted from Box"
			case .Some(.ConstantPropFunction): return "Constant Propagated Function"
			case .Some(.ConstantPropGlobal): return "Constant Propagated Global"
			case .Some(.ConstantPropInteger): return "Constant Propagated Integer"
			case .Some(.ConstantPropFloat): return "Constant Propagated Float"
			case .Some(.ConstantPropString): return "Constant Propagated String"
			case .Some(.ClosureProp): return "Closure Propagated"
			default: return ""
			}
		case .SpecializationPassID: return contents.description
		case .BuiltinTypeName: return contents.description
		case .Number: return contents.description
		case .InfixOperator: return contents.description + " infix"
		case .PrefixOperator: return contents.description + " prefix"
		case .PostfixOperator: return contents.description + " postfix"
		case .LazyProtocolWitnessTableAccessor: return "lazy protocol witness table accessor for type " + printChild(0) + " and conformance " + printChild(1)
		case .LazyProtocolWitnessTableCacheVariable: return "lazy protocol witness table cache variable for type " + printChild(0) + " and conformance " + printChild(1)
		case .ProtocolWitnessTableAccessor: return "protocol witness table accessor for " + printChild(0)
		case .ProtocolWitnessTable: return "protocol witness table for " + printChild(0)
		case .GenericProtocolWitnessTable: return "generic protocol witness table for " + printChild(0)
		case .GenericProtocolWitnessTableInstantiationFunction: return "instantiation function for generic protocol witness table for " + printChild(0)
		case .ProtocolWitness: return "protocol witness for " + printChild(1) + " in conformance " + printChild(0)
		case .PartialApplyForwarder: return "partial apply forwarder" + (children.isEmpty ? "" : (" for " + printChild(0)))
		case .PartialApplyObjCForwarder: return "partial apply ObjC forwarder" + (children.isEmpty ? "" : (" for " + printChild(0)))
		case .FieldOffset: return printChild(0) + "field offset for " + (children.count > 1 ? children[1].print() : "")
		case .ReabstractionThunk: fallthrough
		case .ReabstractionThunkHelper:
			let s: String
			if let c = children.filter({ $0.kind == .DependentGenericSignature }).first {
				s = c.print() + " "
			} else {
				s = ""
			}
			return "reabstraction thunk " + (kind == .ReabstractionThunkHelper ? "helper " : "") + s + "from " + printChild(children.count - 2) + " to " + printChild(children.count - 1)
		case .GenericTypeMetadataPattern: return "generic type metadata pattern for " + printChild(0)
		case .Metaclass: return "metaclass for " + printChild(0)
		case .ProtocolDescriptor: return "protocol descriptor for " + printChild(0)
		case .FullTypeMetadata: return "full type metadata for " + printChild(0)
		case .TypeMetadata: return "type metadata for " + printChild(0)
		case .TypeMetadataAccessFunction: return "type metadata accessor for " + printChild(0)
		case .TypeMetadataLazyCache: return "lazy cache variable for type metadata for " + printChild(0)
		case .AssociatedTypeMetadataAccessor: return "associated type metadata accessor for " + printChild(1) + " in " + printChild(0)
		case .AssociatedTypeWitnessTableAccessor: return "associated type witness table accessor for " + printChild(1) + " : " + printChild(2) + " in " + printChild(0)
		case .NominalTypeDescriptor: return "nominal type descriptor for " + printChild(0)
		case .ValueWitness:
			let s: String
			if case .Index(let i) = contents, let vwk = ValueWitnessKind(rawValue: i) {
				s = vwk.description
			} else {
				s = ""
			}
			return s + " value witness for " + printChild(0)
		case .ValueWitnessTable: return "value witness table for " + printChild(0)
		case .WitnessTableOffset: return "witness table offset for " + printChild(0)
		case .BoundGenericClass: fallthrough
		case .BoundGenericStructure: fallthrough
		case .BoundGenericEnum: return printBoundGeneric()
		case .DynamicSelf: return "Self"
		case .CFunctionPointer: return "@convention(c) " + printFunction()
		case .ObjCBlock: return "@convention(block) " + printFunction()
		case .SILBoxType: return "@box " + printChild(0)
		case .Metatype:
			var result = ""
			var childIndex = 0
			switch children.count {
			case 2:
				result += printChild(childIndex) + " "
				childIndex += 1
				fallthrough
			case 1:
				let t = children[0]
				result += t.print()
				if t.kind == .Type, let f = t.children.first where f.kind == .ExistentialMetatype || f.kind == .ProtocolList {
					result += ".Protocol"
				} else {
					result += ".Type"
				}
			default: break
			}
			return result
		case .ExistentialMetatype:
			var result = ""
			var childIndex = 0
			switch children.count {
			case 2:
				result += printChild(childIndex) + " "
				childIndex += 1
				fallthrough
			case 1:
				result += printChild(childIndex) + ".Type"
			default: break
			}
			return result
		case .MetatypeRepresentation: return contents.description
		case .ArchetypeRef: return contents.description
		case .AssociatedTypeRef: return printChild(0) + "." + ((children.count > 1) ? children[1].contents.description : "")
		case .SelfTypeRef: return printChild(0) + ".Self"
		case .ProtocolList:
			if let c = children.first {
				return ((c.children.count != 1) ? "protocol<" : "") + c.children.reduce("") { ($0.isEmpty ? "" : ($0 + ", ")) + $1.print() } + ((c.children.count != 1) ? ">" : "")
			} else {
				return ""
			}
		case .Generics:
			guard !children.isEmpty else { return "" }
			var result = "<" + printChild(0)
			var index = 1
			while index < children.count && children[index].kind == .Archetype {
				result += ", " + children[index].print()
				index += 1
			}
			result += ">"
			return result
		case .Archetype: return contents.description + (children.isEmpty ? "" : " : ") + printChild(0)
		case .AssociatedType: return ""
		case .QualifiedArchetype:
			guard children.count >= 2 else { return "" }
			return "(archetype " + children[0].contents.description + " of " + children[1].print() + ")"
		case .GenericType: return printChild(0) + (children.count > 1 ? children[1].printChild(0) : "")
		case .OwningAddressor: return printEntity(hasName: true, hasType: true, extraName: ".owningAddressor", asContext: asContext, suppressType: suppressType)
		case .OwningMutableAddressor: return printEntity(hasName: true, hasType: true, extraName: ".owningMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .NativeOwningAddressor: return printEntity(hasName: true, hasType: true, extraName: ".nativeOwningAddressor", asContext: asContext, suppressType: suppressType)
		case .NativeOwningMutableAddressor: return printEntity(hasName: true, hasType: true, extraName: ".nativeOwningMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .NativePinningAddressor: return printEntity(hasName: true, hasType: true, extraName: ".nativePinningAddressor", asContext: asContext, suppressType: suppressType)
		case .NativePinningMutableAddressor: return printEntity(hasName: true, hasType: true, extraName: ".nativePinningMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .UnsafeAddressor: return printEntity(hasName: true, hasType: true, extraName: ".unsafeAddressor", asContext: asContext, suppressType: suppressType)
		case .UnsafeMutableAddressor: return printEntity(hasName: true, hasType: true, extraName: ".unsafeMutableAddressor", asContext: asContext, suppressType: suppressType)
		case .GlobalGetter: return printEntity(hasName: true, hasType: true, extraName: ".getter", asContext: asContext, suppressType: suppressType)
		case .Getter: return printEntity(hasName: true, hasType: true, extraName: ".getter", asContext: asContext, suppressType: suppressType)
		case .Setter: return printEntity(hasName: true, hasType: true, extraName: ".setter", asContext: asContext, suppressType: suppressType)
		case .MaterializeForSet: return printEntity(hasName: true, hasType: true, extraName: ".materializeForSet", asContext: asContext, suppressType: suppressType)
		case .WillSet: return printEntity(hasName: true, hasType: true, extraName: ".willset", asContext: asContext, suppressType: suppressType)
		case .DidSet: return printEntity(hasName: true, hasType: true, extraName: ".didset", asContext: asContext, suppressType: suppressType)
		case .Allocator: return printEntity(hasName: false, hasType: true, extraName: ((children.count > 0 && children[0].kind == .Class) ? "__allocating_init" : "init"), asContext: asContext, suppressType: suppressType)
		case .Constructor: return printEntity(hasName: false, hasType: true, extraName: "init", asContext: asContext, suppressType: suppressType)
		case .Destructor: return printEntity(hasName: false, hasType: false, extraName: "deinit", asContext: asContext, suppressType: suppressType)
		case .Deallocator: return printEntity(hasName: false, hasType: false, extraName: ((children.count > 0 && children[0].kind == .Class) ? "__deallocating_deinit" : "deinit"), asContext: asContext, suppressType: suppressType)
		case .IVarInitializer: return printEntity(hasName: false, hasType: false, extraName: "__ivar_initializer", asContext: asContext, suppressType: suppressType)
		case .IVarDestroyer: return printEntity(hasName: false, hasType: false, extraName: "__ivar_destroyer", asContext: asContext, suppressType: suppressType)
		case .ProtocolConformance: return printChild(0) + " : " + printChild(1) + " in " + printChild(2)
		case .TypeList: return children.reduce("") { $0 + $1.print() }
		case .ImplConvention: return contents.description
		case .ImplFunctionAttribute: return contents.description
		case .ImplErrorResult: return children.reduce("") { ($0.isEmpty ? "@error " : ($0 + " ")) + $1.print() }
		case .ImplParameter: fallthrough
		case .ImplResult: return children.reduce("") { ($0.isEmpty ? "" : ($0 + " ")) + $1.print() }
		case .ImplFunctionType: return printImplFunctionType()
		case .ErrorType: return "<ERROR TYPE>"
		case .DependentGenericSignature:
			var result = "<"
			var depth: UInt32 = 0
			while depth < UInt32(children.count) {
				let c = children[Int(depth)]
				if c.kind != .DependentGenericParamCount { break }
				if depth != 0 {
					result += "><"
				}
				if case .Index(let index) = c.contents {
					for i in 0..<index {
						if i != 0 { result += ", " }
						result += archetypeName(i, depth)
					}
				}
				depth += 1
			}
			if depth != UInt32(children.count) {
				result += " where "
				var i = depth
				while i < UInt32(children.count) {
					if i > depth {
						result += ", "
					}
					result += printChild(Int(i))
					i += 1
				}
			}
			result += ">"
			return result
		case .DependentGenericParamCount: return ""
		case .DependentGenericConformanceRequirement: return printChild(0) + ": " + printChild(1)
		case .DependentGenericSameTypeRequirement: return printChild(0) + " == " + printChild(1)
		case .DependentGenericParamType: return contents.description
		case .DependentGenericType: return printChild(0) + " " + printChild(1)
		case .DependentMemberType: return printChild(0) + "." + printChild(1)
		case .DependentAssociatedTypeRef: return contents.description
		case .ThrowsAnnotation: return " throws "
		}
	}
	
	func useColonForType(type: SwiftIdentifier) -> Bool {
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

/// Rough adaptation of the pseudocode from 6.2 "Decoding procedure" in RFC3492
private func decodeSwiftPunycode(value: String) -> String {
	let input = value.unicodeScalars
	var output = [UnicodeScalar]()
	
	var pos = input.startIndex
	
	// Unlike RFC3492, Swift uses underscore for delimiting
	if let ipos = input.indexOf(UnicodeScalar("_")) {
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

