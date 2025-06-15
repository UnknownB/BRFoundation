//
//  DictionaryFilteringTests.swift
//  BRFoundation
//
//  Created by BR on 2025/6/15.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Dictionary+Filtering")
struct DictionaryFilteringTests {
    
    
    @Test("filterKeys")
    func testFilterKeys() throws {
        let original: [String: Int] = [
            "apple": 3,
            "banana": 5,
            "cherry": 2,
            "date": 7
        ]
        let filtered = original.br.filterKeys { $0.hasPrefix("b") }
        #expect(filtered == ["banana": 5])
    }

    
    @Test("filterValues")
    func testFilterValues() throws {
        let scores: [String: Int] = [
            "Alice": 85,
            "Bob": 92,
            "Charlie": 76,
            "Diana": 88
        ]
        let passed = scores.br.filterValues { $0 >= 80 }
        #expect(passed == ["Alice": 85, "Bob": 92, "Diana": 88])
    }
    
    
    @Test("filterAsType")
    func testFilterAsType() throws {
        let raw: [AnyHashable: Any] = [
            "id": 1001,
            "name": "Alice",
            42: "Should be removed",
            "active": true
        ]
        let stringToString: [String: String] = raw.br.filterAsType()
        #expect(stringToString == ["name": "Alice"])
    }

    
}
