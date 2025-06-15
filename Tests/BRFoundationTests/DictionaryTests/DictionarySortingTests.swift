//
//  DictionarySortingTests.swift
//  BRFoundation
//
//  Created by BR on 2025/6/15.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Dictionary+Sorting")
struct DictionarySortingTests {
    

    @Test("sortedByValue")
    func testSortedByValue() throws {
        let scores: [String: Int] = [
            "Alice": 95,
            "Bob": 80,
            "Charlie": 88
        ]
        
        let sorted = scores.br.sortedByValue(<)
        
        #expect(sorted[0] == ("Bob", 80))
        #expect(sorted[1] == ("Charlie", 88))
        #expect(sorted[2] == ("Alice", 95))
    }
    
    
    @Test("sortedByKey")
    func testSortedByKey() throws {
        let scores: [String: Int] = [
            "Charlie": 88,
            "Alice": 95,
            "Bob": 80
        ]
        
        let sorted = scores.br.sortedByKey(<)
        
        #expect(sorted[0] == ("Alice", 95))
        #expect(sorted[1] == ("Bob", 80))
        #expect(sorted[2] == ("Charlie", 88))
    }

    
}
