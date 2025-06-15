//
//  DictionaryComparisonTests.swift
//  BRFoundation
//
//  Created by BR on 2025/6/15.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Dictionary+Comparison")
struct DictionaryComparisonTests {
    
    
    @Test("Contains other")
    func testContainsOther() throws {
        let dict = ["a": 1, "b": 2, "c": 3]
        let dictSub = ["a": 1, "b": 2]
        #expect(dict.br.contains(dictSub))
        #expect(!dictSub.br.contains(dict))
    }
    
    
    @Test("isSubset")
    func testIsSubset() throws {
        let dict = ["a": 1, "b": 2, "c": 3]
        let dictSub = ["a": 1, "b": 2]
        #expect(!dict.br.isSubset(of: dictSub))
        #expect(dictSub.br.isSubset(of: dict))
    }

    
}
