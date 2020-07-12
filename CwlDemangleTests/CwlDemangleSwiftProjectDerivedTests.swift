//
//  CwlDemangleSwiftProjectDerivedTests.swift
//  CwlDemangleSwiftProjectDerivedTests
//
//  Created by Matt Gallagher on 2016/04/30.
//  Copyright © 2016 Matt Gallagher. All rights reserved.
//
//  Licensed under Apache License v2.0 with Runtime Library Exception
//
//  See http://swift.org/LICENSE.txt for license information
//  See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

#if SWIFT_PACKAGE
@testable import CwlDemangle
#endif
import XCTest

class CwlDemangleSwiftProjectDerivedTests: XCTestCase {
	func test_TtBf32_() {
		let input = "_TtBf32_"
		let output = "Builtin.FPIEEE32"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBf64_() {
		let input = "_TtBf64_"
		let output = "Builtin.FPIEEE64"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBf80_() {
		let input = "_TtBf80_"
		let output = "Builtin.FPIEEE80"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBi32_() {
		let input = "_TtBi32_"
		let output = "Builtin.Int32"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sBf32_() {
		let input = "$sBf32_"
		let output = "Builtin.FPIEEE32"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sBf64_() {
		let input = "$sBf64_"
		let output = "Builtin.FPIEEE64"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sBf80_() {
		let input = "$sBf80_"
		let output = "Builtin.FPIEEE80"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sBi32_() {
		let input = "$sBi32_"
		let output = "Builtin.Int32"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBw() {
		let input = "_TtBw"
		let output = "Builtin.Word"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBO() {
		let input = "_TtBO"
		let output = "Builtin.UnknownObject"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBo() {
		let input = "_TtBo"
		let output = "Builtin.NativeObject"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBp() {
		let input = "_TtBp"
		let output = "Builtin.RawPointer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBt() {
		let input = "_TtBt"
		let output = "Builtin.SILToken"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBv4Bi8_() {
		let input = "_TtBv4Bi8_"
		let output = "Builtin.Vec4xInt8"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBv4Bf16_() {
		let input = "_TtBv4Bf16_"
		let output = "Builtin.Vec4xFloat16"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtBv4Bp() {
		let input = "_TtBv4Bp"
		let output = "Builtin.Vec4xRawPointer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSa() {
		let input = "_TtSa"
		let output = "Swift.Array"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSb() {
		let input = "_TtSb"
		let output = "Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSc() {
		let input = "_TtSc"
		let output = "Swift.UnicodeScalar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSd() {
		let input = "_TtSd"
		let output = "Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSf() {
		let input = "_TtSf"
		let output = "Swift.Float"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSi() {
		let input = "_TtSi"
		let output = "Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSq() {
		let input = "_TtSq"
		let output = "Swift.Optional"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSS() {
		let input = "_TtSS"
		let output = "Swift.String"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSu() {
		let input = "_TtSu"
		let output = "Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSPSi_() {
		let input = "_TtGSPSi_"
		let output = "Swift.UnsafePointer<Swift.Int>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSpSi_() {
		let input = "_TtGSpSi_"
		let output = "Swift.UnsafeMutablePointer<Swift.Int>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSV() {
		let input = "_TtSV"
		let output = "Swift.UnsafeRawPointer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtSv() {
		let input = "_TtSv"
		let output = "Swift.UnsafeMutableRawPointer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSaSS_() {
		let input = "_TtGSaSS_"
		let output = "[Swift.String]"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSqSS_() {
		let input = "_TtGSqSS_"
		let output = "Swift.String?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGVs10DictionarySSSi_() {
		let input = "_TtGVs10DictionarySSSi_"
		let output = "[Swift.String : Swift.Int]"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtVs7CString() {
		let input = "_TtVs7CString"
		let output = "Swift.CString"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtCSo8NSObject() {
		let input = "_TtCSo8NSObject"
		let output = "__C.NSObject"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtO6Monads6Either() {
		let input = "_TtO6Monads6Either"
		let output = "Monads.Either"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtbSiSu() {
		let input = "_TtbSiSu"
		let output = "@convention(block) (Swift.Int) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtcSiSu() {
		let input = "_TtcSiSu"
		let output = "@convention(c) (Swift.Int) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtbTSiSc_Su() {
		let input = "_TtbTSiSc_Su"
		let output = "@convention(block) (Swift.Int, Swift.UnicodeScalar) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtcTSiSc_Su() {
		let input = "_TtcTSiSc_Su"
		let output = "@convention(c) (Swift.Int, Swift.UnicodeScalar) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtFSiSu() {
		let input = "_TtFSiSu"
		let output = "(Swift.Int) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtKSiSu() {
		let input = "_TtKSiSu"
		let output = "@autoclosure (Swift.Int) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtFSiFScSu() {
		let input = "_TtFSiFScSu"
		let output = "(Swift.Int) -> (Swift.UnicodeScalar) -> Swift.UInt"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtMSi() {
		let input = "_TtMSi"
		let output = "Swift.Int.Type"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtP_() {
		let input = "_TtP_"
		let output = "Any"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtP3foo3bar_() {
		let input = "_TtP3foo3bar_"
		let output = "foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtP3foo3barS_3bas_() {
		let input = "_TtP3foo3barS_3bas_"
		let output = "foo.bar & foo.bas"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtTP3foo3barS_3bas_PS1__PS1_S_3zimS0___() {
		let input = "_TtTP3foo3barS_3bas_PS1__PS1_S_3zimS0___"
		let output = "(foo.bar & foo.bas, foo.bas, foo.bas & foo.zim & foo.bar)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtRSi() {
		let input = "_TtRSi"
		let output = "inout Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtTSiSu_() {
		let input = "_TtTSiSu_"
		let output = "(Swift.Int, Swift.UInt)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TttSiSu_() {
		let input = "_TttSiSu_"
		let output = "(Swift.Int, Swift.UInt...)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtT3fooSi3barSu_() {
		let input = "_TtT3fooSi3barSu_"
		let output = "(foo: Swift.Int, bar: Swift.UInt)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TturFxx() {
		let input = "_TturFxx"
		let output = "<A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuzrFT_T_() {
		let input = "_TtuzrFT_T_"
		let output = "<>() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Ttu__rFxqd__() {
		let input = "_Ttu__rFxqd__"
		let output = "<A><A1>(A) -> A1"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Ttu_z_rFxqd0__() {
		let input = "_Ttu_z_rFxqd0__"
		let output = "<A><><A2>(A) -> A2"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Ttu0_rFxq_() {
		let input = "_Ttu0_rFxq_"
		let output = "<A, B>(A) -> B"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxs8RunciblerFxwx5Mince() {
		let input = "_TtuRxs8RunciblerFxwx5Mince"
		let output = "<A where A: Swift.Runcible>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxle64xs8RunciblerFxwx5Mince() {
		let input = "_TtuRxle64xs8RunciblerFxwx5Mince"
		let output = "<A where A: _Trivial(64), A: Swift.Runcible>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlE64_16rFxwx5Mince() {
		let input = "_TtuRxlE64_16rFxwx5Mince"
		let output = "<A where A: _Trivial(64, 16)>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlE64_32xs8RunciblerFxwx5Mince() {
		let input = "_TtuRxlE64_32xs8RunciblerFxwx5Mince"
		let output = "<A where A: _Trivial(64, 32), A: Swift.Runcible>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlM64_16rFxwx5Mince() {
		let input = "_TtuRxlM64_16rFxwx5Mince"
		let output = "<A where A: _TrivialAtMost(64, 16)>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxle64rFxwx5Mince() {
		let input = "_TtuRxle64rFxwx5Mince"
		let output = "<A where A: _Trivial(64)>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlm64rFxwx5Mince() {
		let input = "_TtuRxlm64rFxwx5Mince"
		let output = "<A where A: _TrivialAtMost(64)>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlNrFxwx5Mince() {
		let input = "_TtuRxlNrFxwx5Mince"
		let output = "<A where A: _NativeRefCountedObject>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlRrFxwx5Mince() {
		let input = "_TtuRxlRrFxwx5Mince"
		let output = "<A where A: _RefCountedObject>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxlUrFxwx5Mince() {
		let input = "_TtuRxlUrFxwx5Mince"
		let output = "<A where A: _UnknownLayout>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxs8RunciblerFxWx5Mince6Quince_() {
		let input = "_TtuRxs8RunciblerFxWx5Mince6Quince_"
		let output = "<A where A: Swift.Runcible>(A) -> A.Mince.Quince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince() {
		let input = "_TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince"
		let output = "<A where A: Swift.Runcible, A: Swift.Fungible>(A) -> A.Swift.Runcible.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxCs22AbstractRuncingFactoryrFxx() {
		let input = "_TtuRxCs22AbstractRuncingFactoryrFxx"
		let output = "<A where A: Swift.AbstractRuncingFactory>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxs8Runciblewx5MincezxrFxx() {
		let input = "_TtuRxs8Runciblewx5MincezxrFxx"
		let output = "<A where A: Swift.Runcible, A.Mince == A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxs8RuncibleWx5Mince6Quince_zxrFxx() {
		let input = "_TtuRxs8RuncibleWx5Mince6Quince_zxrFxx"
		let output = "<A where A: Swift.Runcible, A.Mince.Quince == A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Ttu0_Rxs8Runcible_S_wx5Minces8Fungiblew_S0_S1_rFxq_() {
		let input = "_Ttu0_Rxs8Runcible_S_wx5Minces8Fungiblew_S0_S1_rFxq_"
		let output = "<A, B where A: Swift.Runcible, B: Swift.Runcible, A.Mince: Swift.Fungible, B.Mince: Swift.Fungible>(A) -> B"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Ttu0_Rx3Foo3BarxCS_3Bas_S0__S1_rT_() {
		let input = "_Ttu0_Rx3Foo3BarxCS_3Bas_S0__S1_rT_"
		let output = "<A, B where A: Foo.Bar, A: Foo.Bas, B: Foo.Bar, B: Foo.Bas> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Tv3foo3barSi() {
		let input = "_Tv3foo3barSi"
		let output = "foo.bar : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3fooau3barSi() {
		let input = "_TF3fooau3barSi"
		let output = "foo.bar.unsafeMutableAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foolu3barSi() {
		let input = "_TF3foolu3barSi"
		let output = "foo.bar.unsafeAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3fooaO3barSi() {
		let input = "_TF3fooaO3barSi"
		let output = "foo.bar.owningMutableAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foolO3barSi() {
		let input = "_TF3foolO3barSi"
		let output = "foo.bar.owningAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3fooao3barSi() {
		let input = "_TF3fooao3barSi"
		let output = "foo.bar.nativeOwningMutableAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foolo3barSi() {
		let input = "_TF3foolo3barSi"
		let output = "foo.bar.nativeOwningAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3fooap3barSi() {
		let input = "_TF3fooap3barSi"
		let output = "foo.bar.nativePinningMutableAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foolp3barSi() {
		let input = "_TF3foolp3barSi"
		let output = "foo.bar.nativePinningAddressor : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foog3barSi() {
		let input = "_TF3foog3barSi"
		let output = "foo.bar.getter : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foos3barSi() {
		let input = "_TF3foos3barSi"
		let output = "foo.bar.setter : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC3foo3bar3basfT3zimCS_3zim_T_() {
		let input = "_TFC3foo3bar3basfT3zimCS_3zim_T_"
		let output = "foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TToFC3foo3bar3basfT3zimCS_3zim_T_() {
		let input = "_TToFC3foo3bar3basfT3zimCS_3zim_T_"
		let output = "@objc foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTOFSC3fooFTSdSd_Sd() {
		let input = "_TTOFSC3fooFTSdSd_Sd"
		let output = "@nonobjc __C_Synthesized.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T03foo3barC3basyAA3zimCAE_tFTo() {
		let input = "_T03foo3barC3basyAA3zimCAE_tFTo"
		let output = "@objc foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0SC3fooS2d_SdtFTO() {
		let input = "_T0SC3fooS2d_SdtFTO"
		let output = "@nonobjc __C_Synthesized.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$s3foo3barC3bas3zimyAaEC_tFTo() {
		let input = "_$s3foo3barC3bas3zimyAaEC_tFTo"
		let output = "@objc foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$sSC3fooyS2d_SdtFTO() {
		let input = "_$sSC3fooyS2d_SdtFTO"
		let output = "@nonobjc __C_Synthesized.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S3foo3barC3bas3zimyAaEC_tFTo() {
		let input = "_$S3foo3barC3bas3zimyAaEC_tFTo"
		let output = "@objc foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$SSC3fooyS2d_SdtFTO() {
		let input = "_$SSC3fooyS2d_SdtFTO"
		let output = "@nonobjc __C_Synthesized.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$sTAdot123() {
		let input = "_$sTA.123"
		let output = "partial apply forwarder with unmangled suffix \".123\""
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTDFC3foo3bar3basfT3zimCS_3zim_T_() {
		let input = "_TTDFC3foo3bar3basfT3zimCS_3zim_T_"
		let output = "dynamic foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foooi1pFTCS_3barVS_3bas_OS_3zim() {
		let input = "_TF3foooi1pFTCS_3barVS_3bas_OS_3zim"
		let output = "foo.+ infix(foo.bar, foo.bas) -> foo.zim"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF3foooP1xFTCS_3barVS_3bas_OS_3zim() {
		let input = "_TF3foooP1xFTCS_3barVS_3bas_OS_3zim"
		let output = "foo.^ postfix(foo.bar, foo.bas) -> foo.zim"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC3foo3barCfT_S0_() {
		let input = "_TFC3foo3barCfT_S0_"
		let output = "foo.bar.__allocating_init() -> foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC3foo3barcfT_S0_() {
		let input = "_TFC3foo3barcfT_S0_"
		let output = "foo.bar.init() -> foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC3foo3barD() {
		let input = "_TFC3foo3barD"
		let output = "foo.bar.__deallocating_deinit"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC3foo3bard() {
		let input = "_TFC3foo3bard"
		let output = "foo.bar.deinit"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TMPC3foo3bar() {
		let input = "_TMPC3foo3bar"
		let output = "generic type metadata pattern for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TMnC3foo3bar() {
		let input = "_TMnC3foo3bar"
		let output = "nominal type descriptor for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TMmC3foo3bar() {
		let input = "_TMmC3foo3bar"
		let output = "metaclass for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TMC3foo3bar() {
		let input = "_TMC3foo3bar"
		let output = "type metadata for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TMfC3foo3bar() {
		let input = "_TMfC3foo3bar"
		let output = "full type metadata for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwalC3foo3bar() {
		let input = "_TwalC3foo3bar"
		let output = "allocateBuffer value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwcaC3foo3bar() {
		let input = "_TwcaC3foo3bar"
		let output = "assignWithCopy value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwtaC3foo3bar() {
		let input = "_TwtaC3foo3bar"
		let output = "assignWithTake value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwdeC3foo3bar() {
		let input = "_TwdeC3foo3bar"
		let output = "deallocateBuffer value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwxxC3foo3bar() {
		let input = "_TwxxC3foo3bar"
		let output = "destroy value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwXXC3foo3bar() {
		let input = "_TwXXC3foo3bar"
		let output = "destroyBuffer value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwCPC3foo3bar() {
		let input = "_TwCPC3foo3bar"
		let output = "initializeBufferWithCopyOfBuffer value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwCpC3foo3bar() {
		let input = "_TwCpC3foo3bar"
		let output = "initializeBufferWithCopy value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwcpC3foo3bar() {
		let input = "_TwcpC3foo3bar"
		let output = "initializeWithCopy value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwTKC3foo3bar() {
		let input = "_TwTKC3foo3bar"
		let output = "initializeBufferWithTakeOfBuffer value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwTkC3foo3bar() {
		let input = "_TwTkC3foo3bar"
		let output = "initializeBufferWithTake value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwtkC3foo3bar() {
		let input = "_TwtkC3foo3bar"
		let output = "initializeWithTake value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TwprC3foo3bar() {
		let input = "_TwprC3foo3bar"
		let output = "projectBuffer value witness for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWVC3foo3bar() {
		let input = "_TWVC3foo3bar"
		let output = "value witness table for foo.bar"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWvdvC3foo3bar3basSi() {
		let input = "_TWvdvC3foo3bar3basSi"
		let output = "direct field offset for foo.bar.bas : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWvivC3foo3bar3basSi() {
		let input = "_TWvivC3foo3bar3basSi"
		let output = "indirect field offset for foo.bar.bas : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWPC3foo3barS_8barrables() {
		let input = "_TWPC3foo3barS_8barrables"
		let output = "protocol witness table for foo.bar : foo.barrable in Swift"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWaC3foo3barS_8barrableS_() {
		let input = "_TWaC3foo3barS_8barrableS_"
		let output = "protocol witness table accessor for foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWlC3foo3barS0_S_8barrableS_() {
		let input = "_TWlC3foo3barS0_S_8barrableS_"
		let output = "lazy protocol witness table accessor for type foo.bar and conformance foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWLC3foo3barS0_S_8barrableS_() {
		let input = "_TWLC3foo3barS0_S_8barrableS_"
		let output = "lazy protocol witness table cache variable for type foo.bar and conformance foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWGC3foo3barS_8barrableS_() {
		let input = "_TWGC3foo3barS_8barrableS_"
		let output = "generic protocol witness table for foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWIC3foo3barS_8barrableS_() {
		let input = "_TWIC3foo3barS_8barrableS_"
		let output = "instantiation function for generic protocol witness table for foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWtC3foo3barS_8barrableS_4fred() {
		let input = "_TWtC3foo3barS_8barrableS_4fred"
		let output = "associated type metadata accessor for fred in foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TWTC3foo3barS_8barrableS_4fredS_6thomas() {
		let input = "_TWTC3foo3barS_8barrableS_4fredS_6thomas"
		let output = "associated type witness table accessor for fred : foo.thomas in foo.bar : foo.barrable in foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFSCg5greenVSC5Color() {
		let input = "_TFSCg5greenVSC5Color"
		let output = "__C_Synthesized.green.getter : __C_Synthesized.Color"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TIF1t1fFT1iSi1sSS_T_A_() {
		let input = "_TIF1t1fFT1iSi1sSS_T_A_"
		let output = "default argument 0 of t.f(i: Swift.Int, s: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TIF1t1fFT1iSi1sSS_T_A0_() {
		let input = "_TIF1t1fFT1iSi1sSS_T_A0_"
		let output = "default argument 1 of t.f(i: Swift.Int, s: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFSqcfT_GSqx_() {
		let input = "_TFSqcfT_GSqx_"
		let output = "Swift.Optional.init() -> A?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF21class_bound_protocols32class_bound_protocol_compositionFT1xPS_10ClassBoundS_13NotClassBound__PS0_S1__() {
		let input = "_TF21class_bound_protocols32class_bound_protocol_compositionFT1xPS_10ClassBoundS_13NotClassBound__PS0_S1__"
		let output = "class_bound_protocols.class_bound_protocol_composition(x: class_bound_protocols.ClassBound & class_bound_protocols.NotClassBound) -> class_bound_protocols.ClassBound & class_bound_protocols.NotClassBound"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtZZ() {
		let input = "_TtZZ"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtB() {
		let input = "_TtB"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtBSi() {
		let input = "_TtBSi"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtBx() {
		let input = "_TtBx"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtC() {
		let input = "_TtC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtT() {
		let input = "_TtT"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtTSi() {
		let input = "_TtTSi"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtQd_() {
		let input = "_TtQd_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtU__FQo_Si() {
		let input = "_TtU__FQo_Si"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtU__FQD__Si() {
		let input = "_TtU__FQD__Si"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtU___FQ_U____FQd0__T_() {
		let input = "_TtU___FQ_U____FQd0__T_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtU___FQ_U____FQd_1_T_() {
		let input = "_TtU___FQ_U____FQd_1_T_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtU___FQ_U____FQ2_T_() {
		let input = "_TtU___FQ_U____FQ2_T_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_Tw() {
		let input = "_Tw"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWa() {
		let input = "_TWa"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_Twal() {
		let input = "_Twal"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T() {
		let input = "_T"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTo() {
		let input = "_TTo"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TC() {
		let input = "_TC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TM() {
		let input = "_TM"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TW() {
		let input = "_TW"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWV() {
		let input = "_TWV"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWo() {
		let input = "_TWo"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWv() {
		let input = "_TWv"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWvd() {
		let input = "_TWvd"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWvi() {
		let input = "_TWvi"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TWvx() {
		let input = "_TWvx"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtVCC4main3Foo4Ding3Str() {
		let input = "_TtVCC4main3Foo4Ding3Str"
		let output = "main.Foo.Ding.Str"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFVCC6nested6AClass12AnotherClass7AStruct9aFunctionfT1aSi_S2_() {
		let input = "_TFVCC6nested6AClass12AnotherClass7AStruct9aFunctionfT1aSi_S2_"
		let output = "nested.AClass.AnotherClass.AStruct.aFunction(a: Swift.Int) -> nested.AClass.AnotherClass.AStruct"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtXwC10attributes10SwiftClass() {
		let input = "_TtXwC10attributes10SwiftClass"
		let output = "weak attributes.SwiftClass"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtXoC10attributes10SwiftClass() {
		let input = "_TtXoC10attributes10SwiftClass"
		let output = "unowned attributes.SwiftClass"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtERR() {
		let input = "_TtERR"
		let output = "<ERROR TYPE>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSqGSaC5sugar7MyClass__() {
		let input = "_TtGSqGSaC5sugar7MyClass__"
		let output = "[sugar.MyClass]?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSaGSqC5sugar7MyClass__() {
		let input = "_TtGSaGSqC5sugar7MyClass__"
		let output = "[sugar.MyClass?]"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtaC9typealias5DWARF9DIEOffset() {
		let input = "_TtaC9typealias5DWARF9DIEOffset"
		let output = "typealias.DWARF.DIEOffset"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Tta1t5Alias() {
		let input = "_Tta1t5Alias"
		let output = "t.Alias"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_Ttas3Int() {
		let input = "_Ttas3Int"
		let output = "Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRXFo_dSc_dSb_XFo_iSc_iSb_() {
		let input = "_TTRXFo_dSc_dSb_XFo_iSc_iSb_"
		let output = "reabstraction thunk helper from @callee_owned (@in Swift.UnicodeScalar) -> (@out Swift.Bool) to @callee_owned (@unowned Swift.UnicodeScalar) -> (@unowned Swift.Bool)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__() {
		let input = "_TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__"
		let output = "reabstraction thunk helper from @callee_owned (@in Swift.Int) -> (@out Swift.Int?) to @callee_owned (@unowned Swift.Int) -> (@unowned Swift.Int?)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_() {
		let input = "_TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_"
		let output = "reabstraction thunk helper <A> from @callee_owned (@unowned switch_abstraction.A) -> (@out A) to @callee_owned (@in switch_abstraction.A) -> (@out A)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCF5types1gFT1bSb_T_L0_10Collection3zimfT_T_() {
		let input = "_TFCF5types1gFT1bSb_T_L0_10Collection3zimfT_T_"
		let output = "zim() -> () in Collection #2 in types.g(b: Swift.Bool) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFF17capture_promotion22test_capture_promotionFT_FT_SiU_FT_Si_promote0() {
		let input = "_TFF17capture_promotion22test_capture_promotionFT_FT_SiU_FT_Si_promote0"
		let output = "closure #1 () -> Swift.Int in capture_promotion.test_capture_promotion() -> () -> Swift.Int with unmangled suffix \"_promote0\""
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFIVs8_Processi10_argumentsGSaSS_U_FT_GSaSS_() {
		let input = "_TFIVs8_Processi10_argumentsGSaSS_U_FT_GSaSS_"
		let output = "_arguments : [Swift.String] in variable initialization expression of Swift._Process with unmangled suffix \"U_FT_GSaSS_\""
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFIvVs8_Process10_argumentsGSaSS_iU_FT_GSaSS_() {
		let input = "_TFIvVs8_Process10_argumentsGSaSS_iU_FT_GSaSS_"
		let output = "closure #1 () -> [Swift.String] in variable initialization expression of Swift._Process._arguments : [Swift.String]"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCSo1AE() {
		let input = "_TFCSo1AE"
		let output = "__C.A.__ivar_destroyer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCSo1Ae() {
		let input = "_TFCSo1Ae"
		let output = "__C.A.__ivar_initializer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTWC13call_protocol1CS_1PS_FS1_3foofT_Si() {
		let input = "_TTWC13call_protocol1CS_1PS_FS1_3foofT_Si"
		let output = "protocol witness for call_protocol.P.foo() -> Swift.Int in conformance call_protocol.C : call_protocol.P in call_protocol"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T013call_protocol1CCAA1PA2aDP3fooSiyFTW() {
		let input = "_T013call_protocol1CCAA1PA2aDP3fooSiyFTW"
		let output = "protocol witness for call_protocol.P.foo() -> Swift.Int in conformance call_protocol.C : call_protocol.P in call_protocol"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC12dynamic_self1X1ffT_DS0_() {
		let input = "_TFC12dynamic_self1X1ffT_DS0_"
		let output = "dynamic_self.X.f() -> Self"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSg5Si___TFSqcfT_GSqx_() {
		let input = "_TTSg5Si___TFSqcfT_GSqx_"
		let output = "generic specialization <Swift.Int> of Swift.Optional.init() -> A?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSgq5Si___TFSqcfT_GSqx_() {
		let input = "_TTSgq5Si___TFSqcfT_GSqx_"
		let output = "generic specialization <serialized, Swift.Int> of Swift.Optional.init() -> A?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSg5SiSis3Foos_Sf___TFSqcfT_GSqx_() {
		let input = "_TTSg5SiSis3Foos_Sf___TFSqcfT_GSqx_"
		let output = "generic specialization <Swift.Int with Swift.Int : Swift.Foo in Swift, Swift.Float> of Swift.Optional.init() -> A?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSg5Si_Sf___TFSqcfT_GSqx_() {
		let input = "_TTSg5Si_Sf___TFSqcfT_GSqx_"
		let output = "generic specialization <Swift.Int, Swift.Float> of Swift.Optional.init() -> A?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSgS() {
		let input = "_TTSgS"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSg5S() {
		let input = "_TTSg5S"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSgSi() {
		let input = "_TTSgSi"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSg5Si() {
		let input = "_TTSg5Si"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSgSi_() {
		let input = "_TTSgSi_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSgSi__() {
		let input = "_TTSgSi__"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSgSiS_() {
		let input = "_TTSgSiS_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSgSi__xyz() {
		let input = "_TTSgSi__xyz"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSr5Si___TF4test7genericurFxx() {
		let input = "_TTSr5Si___TF4test7genericurFxx"
		let output = "generic not re-abstracted specialization <Swift.Int> of test.generic<A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSrq5Si___TF4test7genericurFxx() {
		let input = "_TTSrq5Si___TF4test7genericurFxx"
		let output = "generic not re-abstracted specialization <serialized, Swift.Int> of test.generic<A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_() {
		let input = "_TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_"
		let output = "partial apply forwarder for reabstraction thunk helper from @callee_owned (@in Swift.String, @in Swift.String) -> (@unowned Swift.Bool) to @callee_owned (@owned Swift.String, @owned Swift.String) -> (@unowned Swift.Bool)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TPAo__TTRGrXFo_dGSPx__dGSPx_zoPs5Error__XFo_iGSPx__iGSPx_zoPS___() {
		let input = "_TPAo__TTRGrXFo_dGSPx__dGSPx_zoPs5Error__XFo_iGSPx__iGSPx_zoPS___"
		let output = "partial apply ObjC forwarder for reabstraction thunk helper <A> from @callee_owned (@in Swift.UnsafePointer<A>) -> (@out Swift.UnsafePointer<A>, @error @owned Swift.Error) to @callee_owned (@unowned Swift.UnsafePointer<A>) -> (@unowned Swift.UnsafePointer<A>, @error @owned Swift.Error)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0S2SSbIxxxd_S2SSbIxiid_TRTA() {
		let input = "_T0S2SSbIxxxd_S2SSbIxiid_TRTA"
		let output = "partial apply forwarder for reabstraction thunk helper from @callee_owned (@owned Swift.String, @owned Swift.String) -> (@unowned Swift.Bool) to @callee_owned (@in Swift.String, @in Swift.String) -> (@unowned Swift.Bool)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0SPyxGAAs5Error_pIxydzo_A2AsAB_pIxirzo_lTRTa() {
		let input = "_T0SPyxGAAs5Error_pIxydzo_A2AsAB_pIxirzo_lTRTa"
		let output = "partial apply ObjC forwarder for reabstraction thunk helper <A> from @callee_owned (@unowned Swift.UnsafePointer<A>) -> (@unowned Swift.UnsafePointer<A>, @error @owned Swift.Error) to @callee_owned (@in Swift.UnsafePointer<A>) -> (@out Swift.UnsafePointer<A>, @error @owned Swift.Error)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TiC4Meow5MyCls9subscriptFT1iSi_Sf() {
		let input = "_TiC4Meow5MyCls9subscriptFT1iSi_Sf"
		let output = "Meow.MyCls.subscript(i: Swift.Int) -> Swift.Float"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF8manglingX22egbpdajGbuEbxfgehfvwxnFT_T_() {
		let input = "_TF8manglingX22egbpdajGbuEbxfgehfvwxnFT_T_"
		let output = "mangling.ليهمابتكلموشعربي؟() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF8manglingX24ihqwcrbEcvIaIdqgAFGpqjyeFT_T_() {
		let input = "_TF8manglingX24ihqwcrbEcvIaIdqgAFGpqjyeFT_T_"
		let output = "mangling.他们为什么不说中文() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF8manglingX27ihqwctvzcJBfGFJdrssDxIboAybFT_T_() {
		let input = "_TF8manglingX27ihqwctvzcJBfGFJdrssDxIboAybFT_T_"
		let output = "mangling.他們爲什麽不說中文() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF8manglingX30Proprostnemluvesky_uybCEdmaEBaFT_T_() {
		let input = "_TF8manglingX30Proprostnemluvesky_uybCEdmaEBaFT_T_"
		let output = "mangling.Pročprostěnemluvíčesky() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF8manglingXoi7p_qcaDcFTSiSi_Si() {
		let input = "_TF8manglingXoi7p_qcaDcFTSiSi_Si"
		let output = "mangling.«+» infix(Swift.Int, Swift.Int) -> Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF8manglingoi2qqFTSiSi_T_() {
		let input = "_TF8manglingoi2qqFTSiSi_T_"
		let output = "mangling.?? infix(Swift.Int, Swift.Int) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFE11ext_structAV11def_structA1A4testfT_T_() {
		let input = "_TFE11ext_structAV11def_structA1A4testfT_T_"
		let output = "(extension in ext_structA):def_structA.A.test() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF13devirt_accessP5_DISC15getPrivateClassFT_CS_P5_DISC12PrivateClass() {
		let input = "_TF13devirt_accessP5_DISC15getPrivateClassFT_CS_P5_DISC12PrivateClass"
		let output = "devirt_access.(getPrivateClass in _DISC)() -> devirt_access.(PrivateClass in _DISC)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF4mainP5_mainX3wxaFT_T_() {
		let input = "_TF4mainP5_mainX3wxaFT_T_"
		let output = "main.(λ in _main)() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TF4mainP5_main3abcFT_aS_P5_DISC3xyz() {
		let input = "_TF4mainP5_main3abcFT_aS_P5_DISC3xyz"
		let output = "main.(abc in _main)() -> main.(xyz in _DISC)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtPMP_() {
		let input = "_TtPMP_"
		let output = "Any.Type"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCs13_NSSwiftArray29canStoreElementsOfDynamicTypefPMP_Sb() {
		let input = "_TFCs13_NSSwiftArray29canStoreElementsOfDynamicTypefPMP_Sb"
		let output = "Swift._NSSwiftArray.canStoreElementsOfDynamicType(Any.Type) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCs13_NSSwiftArrayg17staticElementTypePMP_() {
		let input = "_TFCs13_NSSwiftArrayg17staticElementTypePMP_"
		let output = "Swift._NSSwiftArray.staticElementType.getter : Any.Type"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCs17_DictionaryMirrorg9valueTypePMP_() {
		let input = "_TFCs17_DictionaryMirrorg9valueTypePMP_"
		let output = "Swift._DictionaryMirror.valueType.getter : Any.Type"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <Arg[0] = [Closure Propagated : closure #1 (Swift.Int, Swift.Int) -> () in specgen.caller(Swift.Int) -> (), Argument Types : [Swift.Int]> of specgen.take_closure((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <serialized, Arg[0] = [Closure Propagated : closure #1 (Swift.Int, Swift.Int) -> () in specgen.caller(Swift.Int) -> (), Argument Types : [Swift.Int]> of specgen.take_closure((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TTSg5Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TTSg5Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <Arg[0] = [Closure Propagated : closure #1 (Swift.Int, Swift.Int) -> () in specgen.caller(Swift.Int) -> (), Argument Types : [Swift.Int]> of generic specialization <Swift.Int> of specgen.take_closure((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSg5Si___TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSg5Si___TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "generic specialization <Swift.Int> of function signature specialization <Arg[0] = [Closure Propagated : closure #1 (Swift.Int, Swift.Int) -> () in specgen.caller(Swift.Int) -> (), Argument Types : [Swift.Int]> of specgen.take_closure((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__() {
		let input = "_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : capturep.helper(Swift.Int) -> ()]> of reabstraction thunk helper from @callee_owned (@in Swift.Int) -> (@unowned ()) to @callee_owned (@unowned Swift.Int) -> (@unowned ())"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__() {
		let input = "_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : capturep.helper(Swift.Int) -> ()]> of reabstraction thunk helper from @callee_owned (@in Swift.Int) -> (@unowned_inner_pointer ()) to @callee_owned (@unowned Swift.Int) -> (@unowned_inner_pointer ())"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cpi0_cpfl0_cpse0v4u123_cpg53globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8_cpfr36_TFtest_capture_propagation2_closure___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSf1cpi0_cpfl0_cpse0v4u123_cpg53globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8_cpfr36_TFtest_capture_propagation2_closure___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Integer : 0], Arg[1] = [Constant Propagated Float : 0], Arg[2] = [Constant Propagated String : u8'u123'], Arg[3] = [Constant Propagated Global : globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8], Arg[4] = [Constant Propagated Function : _TFtest_capture_propagation2_closure]> of specgen.take_closure((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf0gs___TFVs17_LegacyStringCore15_invariantCheckfT_T_() {
		let input = "_TTSf0gs___TFVs17_LegacyStringCore15_invariantCheckfT_T_"
		let output = "function signature specialization <Arg[0] = Owned To Guaranteed and Exploded> of Swift._LegacyStringCore._invariantCheck() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2g___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2g___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Owned To Guaranteed> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2dg___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dg___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Owned To Guaranteed> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2dgs___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dgs___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Owned To Guaranteed and Exploded> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf3d_i_d_i_d_i___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf3d_i_d_i_d_i___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead, Arg[1] = Value Promoted from Box, Arg[2] = Dead, Arg[3] = Value Promoted from Box, Arg[4] = Dead, Arg[5] = Value Promoted from Box> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf3d_i_n_i_d_i___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf3d_i_n_i_d_i___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead, Arg[1] = Value Promoted from Box, Arg[3] = Value Promoted from Box, Arg[4] = Dead, Arg[5] = Value Promoted from Box> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFIZvV8mangling10HasVarInit5stateSbiu_KT_Sb() {
		let input = "_TFIZvV8mangling10HasVarInit5stateSbiu_KT_Sb"
		let output = "implicit closure #1 : @autoclosure () -> Swift.Bool in variable initialization expression of static mangling.HasVarInit.state : Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFFV23interface_type_mangling18GenericTypeContext23closureInGenericContexturFqd__T_L_3fooFTqd__x_T_() {
		let input = "_TFFV23interface_type_mangling18GenericTypeContext23closureInGenericContexturFqd__T_L_3fooFTqd__x_T_"
		let output = "foo #1 (A1, A) -> () in interface_type_mangling.GenericTypeContext.closureInGenericContext<A>(A1) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFFV23interface_type_mangling18GenericTypeContextg31closureInGenericPropertyContextxL_3fooFT_x() {
		let input = "_TFFV23interface_type_mangling18GenericTypeContextg31closureInGenericPropertyContextxL_3fooFT_x"
		let output = "foo #1 () -> A in interface_type_mangling.GenericTypeContext.closureInGenericPropertyContext.getter : A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_23closureInGenericContextuRxS1_rfqd__T_() {
		let input = "_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_23closureInGenericContextuRxS1_rfqd__T_"
		let output = "protocol witness for interface_type_mangling.GenericWitnessTest.closureInGenericContext<A where A: interface_type_mangling.GenericWitnessTest>(A1) -> () in conformance <A> interface_type_mangling.GenericTypeContext<A> : interface_type_mangling.GenericWitnessTest in interface_type_mangling"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_g31closureInGenericPropertyContextwx3Tee() {
		let input = "_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_g31closureInGenericPropertyContextwx3Tee"
		let output = "protocol witness for interface_type_mangling.GenericWitnessTest.closureInGenericPropertyContext.getter : A.Tee in conformance <A> interface_type_mangling.GenericTypeContext<A> : interface_type_mangling.GenericWitnessTest in interface_type_mangling"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_16twoParamsAtDepthu0_RxS1_rfTqd__1yqd_0__T_() {
		let input = "_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_16twoParamsAtDepthu0_RxS1_rfTqd__1yqd_0__T_"
		let output = "protocol witness for interface_type_mangling.GenericWitnessTest.twoParamsAtDepth<A, B where A: interface_type_mangling.GenericWitnessTest>(A1, y: B1) -> () in conformance <A> interface_type_mangling.GenericTypeContext<A> : interface_type_mangling.GenericWitnessTest in interface_type_mangling"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC3red11BaseClassEHcfzT1aSi_S0_() {
		let input = "_TFC3red11BaseClassEHcfzT1aSi_S0_"
		let output = "red.BaseClassEH.init(a: Swift.Int) throws -> red.BaseClassEH"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1aSi() {
		let input = "_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1aSi"
		let output = "(extension in mangling_generic_extensions):mangling_generic_extensions.Foo<A where A: mangling_generic_extensions.Runcible>.a.getter : Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1bx() {
		let input = "_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1bx"
		let output = "(extension in mangling_generic_extensions):mangling_generic_extensions.Foo<A where A: mangling_generic_extensions.Runcible>.b.getter : A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRXFo_iT__iT_zoPs5Error__XFo__dT_zoPS___() {
		let input = "_TTRXFo_iT__iT_zoPs5Error__XFo__dT_zoPS___"
		let output = "reabstraction thunk helper from @callee_owned () -> (@unowned (), @error @owned Swift.Error) to @callee_owned (@in ()) -> (@out (), @error @owned Swift.Error)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFE1a() {
		let input = "_TFE1a"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TF21$__lldb_module_for_E0au3$E0Ps5Error_() {
		let input = "_TF21$__lldb_module_for_E0au3$E0Ps5Error_"
		let output = "$__lldb_module_for_E0.$E0.unsafeMutableAddressor : Swift.Error"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TMps10Comparable() {
		let input = "_TMps10Comparable"
		let output = "protocol descriptor for Swift.Comparable"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFC4testP33_83378C430F65473055F1BD53F3ADCDB71C5doFoofT_T_() {
		let input = "_TFC4testP33_83378C430F65473055F1BD53F3ADCDB71C5doFoofT_T_"
		let output = "test.(C in _83378C430F65473055F1BD53F3ADCDB7).doFoo() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFVV15nested_generics5Lunch6DinnerCfT11firstCoursex12secondCourseGSqqd___9leftoversx14transformationFxqd___GS1_x_qd___() {
		let input = "_TFVV15nested_generics5Lunch6DinnerCfT11firstCoursex12secondCourseGSqqd___9leftoversx14transformationFxqd___GS1_x_qd___"
		let output = "nested_generics.Lunch.Dinner.init(firstCourse: A, secondCourse: A1?, leftovers: A, transformation: (A) -> A1) -> nested_generics.Lunch<A>.Dinner<A1>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFVFC15nested_generics7HotDogs11applyRelishFT_T_L_6RelishCfT8materialx_GS1_x_() {
		let input = "_TFVFC15nested_generics7HotDogs11applyRelishFT_T_L_6RelishCfT8materialx_GS1_x_"
		let output = "init(material: A) -> Relish #1 in nested_generics.HotDogs.applyRelish() -> ()<A> in Relish #1 in nested_generics.HotDogs.applyRelish() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFVFE15nested_genericsSS3fooFT_T_L_6CheeseCfT8materialx_GS0_x_() {
		let input = "_TFVFE15nested_genericsSS3fooFT_T_L_6CheeseCfT8materialx_GS0_x_"
		let output = "init(material: A) -> Cheese #1 in (extension in nested_generics):Swift.String.foo() -> ()<A> in Cheese #1 in (extension in nested_generics):Swift.String.foo() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTWOE5imojiCSo5Imoji14ImojiMatchRankS_9RankValueS_FS2_g9rankValueqq_Ss16RawRepresentable8RawValue() {
		let input = "_TTWOE5imojiCSo5Imoji14ImojiMatchRankS_9RankValueS_FS2_g9rankValueqq_Ss16RawRepresentable8RawValue"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0s17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD05Indexs01_A9IndexablePQzAM15shiftingToStart_tFAJs01_J4BasePQzAQcfU_() {
		let input = "_T0s17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD05Indexs01_A9IndexablePQzAM15shiftingToStart_tFAJs01_J4BasePQzAQcfU_"
		let output = "closure #1 (A.Swift._IndexableBase.Index) -> A.Swift._IndexableBase.Index in (extension in a):Swift.MutableCollection<A where A: Swift.MutableCollection, A: Swift.RandomAccessCollection, A.Swift.BidirectionalCollection.SubSequence: Swift.MutableCollection, A.Swift.BidirectionalCollection.SubSequence: Swift.RandomAccessCollection>.rotateRandomAccess(shiftingToStart: A.Swift._MutableIndexable.Index) -> A.Swift._MutableIndexable.Index"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$Ss17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD015shiftingToStart5Indexs01_A9IndexablePQzAN_tFAKs01_M4BasePQzAQcfU_() {
		let input = "_$Ss17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD015shiftingToStart5Indexs01_A9IndexablePQzAN_tFAKs01_M4BasePQzAQcfU_"
		let output = "closure #1 (A.Swift._IndexableBase.Index) -> A.Swift._IndexableBase.Index in (extension in a):Swift.MutableCollection<A where A: Swift.MutableCollection, A: Swift.RandomAccessCollection, A.Swift.BidirectionalCollection.SubSequence: Swift.MutableCollection, A.Swift.BidirectionalCollection.SubSequence: Swift.RandomAccessCollection>.rotateRandomAccess(shiftingToStart: A.Swift._MutableIndexable.Index) -> A.Swift._MutableIndexable.Index"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T03foo4_123ABTf3psbpsb_n() {
		let input = "_T03foo4_123ABTf3psbpsb_n"
		let output = "function signature specialization <Arg[0] = [Constant Propagated String : u8'123'], Arg[1] = [Constant Propagated String : u8'123']> of foo"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T04main5innerys5Int32Vz_yADctF25closure_with_box_argumentxz_Bi32__lXXTf1nc_n() {
		let input = "_T04main5innerys5Int32Vz_yADctF25closure_with_box_argumentxz_Bi32__lXXTf1nc_n"
		let output = "function signature specialization <Arg[1] = [Closure Propagated : closure_with_box_argument, Argument Types : [<A> { var A } <Builtin.Int32>]> of main.inner(inout Swift.Int32, (Swift.Int32) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S4main5inneryys5Int32Vz_yADctF25closure_with_box_argumentxz_Bi32__lXXTf1nc_n() {
		let input = "_$S4main5inneryys5Int32Vz_yADctF25closure_with_box_argumentxz_Bi32__lXXTf1nc_n"
		let output = "function signature specialization <Arg[1] = [Closure Propagated : closure_with_box_argument, Argument Types : [<A> { var A } <Builtin.Int32>]> of main.inner(inout Swift.Int32, (Swift.Int32) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T03foo6testityyyc_yyctF1a1bTf3pfpf_n() {
		let input = "_T03foo6testityyyc_yyctF1a1bTf3pfpf_n"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : a], Arg[1] = [Constant Propagated Function : b]> of foo.testit(() -> (), () -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S3foo6testityyyyc_yyctF1a1bTf3pfpf_n() {
		let input = "_$S3foo6testityyyyc_yyctF1a1bTf3pfpf_n"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : a], Arg[1] = [Constant Propagated Function : b]> of foo.testit(() -> (), () -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_SocketJoinOrLeaveMulticast() {
		let input = "_SocketJoinOrLeaveMulticast"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0s10DictionaryV3t17E6Index2V1loiSbAEyxq__G_AGtFZ() {
		let input = "_T0s10DictionaryV3t17E6Index2V1loiSbAEyxq__G_AGtFZ"
		let output = "static (extension in t17):Swift.Dictionary.Index2.< infix((extension in t17):[A : B].Index2, (extension in t17):[A : B].Index2) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T08mangling14varargsVsArrayySi3arrd_SS1ntF() {
		let input = "_T08mangling14varargsVsArrayySi3arrd_SS1ntF"
		let output = "mangling.varargsVsArray(arr: Swift.Int..., n: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T08mangling14varargsVsArrayySaySiG3arr_SS1ntF() {
		let input = "_T08mangling14varargsVsArrayySaySiG3arr_SS1ntF"
		let output = "mangling.varargsVsArray(arr: [Swift.Int], n: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T08mangling14varargsVsArrayySaySiG3arrd_SS1ntF() {
		let input = "_T08mangling14varargsVsArrayySaySiG3arrd_SS1ntF"
		let output = "mangling.varargsVsArray(arr: [Swift.Int]..., n: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T08mangling14varargsVsArrayySi3arrd_tF() {
		let input = "_T08mangling14varargsVsArrayySi3arrd_tF"
		let output = "mangling.varargsVsArray(arr: Swift.Int...) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T08mangling14varargsVsArrayySaySiG3arrd_tF() {
		let input = "_T08mangling14varargsVsArrayySaySiG3arrd_tF"
		let output = "mangling.varargsVsArray(arr: [Swift.Int]...) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$Ss10DictionaryV3t17E6Index2V1loiySbAEyxq__G_AGtFZ() {
		let input = "_$Ss10DictionaryV3t17E6Index2V1loiySbAEyxq__G_AGtFZ"
		let output = "static (extension in t17):Swift.Dictionary.Index2.< infix((extension in t17):[A : B].Index2, (extension in t17):[A : B].Index2) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S8mangling14varargsVsArray3arr1nySid_SStF() {
		let input = "_$S8mangling14varargsVsArray3arr1nySid_SStF"
		let output = "mangling.varargsVsArray(arr: Swift.Int..., n: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S8mangling14varargsVsArray3arr1nySaySiG_SStF() {
		let input = "_$S8mangling14varargsVsArray3arr1nySaySiG_SStF"
		let output = "mangling.varargsVsArray(arr: [Swift.Int], n: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S8mangling14varargsVsArray3arr1nySaySiGd_SStF() {
		let input = "_$S8mangling14varargsVsArray3arr1nySaySiGd_SStF"
		let output = "mangling.varargsVsArray(arr: [Swift.Int]..., n: Swift.String) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S8mangling14varargsVsArray3arrySid_tF() {
		let input = "_$S8mangling14varargsVsArray3arrySid_tF"
		let output = "mangling.varargsVsArray(arr: Swift.Int...) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S8mangling14varargsVsArray3arrySaySiGd_tF() {
		let input = "_$S8mangling14varargsVsArray3arrySaySiGd_tF"
		let output = "mangling.varargsVsArray(arr: [Swift.Int]...) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0s13_UnicodeViewsVss22RandomAccessCollectionRzs0A8EncodingR_11SubSequence_5IndexQZAFRtzsAcERpzAE_AEQZAIRSs15UnsignedInteger8Iterator_7ElementRPzAE_AlMQZANRS13EncodedScalar_AlMQY_AORSr0_lE13CharacterViewVyxq__G() {
		let input = "_T0s13_UnicodeViewsVss22RandomAccessCollectionRzs0A8EncodingR_11SubSequence_5IndexQZAFRtzsAcERpzAE_AEQZAIRSs15UnsignedInteger8Iterator_7ElementRPzAE_AlMQZANRS13EncodedScalar_AlMQY_AORSr0_lE13CharacterViewVyxq__G"
		let output = "(extension in Swift):Swift._UnicodeViews<A, B><A, B where A: Swift.RandomAccessCollection, B: Swift.UnicodeEncoding, A.Index == A.SubSequence.Index, A.SubSequence: Swift.RandomAccessCollection, A.SubSequence == A.SubSequence.SubSequence, A.Iterator.Element: Swift.UnsignedInteger, A.Iterator.Element == A.SubSequence.Iterator.Element, A.SubSequence.Iterator.Element == B.EncodedScalar.Iterator.Element>.CharacterView"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T010Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiSbAcDEAGOyAF_G_AKtFZ() {
		let input = "_T010Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiSbAcDEAGOyAF_G_AKtFZ"
		let output = "static (extension in SimulatorKit):Foundation.Measurement<A where A == __C.UnitAngle>.Orientation.== infix((extension in SimulatorKit):Foundation.Measurement<__C.UnitAngle>.Orientation, (extension in SimulatorKit):Foundation.Measurement<__C.UnitAngle>.Orientation) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S10Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiySbAcDEAGOyAF_G_AKtFZ() {
		let input = "_$S10Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiySbAcDEAGOyAF_G_AKtFZ"
		let output = "static (extension in SimulatorKit):Foundation.Measurement<A where A == __C.UnitAngle>.Orientation.== infix((extension in SimulatorKit):Foundation.Measurement<__C.UnitAngle>.Orientation, (extension in SimulatorKit):Foundation.Measurement<__C.UnitAngle>.Orientation) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T04main1_yyF() {
		let input = "_T04main1_yyF"
		let output = "main._() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T04test6testitSiyt_tF() {
		let input = "_T04test6testitSiyt_tF"
		let output = "test.testit(()) -> Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S4test6testitySiyt_tF() {
		let input = "_$S4test6testitySiyt_tF"
		let output = "test.testit(()) -> Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T08_ElementQzSbs5Error_pIxxdzo_ABSbsAC_pIxidzo_s26RangeReplaceableCollectionRzABRLClTR() {
		let input = "_T08_ElementQzSbs5Error_pIxxdzo_ABSbsAC_pIxidzo_s26RangeReplaceableCollectionRzABRLClTR"
		let output = "reabstraction thunk helper <A where A: Swift.RangeReplaceableCollection, A._Element: AnyObject> from @callee_owned (@owned A._Element) -> (@unowned Swift.Bool, @error @owned Swift.Error) to @callee_owned (@in A._Element) -> (@unowned Swift.Bool, @error @owned Swift.Error)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0Ix_IyB_Tr() {
		let input = "_T0Ix_IyB_Tr"
		let output = "reabstraction thunk from @callee_owned () -> () to @callee_unowned @convention(block) () -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0Rml() {
		let input = "_T0Rml"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0Tk() {
		let input = "_T0Tk"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0A8() {
		let input = "_T0A8"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0s30ReversedRandomAccessCollectionVyxGTfq3nnpf_nTfq1cn_nTfq4x_n() {
		let input = "_T0s30ReversedRandomAccessCollectionVyxGTfq3nnpf_nTfq1cn_nTfq4x_n"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T03abc6testitySiFTm() {
		let input = "_T03abc6testitySiFTm"
		let output = "merged abc.testit(Swift.Int) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T04main4TestCACSi1x_tc6_PRIV_Llfc() {
		let input = "_T04main4TestCACSi1x_tc6_PRIV_Llfc"
		let output = "main.Test.(in _PRIV_).init(x: Swift.Int) -> main.Test"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S3abc6testityySiFTm() {
		let input = "_$S3abc6testityySiFTm"
		let output = "merged abc.testit(Swift.Int) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S4main4TestC1xACSi_tc6_PRIV_Llfc() {
		let input = "_$S4main4TestC1xACSi_tc6_PRIV_Llfc"
		let output = "main.Test.(in _PRIV_).init(x: Swift.Int) -> main.Test"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0SqWOydot17() {
		let input = "_T0SqWOy.17"
		let output = "outlined copy of Swift.Optional with unmangled suffix \".17\""
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T03nix6testitSaySiGyFTv_() {
		let input = "_T03nix6testitSaySiGyFTv_"
		let output = "outlined variable #0 of nix.testit() -> [Swift.Int]"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T03nix6testitSaySiGyFTv0_() {
		let input = "_T03nix6testitSaySiGyFTv0_"
		let output = "outlined variable #1 of nix.testit() -> [Swift.Int]"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So11UITextFieldC4textSSSgvgToTepb_() {
		let input = "_T0So11UITextFieldC4textSSSgvgToTepb_"
		let output = "outlined bridged method (pb) of @objc __C.UITextField.text.getter : Swift.String?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So11UITextFieldC4textSSSgvgToTeab_() {
		let input = "_T0So11UITextFieldC4textSSSgvgToTeab_"
		let output = "outlined bridged method (ab) of @objc __C.UITextField.text.getter : Swift.String?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sSo5GizmoC11doSomethingyypSgSaySSGSgFToTembgnn_() {
		let input = "$sSo5GizmoC11doSomethingyypSgSaySSGSgFToTembgnn_"
		let output = "outlined bridged method (mbgnn) of @objc __C.Gizmo.doSomething([Swift.String]?) -> Any?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T04test1SVyxGAA1RA2A1ZRzAA1Y2ZZRpzl1A_AhaGPWT() {
		let input = "_T04test1SVyxGAA1RA2A1ZRzAA1Y2ZZRpzl1A_AhaGPWT"
		let output = "associated type witness table accessor for A.ZZ : test.Y in <A where A: test.Z, A.ZZ: test.Y> test.S<A> : test.R in test"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0s24_UnicodeScalarExceptions33_0E4228093681F6920F0AB2E48B4F1C69LLVACycfC() {
		let input = "_T0s24_UnicodeScalarExceptions33_0E4228093681F6920F0AB2E48B4F1C69LLVACycfC"
		let output = "Swift.(_UnicodeScalarExceptions in _0E4228093681F6920F0AB2E48B4F1C69).init() -> Swift.(_UnicodeScalarExceptions in _0E4228093681F6920F0AB2E48B4F1C69)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0D() {
		let input = "_T0D"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0s18EnumeratedIteratorVyxGs8Sequencess0B8ProtocolRzlsADP5splitSay03SubC0QzGSi9maxSplits_Sb25omittingEmptySubsequencesSb7ElementQzKc14whereSeparatortKFTW() {
		let input = "_T0s18EnumeratedIteratorVyxGs8Sequencess0B8ProtocolRzlsADP5splitSay03SubC0QzGSi9maxSplits_Sb25omittingEmptySubsequencesSb7ElementQzKc14whereSeparatortKFTW"
		let output = "protocol witness for Swift.Sequence.split(maxSplits: Swift.Int, omittingEmptySubsequences: Swift.Bool, whereSeparator: (A.Element) throws -> Swift.Bool) throws -> [A.SubSequence] in conformance <A where A: Swift.IteratorProtocol> Swift.EnumeratedIterator<A> : Swift.Sequence in Swift"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0s3SetVyxGs10CollectiotySivm() {
		let input = "_T0s3SetVyxGs10CollectiotySivm"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_S$s3SetVyxGs10CollectiotySivm() {
		let input = "_S$s3SetVyxGs10CollectiotySivm"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0s18ReversedCollectionVyxGs04LazyB8ProtocolfC() {
		let input = "_T0s18ReversedCollectionVyxGs04LazyB8ProtocolfC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_S$s18ReversedCollectionVyxGs04LazyB8ProtocolfC() {
		let input = "_S$s18ReversedCollectionVyxGs04LazyB8ProtocolfC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0iW() {
		let input = "_T0iW"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_S$iW() {
		let input = "_S$iW"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0s5print_9separator10terminatoryypfC() {
		let input = "_T0s5print_9separator10terminatoryypfC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_S$s5print_9separator10terminatoryypfC() {
		let input = "_S$s5print_9separator10terminatoryypfC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0So13GenericOptionas8HashableSCsACP9hashValueSivgTW() {
		let input = "_T0So13GenericOptionas8HashableSCsACP9hashValueSivgTW"
		let output = "protocol witness for Swift.Hashable.hashValue.getter : Swift.Int in conformance __C.GenericOption : Swift.Hashable in __C_Synthesized"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So11CrappyColorVs16RawRepresentableSCMA() {
		let input = "_T0So11CrappyColorVs16RawRepresentableSCMA"
		let output = "reflection metadata associated type descriptor __C.CrappyColor : Swift.RawRepresentable in __C_Synthesized"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S28protocol_conformance_records15NativeValueTypeVAA8RuncibleAAMc() {
		let input = "$S28protocol_conformance_records15NativeValueTypeVAA8RuncibleAAMc"
		let output = "protocol conformance descriptor for protocol_conformance_records.NativeValueType : protocol_conformance_records.Runcible in protocol_conformance_records"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$SSC9SomeErrorLeVD() {
		let input = "$SSC9SomeErrorLeVD"
		let output = "__C_Synthesized.related decl 'e' for SomeError"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PAAyHCg_AiJ1QAAyHCg1_GF() {
		let input = "$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PAAyHCg_AiJ1QAAyHCg1_GF"
		let output = "mangling_retroactive.test0(mangling_retroactive.Z<RetroactiveB.X, Swift.Int, RetroactiveB.Y>) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PHPyHCg_AiJ1QHPyHCg1_GF() {
		let input = "$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PHPyHCg_AiJ1QHPyHCg1_GF"
		let output = "mangling_retroactive.test0(mangling_retroactive.Z<RetroactiveB.X, Swift.Int, RetroactiveB.Y>) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PHpyHCg_AiJ1QHpyHCg1_GF() {
		let input = "$s20mangling_retroactive5test0yyAA1ZVy12RetroactiveB1XVSiAE1YVAG0D1A1PHpyHCg_AiJ1QHpyHCg1_GF"
		let output = "mangling_retroactive.test0(mangling_retroactive.Z<RetroactiveB.X, Swift.Int, RetroactiveB.Y>) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0LiteralAByxGxd_tcfC() {
		let input = "_T0LiteralAByxGxd_tcfC"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0XZ() {
		let input = "_T0XZ"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TTSf0os___TFVs17_LegacyStringCore15_invariantCheckfT_T_() {
		let input = "_TTSf0os___TFVs17_LegacyStringCore15_invariantCheckfT_T_"
		let output = "function signature specialization <Arg[0] = Guaranteed To Owned and Exploded> of Swift._LegacyStringCore._invariantCheck() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2o___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2o___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Guaranteed To Owned> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2do___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2do___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Guaranteed To Owned> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2dos___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dos___TTSf2s_d___TFVs17_LegacyStringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Guaranteed To Owned and Exploded> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._LegacyStringCore.init(Swift._StringBuffer) -> Swift._LegacyStringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf() {
		let input = "_TTSf"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtW0_j() {
		let input = "_TtW0_j"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TtW_4m3a3v() {
		let input = "_TtW_4m3a3v"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_TVGVGSS_2v0() {
		let input = "_TVGVGSS_2v0"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test$SSD1BySSSBsg_G() {
		let input = "$SSD1BySSSBsg_G"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_Ttu4222222222222222222222222_rW_2T_2TJ_() {
		let input = "_Ttu4222222222222222222222222_rW_2T_2TJ_"
		let output = "<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, AB, BB, CB, DB, EB, FB, GB, HB, IB, JB, KB, LB, MB, NB, OB, PB, QB, RB, SB, TB, UB, VB, WB, XB, YB, ZB, AC, BC, CC, DC, EC, FC, GC, HC, IC, JC, KC, LC, MC, NC, OC, PC, QC, RC, SC, TC, UC, VC, WC, XC, YC, ZC, AD, BD, CD, DD, ED, FD, GD, HD, ID, JD, KD, LD, MD, ND, OD, PD, QD, RD, SD, TD, UD, VD, WD, XD, YD, ZD, AE, BE, CE, DE, EE, FE, GE, HE, IE, JE, KE, LE, ME, NE, OE, PE, QE, RE, SE, TE, UE, VE, WE, XE, ...> B.T_.TJ"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S3BBBBf0602365061_() {
		let input = "_$S3BBBBf0602365061_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_$S3BBBBi0602365061_() {
		let input = "_$S3BBBBi0602365061_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_$S3BBBBv0602365061_() {
		let input = "_$S3BBBBv0602365061_"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test_T0lxxxmmmTk() {
		let input = "_T0lxxxmmmTk"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test$s4Test5ProtoP8IteratorV10collectionAEy_qd__Gqd___tcfc() {
		let input = "$s4Test5ProtoP8IteratorV10collectionAEy_qd__Gqd___tcfc"
		let output = "Test.Proto.Iterator.init(collection: A1) -> Test.Proto.Iterator<A1>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s4test3fooV4blahyAA1SV1fQryFQOy_Qo_AHF() {
		let input = "$s4test3fooV4blahyAA1SV1fQryFQOy_Qo_AHF"
		let output = "test.foo.blah(<<opaque return type of test.S.f() -> some>>.0) -> <<opaque return type of test.S.f() -> some>>.0"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3nix8MystructV1xACyxGx_tcfc7MyaliasL_ayx__GD() {
		let input = "$S3nix8MystructV1xACyxGx_tcfc7MyaliasL_ayx__GD"
		let output = "Myalias #1 in nix.Mystruct<A>.init(x: A) -> nix.Mystruct<A>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3nix7MyclassCfd7MyaliasL_ayx__GD() {
		let input = "$S3nix7MyclassCfd7MyaliasL_ayx__GD"
		let output = "Myalias #1 in nix.Myclass<A>.deinit"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3nix8MystructVyS2icig7MyaliasL_ayx__GD() {
		let input = "$S3nix8MystructVyS2icig7MyaliasL_ayx__GD"
		let output = "Myalias #1 in nix.Mystruct<A>.subscript.getter : (Swift.Int) -> Swift.Int"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3nix8MystructV1x1uACyxGx_qd__tclufc7MyaliasL_ayx_qd___GD() {
		let input = "$S3nix8MystructV1x1uACyxGx_qd__tclufc7MyaliasL_ayx_qd___GD"
		let output = "Myalias #1 in nix.Mystruct<A>.<A1>(x: A, u: A1) -> nix.Mystruct<A>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3nix8MystructV6testit1xyx_tF7MyaliasL_ayx__GD() {
		let input = "$S3nix8MystructV6testit1xyx_tF7MyaliasL_ayx__GD"
		let output = "Myalias #1 in nix.Mystruct<A>.testit(x: A) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3nix8MystructV6testit1x1u1vyx_qd__qd_0_tr0_lF7MyaliasL_ayx_qd__qd_0__GD() {
		let input = "$S3nix8MystructV6testit1x1u1vyx_qd__qd_0_tr0_lF7MyaliasL_ayx_qd__qd_0__GD"
		let output = "Myalias #1 in nix.Mystruct<A>.testit<A1, B1>(x: A, u: A1, v: B1) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S4blah8PatatinoaySiGD() {
		let input = "$S4blah8PatatinoaySiGD"
		let output = "blah.Patatino<Swift.Int>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$SSiSHsWP() {
		let input = "$SSiSHsWP"
		let output = "protocol witness table for Swift.Int : Swift.Hashable in Swift"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S7TestMod5OuterV3Fooayx_SiGD() {
		let input = "$S7TestMod5OuterV3Fooayx_SiGD"
		let output = "TestMod.Outer<A>.Foo<Swift.Int>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$Ss17_VariantSetBufferO05CocoaC0ayx_GD() {
		let input = "$Ss17_VariantSetBufferO05CocoaC0ayx_GD"
		let output = "Swift._VariantSetBuffer<A>.CocoaBuffer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S2t21QP22ProtocolTypeAliasThingayAA4BlahV5SomeQa_GSgD() {
		let input = "$S2t21QP22ProtocolTypeAliasThingayAA4BlahV5SomeQa_GSgD"
		let output = "t2.Blah.SomeQ as t2.Q.ProtocolTypeAliasThing?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s1A1gyyxlFx_qd__t_Ti5() {
		let input = "$s1A1gyyxlFx_qd__t_Ti5"
		let output = "inlined generic function <(A, A1)> of A.g<A>(A) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S1T19protocol_resilience17ResilientProtocolPTl() {
		let input = "$S1T19protocol_resilience17ResilientProtocolPTl"
		let output = "associated type descriptor for protocol_resilience.ResilientProtocol.T"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S18resilient_protocol21ResilientBaseProtocolTL() {
		let input = "$S18resilient_protocol21ResilientBaseProtocolTL"
		let output = "protocol requirements base descriptor for resilient_protocol.ResilientBaseProtocol"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S1t1PP10AssocType2_AA1QTn() {
		let input = "$S1t1PP10AssocType2_AA1QTn"
		let output = "associated conformance descriptor for t.P.AssocType2: t.Q"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S1t1PP10AssocType2_AA1QTN() {
		let input = "$S1t1PP10AssocType2_AA1QTN"
		let output = "default associated conformance accessor for t.P.AssocType2: t.Q"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sSD5IndexVy__GD() {
		let input = "$sSD5IndexVy__GD"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
	func test$s4test3StrCACycfC() {
		let input = "$s4test3StrCACycfC"
		let output = "test.Str.__allocating_init() -> test.Str"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s18keypaths_inlinable13KeypathStructV8computedSSvpACTKq() {
		let input = "$s18keypaths_inlinable13KeypathStructV8computedSSvpACTKq"
		let output = "key path getter for keypaths_inlinable.KeypathStruct.computed : Swift.String : keypaths_inlinable.KeypathStruct, serialized"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$s3red4testyAA7OurTypeOy4them05TheirD0Vy5AssocQzGAjE0F8ProtocolAAxAA0c7DerivedH0HD1_AA0c4BaseH0HI1_AieKHA2__HCg_GxmAaLRzlF() {
		let input = "$s3red4testyAA7OurTypeOy4them05TheirD0Vy5AssocQzGAjE0F8ProtocolAAxAA0c7DerivedH0HD1_AA0c4BaseH0HI1_AieKHA2__HCg_GxmAaLRzlF"
		let output = "red.test<A where A: red.OurDerivedProtocol>(A.Type) -> red.OurType<them.TheirType<A.Assoc>>"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sSo17OS_dispatch_queueC4sync7executeyyyXE_tFTOTA() {
		let input = "$sSo17OS_dispatch_queueC4sync7executeyyyXE_tFTOTA"
		let output = "partial apply forwarder for @nonobjc __C.OS_dispatch_queue.sync(execute: () -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sxq_Idgnr_D() {
		let input = "$sxq_Idgnr_D"
		let output = "@differentiable @callee_guaranteed (@in_guaranteed A) -> (@out B)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sxq_Ilgnr_D() {
		let input = "$sxq_Ilgnr_D"
		let output = "@differentiable(linear) @callee_guaranteed (@in_guaranteed A) -> (@out B)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sS3fIedgyywd_D() {
		let input = "$sS3fIedgyywd_D"
		let output = "@escaping @differentiable @callee_guaranteed (@unowned Swift.Float, @unowned @noDerivative Swift.Float) -> (@unowned Swift.Float)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$sS5fIedtyyywddw_D() {
		let input = "$sS5fIedtyyywddw_D"
		let output = "@escaping @differentiable @convention(thin) (@unowned Swift.Float, @unowned Swift.Float, @unowned @noDerivative Swift.Float) -> (@unowned Swift.Float, @unowned @noDerivative Swift.Float)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input).\nGot\n    \(result)\nexpected\n    \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$syQo() {
		let input = "$syQo"
		do {
			let demangled = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error, instead returned \(demangled)")
		} catch {
		}
	}
}
