//
//  StringMaskTests.swift
//  BRFoundation
//
//  Created by BR on 2026/8/7.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("StringMaskTests")
struct StringMaskTests {
    
    
    @Test("Masking")
    func testMasking() throws {
        #expect("1".br.masking() == "***")
        #expect("12".br.masking() == "***")
        #expect("123".br.masking() == "***")
        #expect("1234".br.masking() == "1***4")
        #expect("12345".br.masking() == "1***5")
        #expect("123456".br.masking() == "12***56")
        #expect("1234567".br.masking() == "12***67")
        #expect("12345678".br.masking() == "123***678")
    }
    
    
}
