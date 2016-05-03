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
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBi32_() {
		let input = "_TtBi32_"
		let output = "Builtin.Int32"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBw() {
		let input = "_TtBw"
		let output = "Builtin.Word"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBO() {
		let input = "_TtBO"
		let output = "Builtin.UnknownObject"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBo() {
		let input = "_TtBo"
		let output = "Builtin.NativeObject"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBp() {
		let input = "_TtBp"
		let output = "Builtin.RawPointer"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBv4Bi8_() {
		let input = "_TtBv4Bi8_"
		let output = "Builtin.Vec4xInt8"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBv4Bf16_() {
		let input = "_TtBv4Bf16_"
		let output = "Builtin.Vec4xFloat16"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBv4Bp() {
		let input = "_TtBv4Bp"
		let output = "Builtin.Vec4xRawPointer"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSa() {
		let input = "_TtSa"
		let output = "Swift.Array"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSb() {
		let input = "_TtSb"
		let output = "Swift.Bool"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSc() {
		let input = "_TtSc"
		let output = "Swift.UnicodeScalar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSd() {
		let input = "_TtSd"
		let output = "Swift.Double"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSf() {
		let input = "_TtSf"
		let output = "Swift.Float"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSi() {
		let input = "_TtSi"
		let output = "Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSq() {
		let input = "_TtSq"
		let output = "Swift.Optional"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSS() {
		let input = "_TtSS"
		let output = "Swift.String"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtSu() {
		let input = "_TtSu"
		let output = "Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtGSaSS_() {
		let input = "_TtGSaSS_"
		let output = "[Swift.String]"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtGSqSS_() {
		let input = "_TtGSqSS_"
		let output = "Swift.String?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtGSQSS_() {
		let input = "_TtGSQSS_"
		let output = "Swift.String!"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtGVs10DictionarySSSi_() {
		let input = "_TtGVs10DictionarySSSi_"
		let output = "[Swift.String : Swift.Int]"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtVs7CString() {
		let input = "_TtVs7CString"
		let output = "Swift.CString"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtCSo8NSObject() {
		let input = "_TtCSo8NSObject"
		let output = "__ObjC.NSObject"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtO6Monads6Either() {
		let input = "_TtO6Monads6Either"
		let output = "Monads.Either"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtbSiSu() {
		let input = "_TtbSiSu"
		let output = "@convention(block) (Swift.Int) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtcSiSu() {
		let input = "_TtcSiSu"
		let output = "@convention(c) (Swift.Int) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtbTSiSc_Su() {
		let input = "_TtbTSiSc_Su"
		let output = "@convention(block) (Swift.Int, Swift.UnicodeScalar) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtcTSiSc_Su() {
		let input = "_TtcTSiSc_Su"
		let output = "@convention(c) (Swift.Int, Swift.UnicodeScalar) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtFSiSu() {
		let input = "_TtFSiSu"
		let output = "(Swift.Int) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtKSiSu() {
		let input = "_TtKSiSu"
		let output = "@autoclosure (Swift.Int) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtFSiFScSu() {
		let input = "_TtFSiFScSu"
		let output = "(Swift.Int) -> (Swift.UnicodeScalar) -> Swift.UInt"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtMSi() {
		let input = "_TtMSi"
		let output = "Swift.Int.Type"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtP_() {
		let input = "_TtP_"
		let output = "protocol<>"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtP3foo3bar_() {
		let input = "_TtP3foo3bar_"
		let output = "foo.bar"
for _ in 0..<1_000_000 {
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
}
	}
	
	func test_TtP3foo3barS_3bas_() {
		let input = "_TtP3foo3barS_3bas_"
		let output = "protocol<foo.bar, foo.bas>"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtTP3foo3barS_3bas_PS1__PS1_S_3zimS0___() {
		let input = "_TtTP3foo3barS_3bas_PS1__PS1_S_3zimS0___"
		let output = "(protocol<foo.bar, foo.bas>, foo.bas, protocol<foo.bas, foo.zim, foo.bar>)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtRSi() {
		let input = "_TtRSi"
		let output = "inout Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtTSiSu_() {
		let input = "_TtTSiSu_"
		let output = "(Swift.Int, Swift.UInt)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TttSiSu_() {
		let input = "_TttSiSu_"
		let output = "(Swift.Int, Swift.UInt...)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtT3fooSi3barSu_() {
		let input = "_TtT3fooSi3barSu_"
		let output = "(foo : Swift.Int, bar : Swift.UInt)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TturFxx() {
		let input = "_TturFxx"
		let output = "<A> (A) -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuzrFT_T_() {
		let input = "_TtuzrFT_T_"
		let output = "<> () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Ttu__rFxqd__() {
		let input = "_Ttu__rFxqd__"
		let output = "<A><A1> (A) -> A1"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Ttu_z_rFxqd0__() {
		let input = "_Ttu_z_rFxqd0__"
		let output = "<A><><A2> (A) -> A2"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Ttu0_rFxq_() {
		let input = "_Ttu0_rFxq_"
		let output = "<A, B> (A) -> B"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuRxs8RunciblerFxwx5Mince() {
		let input = "_TtuRxs8RunciblerFxwx5Mince"
		let output = "<A where A: Swift.Runcible> (A) -> A.Mince"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuRxs8RunciblerFxWx5Mince6Quince_() {
		let input = "_TtuRxs8RunciblerFxWx5Mince6Quince_"
		let output = "<A where A: Swift.Runcible> (A) -> A.Mince.Quince"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince() {
		let input = "_TtuRxs8Runciblexs8FungiblerFxwxPS_5Mince"
		let output = "<A where A: Swift.Runcible, A: Swift.Fungible> (A) -> A.Mince"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuRxCs22AbstractRuncingFactoryrFxx() {
		let input = "_TtuRxCs22AbstractRuncingFactoryrFxx"
		let output = "<A where A: Swift.AbstractRuncingFactory> (A) -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuRxs8Runciblewx5MincezxrFxx() {
		let input = "_TtuRxs8Runciblewx5MincezxrFxx"
		let output = "<A where A: Swift.Runcible, A.Mince == A> (A) -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtuRxs8RuncibleWx5Mince6Quince_zxrFxx() {
		let input = "_TtuRxs8RuncibleWx5Mince6Quince_zxrFxx"
		let output = "<A where A: Swift.Runcible, A.Mince.Quince == A> (A) -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Ttu0_Rxs8Runcible_S_wx5Minces8Fungiblew_S0_S1_rFxq_() {
		let input = "_Ttu0_Rxs8Runcible_S_wx5Minces8Fungiblew_S0_S1_rFxq_"
		let output = "<A, B where A: Swift.Runcible, B: Swift.Runcible, A.Mince: Swift.Fungible, B.Mince: Swift.Fungible> (A) -> B"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Ttu0_Rx3Foo3BarxCS_3Bas_S0__S1_rT_() {
		let input = "_Ttu0_Rx3Foo3BarxCS_3Bas_S0__S1_rT_"
		let output = "<A, B where A: Foo.Bar, A: Foo.Bas, B: Foo.Bar, B: Foo.Bas> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Tv3foo3barSi() {
		let input = "_Tv3foo3barSi"
		let output = "foo.bar : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3fooau3barSi() {
		let input = "_TF3fooau3barSi"
		let output = "foo.bar.unsafeMutableAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foolu3barSi() {
		let input = "_TF3foolu3barSi"
		let output = "foo.bar.unsafeAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3fooaO3barSi() {
		let input = "_TF3fooaO3barSi"
		let output = "foo.bar.owningMutableAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foolO3barSi() {
		let input = "_TF3foolO3barSi"
		let output = "foo.bar.owningAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3fooao3barSi() {
		let input = "_TF3fooao3barSi"
		let output = "foo.bar.nativeOwningMutableAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foolo3barSi() {
		let input = "_TF3foolo3barSi"
		let output = "foo.bar.nativeOwningAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3fooap3barSi() {
		let input = "_TF3fooap3barSi"
		let output = "foo.bar.nativePinningMutableAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foolp3barSi() {
		let input = "_TF3foolp3barSi"
		let output = "foo.bar.nativePinningAddressor : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foog3barSi() {
		let input = "_TF3foog3barSi"
		let output = "foo.bar.getter : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foos3barSi() {
		let input = "_TF3foos3barSi"
		let output = "foo.bar.setter : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC3foo3bar3basfT3zimCS_3zim_T_() {
		let input = "_TFC3foo3bar3basfT3zimCS_3zim_T_"
		let output = "foo.bar.bas (zim : foo.zim) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TToFC3foo3bar3basfT3zimCS_3zim_T_() {
		let input = "_TToFC3foo3bar3basfT3zimCS_3zim_T_"
		let output = "@objc foo.bar.bas (zim : foo.zim) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTOFSC3fooFTSdSd_Sd() {
		let input = "_TTOFSC3fooFTSdSd_Sd"
		let output = "@nonobjc __C.foo (Swift.Double, Swift.Double) -> Swift.Double"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTDFC3foo3bar3basfT3zimCS_3zim_T_() {
		let input = "_TTDFC3foo3bar3basfT3zimCS_3zim_T_"
		let output = "dynamic foo.bar.bas (zim : foo.zim) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foooi1pFTCS_3barVS_3bas_OS_3zim() {
		let input = "_TF3foooi1pFTCS_3barVS_3bas_OS_3zim"
		let output = "foo.+ infix (foo.bar, foo.bas) -> foo.zim"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF3foooP1xFTCS_3barVS_3bas_OS_3zim() {
		let input = "_TF3foooP1xFTCS_3barVS_3bas_OS_3zim"
		let output = "foo.^ postfix (foo.bar, foo.bas) -> foo.zim"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC3foo3barCfT_S0_() {
		let input = "_TFC3foo3barCfT_S0_"
		let output = "foo.bar.__allocating_init () -> foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC3foo3barcfT_S0_() {
		let input = "_TFC3foo3barcfT_S0_"
		let output = "foo.bar.init () -> foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC3foo3barD() {
		let input = "_TFC3foo3barD"
		let output = "foo.bar.__deallocating_deinit"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC3foo3bard() {
		let input = "_TFC3foo3bard"
		let output = "foo.bar.deinit"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TMPC3foo3bar() {
		let input = "_TMPC3foo3bar"
		let output = "generic type metadata pattern for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TMnC3foo3bar() {
		let input = "_TMnC3foo3bar"
		let output = "nominal type descriptor for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TMmC3foo3bar() {
		let input = "_TMmC3foo3bar"
		let output = "metaclass for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TMC3foo3bar() {
		let input = "_TMC3foo3bar"
		let output = "type metadata for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TMfC3foo3bar() {
		let input = "_TMfC3foo3bar"
		let output = "full type metadata for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwalC3foo3bar() {
		let input = "_TwalC3foo3bar"
		let output = "allocateBuffer value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwcaC3foo3bar() {
		let input = "_TwcaC3foo3bar"
		let output = "assignWithCopy value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwtaC3foo3bar() {
		let input = "_TwtaC3foo3bar"
		let output = "assignWithTake value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwdeC3foo3bar() {
		let input = "_TwdeC3foo3bar"
		let output = "deallocateBuffer value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwxxC3foo3bar() {
		let input = "_TwxxC3foo3bar"
		let output = "destroy value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwXXC3foo3bar() {
		let input = "_TwXXC3foo3bar"
		let output = "destroyBuffer value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwCPC3foo3bar() {
		let input = "_TwCPC3foo3bar"
		let output = "initializeBufferWithCopyOfBuffer value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwCpC3foo3bar() {
		let input = "_TwCpC3foo3bar"
		let output = "initializeBufferWithCopy value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwcpC3foo3bar() {
		let input = "_TwcpC3foo3bar"
		let output = "initializeWithCopy value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwTKC3foo3bar() {
		let input = "_TwTKC3foo3bar"
		let output = "initializeBufferWithTakeOfBuffer value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwTkC3foo3bar() {
		let input = "_TwTkC3foo3bar"
		let output = "initializeBufferWithTake value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwtkC3foo3bar() {
		let input = "_TwtkC3foo3bar"
		let output = "initializeWithTake value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TwprC3foo3bar() {
		let input = "_TwprC3foo3bar"
		let output = "projectBuffer value witness for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWVC3foo3bar() {
		let input = "_TWVC3foo3bar"
		let output = "value witness table for foo.bar"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWoFC3foo3bar3basFSiSi() {
		let input = "_TWoFC3foo3bar3basFSiSi"
		let output = "witness table offset for foo.bar.bas (Swift.Int) -> Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWvdvC3foo3bar3basSi() {
		let input = "_TWvdvC3foo3bar3basSi"
		let output = "direct field offset for foo.bar.bas : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWvivC3foo3bar3basSi() {
		let input = "_TWvivC3foo3bar3basSi"
		let output = "indirect field offset for foo.bar.bas : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWPC3foo3barS_8barrables() {
		let input = "_TWPC3foo3barS_8barrables"
		let output = "protocol witness table for foo.bar : foo.barrable in Swift"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWaC3foo3barS_8barrableS_() {
		let input = "_TWaC3foo3barS_8barrableS_"
		let output = "protocol witness table accessor for foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWlC3foo3barS0_S_8barrableS_() {
		let input = "_TWlC3foo3barS0_S_8barrableS_"
		let output = "lazy protocol witness table accessor for type foo.bar and conformance foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWLC3foo3barS0_S_8barrableS_() {
		let input = "_TWLC3foo3barS0_S_8barrableS_"
		let output = "lazy protocol witness table cache variable for type foo.bar and conformance foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWGC3foo3barS_8barrableS_() {
		let input = "_TWGC3foo3barS_8barrableS_"
		let output = "generic protocol witness table for foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWIC3foo3barS_8barrableS_() {
		let input = "_TWIC3foo3barS_8barrableS_"
		let output = "instantiation function for generic protocol witness table for foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWtC3foo3barS_8barrableS_4fred() {
		let input = "_TWtC3foo3barS_8barrableS_4fred"
		let output = "associated type metadata accessor for fred in foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWTC3foo3barS_8barrableS_4fredS_6thomas() {
		let input = "_TWTC3foo3barS_8barrableS_4fredS_6thomas"
		let output = "associated type witness table accessor for fred : foo.thomas in foo.bar : foo.barrable in foo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFSCg5greenVSC5Color() {
		let input = "_TFSCg5greenVSC5Color"
		let output = "__C.green.getter : __C.Color"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TIF1t1fFT1iSi1sSS_T_A_() {
		let input = "_TIF1t1fFT1iSi1sSS_T_A_"
		let output = "t.(f (i : Swift.Int, s : Swift.String) -> ()).(default argument 0)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TIF1t1fFT1iSi1sSS_T_A0_() {
		let input = "_TIF1t1fFT1iSi1sSS_T_A0_"
		let output = "t.(f (i : Swift.Int, s : Swift.String) -> ()).(default argument 1)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFSqcfT_GSqx_() {
		let input = "_TFSqcfT_GSqx_"
		let output = "Swift.Optional.init () -> A?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF21class_bound_protocols32class_bound_protocol_compositionFT1xPS_10ClassBoundS_13NotClassBound__PS0_S1__() {
		let input = "_TF21class_bound_protocols32class_bound_protocol_compositionFT1xPS_10ClassBoundS_13NotClassBound__PS0_S1__"
		let output = "class_bound_protocols.class_bound_protocol_composition (x : protocol<class_bound_protocols.ClassBound, class_bound_protocols.NotClassBound>) -> protocol<class_bound_protocols.ClassBound, class_bound_protocols.NotClassBound>"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtZZ() {
		let input = "_TtZZ"
		let output = "_TtZZ"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtB() {
		let input = "_TtB"
		let output = "_TtB"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBSi() {
		let input = "_TtBSi"
		let output = "_TtBSi"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtBx() {
		let input = "_TtBx"
		let output = "_TtBx"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtC() {
		let input = "_TtC"
		let output = "_TtC"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtT() {
		let input = "_TtT"
		let output = "_TtT"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtTSi() {
		let input = "_TtTSi"
		let output = "_TtTSi"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtQd_() {
		let input = "_TtQd_"
		let output = "_TtQd_"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtU__FQo_Si() {
		let input = "_TtU__FQo_Si"
		let output = "_TtU__FQo_Si"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtU__FQD__Si() {
		let input = "_TtU__FQD__Si"
		let output = "_TtU__FQD__Si"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtU___FQ_U____FQd0__T_() {
		let input = "_TtU___FQ_U____FQd0__T_"
		let output = "_TtU___FQ_U____FQd0__T_"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtU___FQ_U____FQd_1_T_() {
		let input = "_TtU___FQ_U____FQd_1_T_"
		let output = "_TtU___FQ_U____FQd_1_T_"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtU___FQ_U____FQ2_T_() {
		let input = "_TtU___FQ_U____FQ2_T_"
		let output = "_TtU___FQ_U____FQ2_T_"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Tw() {
		let input = "_Tw"
		let output = "_Tw"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWa() {
		let input = "_TWa"
		let output = "_TWa"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Twal() {
		let input = "_Twal"
		let output = "_Twal"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_T() {
		let input = "_T"
		let output = "_T"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTo() {
		let input = "_TTo"
		let output = "_TTo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TC() {
		let input = "_TC"
		let output = "_TC"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TM() {
		let input = "_TM"
		let output = "_TM"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TW() {
		let input = "_TW"
		let output = "_TW"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWV() {
		let input = "_TWV"
		let output = "_TWV"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWo() {
		let input = "_TWo"
		let output = "_TWo"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWv() {
		let input = "_TWv"
		let output = "_TWv"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWvd() {
		let input = "_TWvd"
		let output = "_TWvd"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWvi() {
		let input = "_TWvi"
		let output = "_TWvi"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TWvx() {
		let input = "_TWvx"
		let output = "_TWvx"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtVCC4main3Foo4Ding3Str() {
		let input = "_TtVCC4main3Foo4Ding3Str"
		let output = "main.Foo.Ding.Str"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFVCC6nested6AClass12AnotherClass7AStruct9aFunctionfT1aSi_S2_() {
		let input = "_TFVCC6nested6AClass12AnotherClass7AStruct9aFunctionfT1aSi_S2_"
		let output = "nested.AClass.AnotherClass.AStruct.aFunction (a : Swift.Int) -> nested.AClass.AnotherClass.AStruct"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtXwC10attributes10SwiftClass() {
		let input = "_TtXwC10attributes10SwiftClass"
		let output = "weak attributes.SwiftClass"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtXoC10attributes10SwiftClass() {
		let input = "_TtXoC10attributes10SwiftClass"
		let output = "unowned attributes.SwiftClass"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtERR() {
		let input = "_TtERR"
		let output = "<ERROR TYPE>"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtGSqGSaC5sugar7MyClass__() {
		let input = "_TtGSqGSaC5sugar7MyClass__"
		let output = "[sugar.MyClass]?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtGSaGSqC5sugar7MyClass__() {
		let input = "_TtGSaGSqC5sugar7MyClass__"
		let output = "[sugar.MyClass?]"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtaC9typealias5DWARF9DIEOffset() {
		let input = "_TtaC9typealias5DWARF9DIEOffset"
		let output = "typealias.DWARF.DIEOffset"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_Ttas3Int() {
		let input = "_Ttas3Int"
		let output = "Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTRXFo_dSc_dSb_XFo_iSc_iSb_() {
		let input = "_TTRXFo_dSc_dSb_XFo_iSc_iSb_"
		let output = "reabstraction thunk helper from @callee_owned (@unowned Swift.UnicodeScalar) -> (@unowned Swift.Bool) to @callee_owned (@in Swift.UnicodeScalar) -> (@out Swift.Bool)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__() {
		let input = "_TTRXFo_dSi_dGSqSi__XFo_iSi_iGSqSi__"
		let output = "reabstraction thunk helper from @callee_owned (@unowned Swift.Int) -> (@unowned Swift.Int?) to @callee_owned (@in Swift.Int) -> (@out Swift.Int?)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_() {
		let input = "_TTRGrXFo_iV18switch_abstraction1A_ix_XFo_dS0__ix_"
		let output = "reabstraction thunk helper <A> from @callee_owned (@in switch_abstraction.A) -> (@out A) to @callee_owned (@unowned switch_abstraction.A) -> (@out A)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFCF5types1gFT1bSb_T_L0_10Collection3zimfT_T_() {
		let input = "_TFCF5types1gFT1bSb_T_L0_10Collection3zimfT_T_"
		let output = "types.(g (b : Swift.Bool) -> ()).(Collection #2).zim () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFF17capture_promotion22test_capture_promotionFT_FT_SiU_FT_Si_promote0() {
		let input = "_TFF17capture_promotion22test_capture_promotionFT_FT_SiU_FT_Si_promote0"
		let output = "capture_promotion.(test_capture_promotion () -> () -> Swift.Int).(closure #1) with unmangled suffix \"_promote0\""
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFIVs8_Processi10_argumentsGSaSS_U_FT_GSaSS_() {
		let input = "_TFIVs8_Processi10_argumentsGSaSS_U_FT_GSaSS_"
		let output = "Swift._Process.(variable initialization expression)._arguments : [Swift.String] with unmangled suffix \"U_FT_GSaSS_\""
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFIvVs8_Process10_argumentsGSaSS_iU_FT_GSaSS_() {
		let input = "_TFIvVs8_Process10_argumentsGSaSS_iU_FT_GSaSS_"
		let output = "Swift._Process.(_arguments : [Swift.String]).(variable initialization expression).(closure #1)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFCSo1AE() {
		let input = "_TFCSo1AE"
		let output = "__ObjC.A.__ivar_destroyer"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFCSo1Ae() {
		let input = "_TFCSo1Ae"
		let output = "__ObjC.A.__ivar_initializer"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTWC13call_protocol1CS_1PS_FS1_3foofT_Si() {
		let input = "_TTWC13call_protocol1CS_1PS_FS1_3foofT_Si"
		let output = "protocol witness for call_protocol.P.foo () -> Swift.Int in conformance call_protocol.C : call_protocol.P in call_protocol"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC12dynamic_self1X1ffT_DS0_() {
		let input = "_TFC12dynamic_self1X1ffT_DS0_"
		let output = "dynamic_self.X.f () -> Self"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSg5Si___TFSqcfT_GSqx_() {
		let input = "_TTSg5Si___TFSqcfT_GSqx_"
		let output = "generic specialization <Swift.Int> of Swift.Optional.init () -> A?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgq5Si___TFSqcfT_GSqx_() {
		let input = "_TTSgq5Si___TFSqcfT_GSqx_"
		let output = "generic specialization <preserving fragile attribute, Swift.Int> of Swift.Optional.init () -> A?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSg5SiSis3Foos_Sf___TFSqcfT_GSqx_() {
		let input = "_TTSg5SiSis3Foos_Sf___TFSqcfT_GSqx_"
		let output = "generic specialization <Swift.Int with Swift.Int : Swift.Foo in Swift, Swift.Float> of Swift.Optional.init () -> A?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSg5Si_Sf___TFSqcfT_GSqx_() {
		let input = "_TTSg5Si_Sf___TFSqcfT_GSqx_"
		let output = "generic specialization <Swift.Int, Swift.Float> of Swift.Optional.init () -> A?"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgS() {
		let input = "_TTSgS"
		let output = "_TTSgS"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSg5S() {
		let input = "_TTSg5S"
		let output = "_TTSg5S"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgSi() {
		let input = "_TTSgSi"
		let output = "_TTSgSi"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSg5Si() {
		let input = "_TTSg5Si"
		let output = "_TTSg5Si"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgSi_() {
		let input = "_TTSgSi_"
		let output = "_TTSgSi_"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgSi__() {
		let input = "_TTSgSi__"
		let output = "_TTSgSi__"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgSiS_() {
		let input = "_TTSgSiS_"
		let output = "_TTSgSiS_"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSgSi__xyz() {
		let input = "_TTSgSi__xyz"
		let output = "_TTSgSi__xyz"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSr5Si___TF4test7genericurFxx() {
		let input = "_TTSr5Si___TF4test7genericurFxx"
		let output = "generic not re-abstracted specialization <Swift.Int> of test.generic <A> (A) -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSrq5Si___TF4test7genericurFxx() {
		let input = "_TTSrq5Si___TF4test7genericurFxx"
		let output = "generic not re-abstracted specialization <preserving fragile attribute, Swift.Int> of test.generic <A> (A) -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_31() {
		let input = "_TPA__TTRXFo_oSSoSS_dSb_XFo_iSSiSS_dSb_31"
		let output = "partial apply forwarder for reabstraction thunk helper from @callee_owned (@owned Swift.String, @owned Swift.String) -> (@unowned Swift.Bool) to @callee_owned (@in Swift.String, @in Swift.String) -> (@unowned Swift.Bool) with unmangled suffix \"31\""
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TiC4Meow5MyCls9subscriptFT1iSi_Sf() {
		let input = "_TiC4Meow5MyCls9subscriptFT1iSi_Sf"
		let output = "Meow.MyCls.subscript (i : Swift.Int) -> Swift.Float"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF8manglingX22egbpdajGbuEbxfgehfvwxnFT_T_() {
		let input = "_TF8manglingX22egbpdajGbuEbxfgehfvwxnFT_T_"
		let output = "mangling.ليهمابتكلموشعربي؟ () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF8manglingX24ihqwcrbEcvIaIdqgAFGpqjyeFT_T_() {
		let input = "_TF8manglingX24ihqwcrbEcvIaIdqgAFGpqjyeFT_T_"
		let output = "mangling.他们为什么不说中文 () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF8manglingX27ihqwctvzcJBfGFJdrssDxIboAybFT_T_() {
		let input = "_TF8manglingX27ihqwctvzcJBfGFJdrssDxIboAybFT_T_"
		let output = "mangling.他們爲什麽不說中文 () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF8manglingX30Proprostnemluvesky_uybCEdmaEBaFT_T_() {
		let input = "_TF8manglingX30Proprostnemluvesky_uybCEdmaEBaFT_T_"
		let output = "mangling.Pročprostěnemluvíčesky () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF8manglingXoi7p_qcaDcFTSiSi_Si() {
		let input = "_TF8manglingXoi7p_qcaDcFTSiSi_Si"
		let output = "mangling.«+» infix (Swift.Int, Swift.Int) -> Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF8manglingoi2qqFTSiSi_T_() {
		let input = "_TF8manglingoi2qqFTSiSi_T_"
		let output = "mangling.?? infix (Swift.Int, Swift.Int) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFE11ext_structAV11def_structA1A4testfT_T_() {
		let input = "_TFE11ext_structAV11def_structA1A4testfT_T_"
		let output = "(extension in ext_structA):def_structA.A.test () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF13devirt_accessP5_DISC15getPrivateClassFT_CS_P5_DISC12PrivateClass() {
		let input = "_TF13devirt_accessP5_DISC15getPrivateClassFT_CS_P5_DISC12PrivateClass"
		let output = "devirt_access.(getPrivateClass in _DISC) () -> devirt_access.(PrivateClass in _DISC)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF4mainP5_mainX3wxaFT_T_() {
		let input = "_TF4mainP5_mainX3wxaFT_T_"
		let output = "main.(λ in _main) () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF4mainP5_main3abcFT_aS_P5_DISC3xyz() {
		let input = "_TF4mainP5_main3abcFT_aS_P5_DISC3xyz"
		let output = "main.(abc in _main) () -> main.(xyz in _DISC)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TtPMP_() {
		let input = "_TtPMP_"
		let output = "protocol<>.Type"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFCs13_NSSwiftArray29canStoreElementsOfDynamicTypefPMP_Sb() {
		let input = "_TFCs13_NSSwiftArray29canStoreElementsOfDynamicTypefPMP_Sb"
		let output = "Swift._NSSwiftArray.canStoreElementsOfDynamicType (protocol<>.Type) -> Swift.Bool"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFCs13_NSSwiftArrayg17staticElementTypePMP_() {
		let input = "_TFCs13_NSSwiftArrayg17staticElementTypePMP_"
		let output = "Swift._NSSwiftArray.staticElementType.getter : protocol<>.Type"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFCs17_DictionaryMirrorg9valueTypePMP_() {
		let input = "_TFCs17_DictionaryMirrorg9valueTypePMP_"
		let output = "Swift._DictionaryMirror.valueType.getter : protocol<>.Type"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <Arg[0] = [Closure Propagated : specgen.(caller (Swift.Int) -> ()).(closure #1), Argument Types : [Swift.Int]> of specgen.take_closure ((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSfq1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <preserving fragile attribute, Arg[0] = [Closure Propagated : specgen.(caller (Swift.Int) -> ()).(closure #1), Argument Types : [Swift.Int]> of specgen.take_closure ((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TTSg5Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TTSg5Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <Arg[0] = [Closure Propagated : specgen.(caller (Swift.Int) -> ()).(closure #1), Argument Types : [Swift.Int]> of generic specialization <Swift.Int> of specgen.take_closure ((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSg5Si___TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSg5Si___TTSf1cl35_TFF7specgen6callerFSiT_U_FTSiSi_T_Si___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "generic specialization <Swift.Int> of function signature specialization <Arg[0] = [Closure Propagated : specgen.(caller (Swift.Int) -> ()).(closure #1), Argument Types : [Swift.Int]> of specgen.take_closure ((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__() {
		let input = "_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_dT__XFo_iSi_dT__"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : capturep.helper (Swift.Int) -> ()]> of reabstraction thunk helper from @callee_owned (@unowned Swift.Int) -> (@unowned ()) to @callee_owned (@in Swift.Int) -> (@unowned ())"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__() {
		let input = "_TTSf1cpfr24_TF8capturep6helperFSiT__n___TTRXFo_dSi_DT__XFo_iSi_DT__"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Function : capturep.helper (Swift.Int) -> ()]> of reabstraction thunk helper from @callee_owned (@unowned Swift.Int) -> (@unowned_inner_pointer ()) to @callee_owned (@in Swift.Int) -> (@unowned_inner_pointer ())"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf1cpi0_cpfl0_cpse0v4u123_cpg53globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8_cpfr36_TFtest_capture_propagation2_closure___TF7specgen12take_closureFFTSiSi_T_T_() {
		let input = "_TTSf1cpi0_cpfl0_cpse0v4u123_cpg53globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8_cpfr36_TFtest_capture_propagation2_closure___TF7specgen12take_closureFFTSiSi_T_T_"
		let output = "function signature specialization <Arg[0] = [Constant Propagated Integer : 0], Arg[1] = [Constant Propagated Float : 0], Arg[2] = [Constant Propagated String : u8'u123'], Arg[3] = [Constant Propagated Global : globalinit_33_06E7F1D906492AE070936A9B58CBAE1C_token8], Arg[4] = [Constant Propagated Function : _TFtest_capture_propagation2_closure]> of specgen.take_closure ((Swift.Int, Swift.Int) -> ()) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf0gs___TFVs11_StringCore15_invariantCheckfT_T_() {
		let input = "_TTSf0gs___TFVs11_StringCore15_invariantCheckfT_T_"
		let output = "function signature specialization <Arg[0] = Owned To Guaranteed and Exploded> of Swift._StringCore._invariantCheck () -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf2g___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2g___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Owned To Guaranteed> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._StringCore.init (Swift._StringBuffer) -> Swift._StringCore"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf2dg___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dg___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Owned To Guaranteed> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._StringCore.init (Swift._StringBuffer) -> Swift._StringCore"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf2dgs___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf2dgs___TTSf2s_d___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead and Owned To Guaranteed and Exploded> of function signature specialization <Arg[0] = Exploded, Arg[1] = Dead> of Swift._StringCore.init (Swift._StringBuffer) -> Swift._StringCore"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf3d_i_d_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf3d_i_d_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead, Arg[1] = Value Promoted from Box, Arg[2] = Dead, Arg[3] = Value Promoted from Box, Arg[4] = Dead, Arg[5] = Value Promoted from Box> of Swift._StringCore.init (Swift._StringBuffer) -> Swift._StringCore"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTSf3d_i_n_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_() {
		let input = "_TTSf3d_i_n_i_d_i___TFVs11_StringCoreCfVs13_StringBufferS_"
		let output = "function signature specialization <Arg[0] = Dead, Arg[1] = Value Promoted from Box, Arg[3] = Value Promoted from Box, Arg[4] = Dead, Arg[5] = Value Promoted from Box> of Swift._StringCore.init (Swift._StringBuffer) -> Swift._StringCore"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFIZvV8mangling10HasVarInit5stateSbiu_KT_Sb() {
		let input = "_TFIZvV8mangling10HasVarInit5stateSbiu_KT_Sb"
		let output = "static mangling.HasVarInit.(state : Swift.Bool).(variable initialization expression).(implicit closure #1)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFFV23interface_type_mangling18GenericTypeContext23closureInGenericContexturFqd__T_L_3fooFTQd__Q__T_() {
		let input = "_TFFV23interface_type_mangling18GenericTypeContext23closureInGenericContexturFqd__T_L_3fooFTQd__Q__T_"
		let output = "interface_type_mangling.GenericTypeContext.(closureInGenericContext <A> (A1) -> ()).(foo #1) (A1, A) -> ()"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFFV23interface_type_mangling18GenericTypeContextg31closureInGenericPropertyContextxL_3fooFT_Q_() {
		let input = "_TFFV23interface_type_mangling18GenericTypeContextg31closureInGenericPropertyContextxL_3fooFT_Q_"
		let output = "interface_type_mangling.GenericTypeContext.(closureInGenericPropertyContext.getter : A).(foo #1) () -> A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_23closureInGenericContextuRxS1_rfqd__T_() {
		let input = "_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_23closureInGenericContextuRxS1_rfqd__T_"
		let output = "protocol witness for interface_type_mangling.GenericWitnessTest.closureInGenericContext <A where A: interface_type_mangling.GenericWitnessTest> (A1) -> () in conformance <A> interface_type_mangling.GenericTypeContext<A> : interface_type_mangling.GenericWitnessTest in interface_type_mangling"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_g31closureInGenericPropertyContextwx3Tee() {
		let input = "_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_g31closureInGenericPropertyContextwx3Tee"
		let output = "protocol witness for interface_type_mangling.GenericWitnessTest.closureInGenericPropertyContext.getter : A.Tee in conformance <A> interface_type_mangling.GenericTypeContext<A> : interface_type_mangling.GenericWitnessTest in interface_type_mangling"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_16twoParamsAtDepthu0_RxS1_rfTqd__1yqd_0__T_() {
		let input = "_TTWurGV23interface_type_mangling18GenericTypeContextx_S_18GenericWitnessTestS_FS1_16twoParamsAtDepthu0_RxS1_rfTqd__1yqd_0__T_"
		let output = "protocol witness for interface_type_mangling.GenericWitnessTest.twoParamsAtDepth <A, B where A: interface_type_mangling.GenericWitnessTest> (A1, y : B1) -> () in conformance <A> interface_type_mangling.GenericTypeContext<A> : interface_type_mangling.GenericWitnessTest in interface_type_mangling"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFC3red11BaseClassEHcfzT1aSi_S0_() {
		let input = "_TFC3red11BaseClassEHcfzT1aSi_S0_"
		let output = "red.BaseClassEH.init (a : Swift.Int) throws -> red.BaseClassEH"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1aSi() {
		let input = "_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1aSi"
		let output = "(extension in mangling_generic_extensions):mangling_generic_extensions.Foo<A where A: mangling_generic_extensions.Runcible>.a.getter : Swift.Int"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1bx() {
		let input = "_TFe27mangling_generic_extensionsRxS_8RunciblerVS_3Foog1bx"
		let output = "(extension in mangling_generic_extensions):mangling_generic_extensions.Foo<A where A: mangling_generic_extensions.Runcible>.b.getter : A"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TTRXFo_iT__iT_zoPs13ErrorProtocol__XFo__dT_zoPS___() {
		let input = "_TTRXFo_iT__iT_zoPs13ErrorProtocol__XFo__dT_zoPS___"
		let output = "reabstraction thunk helper from @callee_owned (@in ()) -> (@out (), @error @owned Swift.ErrorProtocol) to @callee_owned () -> (@unowned (), @error @owned Swift.ErrorProtocol)"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TFE1a() {
		let input = "_TFE1a"
		let output = "_TFE1a"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TF21$__lldb_module_for_E0au3$E0Ps13ErrorProtocol_() {
		let input = "_TF21$__lldb_module_for_E0au3$E0Ps13ErrorProtocol_"
		let output = "$__lldb_module_for_E0.$E0.unsafeMutableAddressor : Swift.ErrorProtocol"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
	
	func test_TMps10Comparable() {
		let input = "_TMps10Comparable"
		let output = "protocol descriptor for Swift.Comparable"
		do {
			let result = try demangleSwiftName(input).description
			XCTAssert(result == output, "Failed to demangle \(input). Got \(result), expected \(output)")
		} catch {
			XCTAssert(input == output, "Failed to demangle \(input). Got \(error), expected \(output)")
		}
	}
}
