//
//  CwlDemangleTests.swift
//  CwlDemangleTests
//
//  Created by Matt Gallagher on 2016/04/30.
//  Copyright © 2016 Matt Gallagher. All rights reserved.
//
//  Licensed under Apache License v2.0 with Runtime Library Exception
//
//  See http://swift.org/LICENSE.txt for license information
//  See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

import XCTest

class CwlDemangleTests: XCTestCase {
	func test_TtBf80_() {
		let input = "_TtBf80_"
		let output = "Builtin.Float80"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtGSQSS_() {
		let input = "_TtGSQSS_"
		let output = "Swift.String!"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtCSo8NSObject() {
		let input = "_TtCSo8NSObject"
		let output = "__ObjC.NSObject"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince() {
		let input = "_TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince"
		let output = "<A where A: Swift.Runcible, A: Swift.Fungible>(A) -> A.Mince"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTOFSC3fooFTSdSd_Sd() {
		let input = "_TTOFSC3fooFTSdSd_Sd"
		let output = "@nonobjc __C.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0SC3fooS2d_SdtFTO() {
		let input = "_T0SC3fooS2d_SdtFTO"
		let output = "@nonobjc __C.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$S3foo3barC3basyAA3zimCAE_tFTo() {
		let input = "_$S3foo3barC3basyAA3zimCAE_tFTo"
		let output = "@objc foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_$SSC3fooS2d_SdtFTO() {
		let input = "_$SSC3fooS2d_SdtFTO"
		let output = "@nonobjc __C.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$S3foo3barC3basyAA3zimCAE_tFTo() {
		let input = "$S3foo3barC3basyAA3zimCAE_tFTo"
		let output = "@objc foo.bar.bas(zim: foo.zim) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test$SSC3fooS2d_SdtFTO() {
		let input = "$SSC3fooS2d_SdtFTO"
		let output = "@nonobjc __C.foo(Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFSCg5greenVSC5Color() {
		let input = "_TFSCg5greenVSC5Color"
		let output = "__C.green.getter : __C.Color"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TtZZ() {
		let input = "_TtZZ"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtB() {
		let input = "_TtB"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtBSi() {
		let input = "_TtBSi"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtBx() {
		let input = "_TtBx"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtC() {
		let input = "_TtC"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtT() {
		let input = "_TtT"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtTSi() {
		let input = "_TtTSi"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtQd_() {
		let input = "_TtQd_"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtU__FQo_Si() {
		let input = "_TtU__FQo_Si"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtU__FQD__Si() {
		let input = "_TtU__FQD__Si"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtU___FQ_U____FQd0__T_() {
		let input = "_TtU___FQ_U____FQd0__T_"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtU___FQ_U____FQd_1_T_() {
		let input = "_TtU___FQ_U____FQd_1_T_"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtU___FQ_U____FQ2_T_() {
		let input = "_TtU___FQ_U____FQ2_T_"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_Tw() {
		let input = "_Tw"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWa() {
		let input = "_TWa"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_Twal() {
		let input = "_Twal"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T() {
		let input = "_T"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTo() {
		let input = "_TTo"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TC() {
		let input = "_TC"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TM() {
		let input = "_TM"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TW() {
		let input = "_TW"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWV() {
		let input = "_TWV"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWo() {
		let input = "_TWo"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWv() {
		let input = "_TWv"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWvd() {
		let input = "_TWvd"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWvi() {
		let input = "_TWvi"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TWvx() {
		let input = "_TWvx"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtVCC4main3Foo4Ding3Str() {
		let input = "_TtVCC4main3Foo4Ding3Str"
		let output = "main.Foo.Ding.Str"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRXFo_dSc_dSb_XFo_iSc_iSb_() {
		let input = "_TTRXFo_dSc_dSb_XFo_iSc_iSb_"
		let output = "reabstraction thunk helper from @callee_owned (@unowned Swift.UnicodeScalar) -> (@unowned Swift.Bool) to @callee_owned (@in Swift.UnicodeScalar) -> (@out Swift.Bool)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__() {
		let input = "_TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__"
		let output = "reabstraction thunk helper from @callee_owned (@unowned Swift.Int) -> (@unowned Swift.Int?) to @callee_owned (@in Swift.Int) -> (@out Swift.Int?)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_() {
		let input = "_TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_"
		let output = "reabstraction thunk helper <A> from @callee_owned (@in switch_abstraction.A) -> (@out A) to @callee_owned (@unowned switch_abstraction.A) -> (@out A)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCSo1AE() {
		let input = "_TFCSo1AE"
		let output = "__ObjC.A.__ivar_destroyer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFCSo1Ae() {
		let input = "_TFCSo1Ae"
		let output = "__ObjC.A.__ivar_initializer"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSgq5Si___TFSqcfT_GSqx_() {
		let input = "_TTSgq5Si___TFSqcfT_GSqx_"
		let output = "generic specialization <preserving fragile attribute, Swift.Int> of Swift.Optional.init() -> A?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSgS() {
		let input = "_TTSgS"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSg5S() {
		let input = "_TTSg5S"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSgSi() {
		let input = "_TTSgSi"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSg5Si() {
		let input = "_TTSg5Si"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSgSi_() {
		let input = "_TTSgSi_"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSgSi__() {
		let input = "_TTSgSi__"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSgSiS_() {
		let input = "_TTSgSiS_"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSgSi__xyz() {
		let input = "_TTSgSi__xyz"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TTSr5Si___TF4test7genericurFxx() {
		let input = "_TTSr5Si___TF4test7genericurFxx"
		let output = "generic not re-abstracted specialization <Swift.Int> of test.generic<A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSrq5Si___TF4test7genericurFxx() {
		let input = "_TTSrq5Si___TF4test7genericurFxx"
		let output = "generic not re-abstracted specialization <preserving fragile attribute, Swift.Int> of test.generic<A>(A) -> A"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_() {
		let input = "_TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_"
		let output = "partial apply forwarder for reabstraction thunk helper from @callee_owned (@owned Swift.String, @owned Swift.String) -> (@unowned Swift.Bool) to @callee_owned (@in Swift.String, @in Swift.String) -> (@unowned Swift.Bool)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TPAo__TTRGrXFo_dGSPx__dGSPx_zoPs5Error__XFo_iGSPx__iGSPx_zoPS___() {
		let input = "_TPAo__TTRGrXFo_dGSPx__dGSPx_zoPs5Error__XFo_iGSPx__iGSPx_zoPS___"
		let output = "partial apply ObjC forwarder for reabstraction thunk helper <A> from @callee_owned (@unowned Swift.UnsafePointer<A>) -> (@unowned Swift.UnsafePointer<A>, @error @owned Swift.Error) to @callee_owned (@in Swift.UnsafePointer<A>) -> (@out Swift.UnsafePointer<A>, @error @owned Swift.Error)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <preserving fragile attribute, Arg[0] = [Closure Propagated : closure #1 (Swift.Int, Swift.Int) -> () in specgen.caller(Swift.Int) -> (), Argument Types : [Swift.Int]> of specgen.take_closure((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__() {
		let input = "_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : capturep.helper(Swift.Int) -> ()]> of reabstraction thunk helper from @callee_owned (@unowned Swift.Int) -> (@unowned ()) to @callee_owned (@in Swift.Int) -> (@unowned ())"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__() {
		let input = "_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : capturep.helper(Swift.Int) -> ()]> of reabstraction thunk helper from @callee_owned (@unowned Swift.Int) -> (@unowned_inner_pointer ()) to @callee_owned (@in Swift.Int) -> (@unowned_inner_pointer ())"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf0gs___TFVs11_StringCore15_invariantCheckfT_T_() {
		let input = "_TTSf0gs___TFVs11_StringCore15_invariantCheckfT_T_"
		let output = "function signature specialization <Arg[0] = Owned To Guaranteed and Exploded> of Swift._StringCore._invariantCheck() -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2g___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2g___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Owned To Guaranteed> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._StringCore.init(Swift._StringBuffer) -> Swift._StringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2dg___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dg___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Owned To Guaranteed> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._StringCore.init(Swift._StringBuffer) -> Swift._StringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf2dgs___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dgs___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Owned To Guaranteed and Exploded> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._StringCore.init(Swift._StringBuffer) -> Swift._StringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf3d_i_d_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf3d_i_d_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead, Arg[1] = Value Promoted from Box, Arg[2] = Dead, Arg[3] = Value Promoted from Box, Arg[4] = Dead, Arg[5] = Value Promoted from Box> of Swift._StringCore.init(Swift._StringBuffer) -> Swift._StringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTSf3d_i_n_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf3d_i_n_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead, Arg[1] = Value Promoted from Box, Arg[3] = Value Promoted from Box, Arg[4] = Dead, Arg[5] = Value Promoted from Box> of Swift._StringCore.init(Swift._StringBuffer) -> Swift._StringCore"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTRXFo_iT__iT_zoPs5Error__XFo__dT_zoPS___() {
		let input = "_TTRXFo_iT__iT_zoPs5Error__XFo__dT_zoPS___"
		let output = "reabstraction thunk helper from @callee_owned (@in ()) -> (@out (), @error @owned Swift.Error) to @callee_owned () -> (@unowned (), @error @owned Swift.Error)"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TFE1a() {
		let input = "_TFE1a"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TF21$__lldb_module_for_E0au3$E0Ps5Error_() {
		let input = "_TF21$__lldb_module_for_E0au3$E0Ps5Error_"
		let output = "$__lldb_module_for_E0.$E0.unsafeMutableAddressor : Swift.Error"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_TTWOE5imojiCSo5Imoji14ImojiMatchRankS_9RankValueS_FS2_g9rankValueqq_Ss16RawRepresentable8RawValue() {
		let input = "_TTWOE5imojiCSo5Imoji14ImojiMatchRankS_9RankValueS_FS2_g9rankValueqq_Ss16RawRepresentable8RawValue"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_TtFzas4VoidGC16FusionXBaseUtils6FutureQq_ZFVS_7Futures6futureurFFzT_GS0_x_GS0_x__() {
		let input = "_TtFzas4VoidGC16FusionXBaseUtils6FutureQq_ZFVS_7Futures6futureurFFzT_GS0_x_GS0_x__"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T0s17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD05Indexs01_A9IndexablePQzAM15shiftingToStart_tFAJs01_J4BasePQzAQcfU_() {
		let input = "_T0s17MutableCollectionP1asAARzs012RandomAccessB0RzsAA11SubSequences013BidirectionalB0PRpzsAdHRQlE06rotatecD05Indexs01_A9IndexablePQzAM15shiftingToStart_tFAJs01_J4BasePQzAQcfU_"
		let output = "closure #1 (A.Index) -> A.Index in (extension in a):Swift.MutableCollection<A where A: Swift.MutableCollection, A: Swift.RandomAccessCollection, A.SubSequence: Swift.MutableCollection, A.SubSequence: Swift.RandomAccessCollection>.rotateRandomAccess(shiftingToStart: A.Index) -> A.Index"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_SocketJoinOrLeaveMulticast() {
		let input = "_SocketJoinOrLeaveMulticast"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T0s10DictionaryV3t17E6Index2V1loiSbAEyxq__G_AGtFZ() {
		let input = "_T0s10DictionaryV3t17E6Index2V1loiSbAEyxq__G_AGtFZ"
		let output = "static (extension in t17):Swift.Dictionary.Index2.< infix((extension in t17):[A : B].Index2, (extension in t17):[A : B].Index2) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T010Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiSbAcDEAGOyAF_G_AKtFZ() {
		let input = "_T010Foundation11MeasurementV12SimulatorKitSo9UnitAngleCRszlE11OrientationO2eeoiSbAcDEAGOyAF_G_AKtFZ"
		let output = "static (extension in SimulatorKit):Foundation.Measurement<A where A == __ObjC.UnitAngle>.Orientation.== infix((extension in SimulatorKit):Foundation.Measurement<__ObjC.UnitAngle>.Orientation, (extension in SimulatorKit):Foundation.Measurement<__ObjC.UnitAngle>.Orientation) -> Swift.Bool"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0Rml() {
		let input = "_T0Rml"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T0Tk() {
		let input = "_T0Tk"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T0A8() {
		let input = "_T0A8"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T0s30ReversedRandomAccessCollectionVyxGTfq3nnpf_nTfq1cn_nTfq4x_n() {
		let input = "_T0s30ReversedRandomAccessCollectionVyxGTfq3nnpf_nTfq1cn_nTfq4x_n"
		do {
			_ = try parseMangledSwiftSymbol(input).description
			XCTFail("Invalid input \(input) should throw an error")
		} catch {
		}
	}
	func test_T03abc6testitySiFTm() {
		let input = "_T03abc6testitySiFTm"
		let output = "merged abc.testit(Swift.Int) -> ()"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0SqWydot17() {
		let input = "_T0SqWy.17"
		let output = "outlined copy of Swift.Optional with unmangled suffix \".17\""
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So11UITextFieldC4textSSSgvgToTepb_() {
		let input = "_T0So11UITextFieldC4textSSSgvgToTepb_"
		let output = "outlined bridged method (pb) of @objc __ObjC.UITextField.text.getter : Swift.String?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So11UITextFieldC4textSSSgvgToTeab_() {
		let input = "_T0So11UITextFieldC4textSSSgvgToTeab_"
		let output = "outlined bridged method (ab) of @objc __ObjC.UITextField.text.getter : Swift.String?"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So5GizmoC11doSomethingSQyypGSQySaySSGGFToTembnn_() {
		let input = "_T0So5GizmoC11doSomethingSQyypGSQySaySSGGFToTembnn_"
		let output = "outlined bridged method (mbnn) of @objc __ObjC.Gizmo.doSomething([Swift.String]!) -> Any!"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	func test_T0So5GizmoC12modifyStringSQySSGAD_Si10withNumberSQyypG0D6FoobartFToTembnnnb_() {
		let input = "_T0So5GizmoC12modifyStringSQySSGAD_Si10withNumberSQyypG0D6FoobartFToTembnnnb_"
		let output = "outlined bridged method (mbnnnb) of @objc __ObjC.Gizmo.modifyString(Swift.String!, withNumber: Swift.Int, withFoobar: Any!) -> Swift.String!"
		do {
			let parsed = try parseMangledSwiftSymbol(input)
			let result = parsed.print(using: SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
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
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTFail("Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
}
