//
//  DictionaryTransformTests.swift
//  BRFoundation
//
//  Created by BR on 2025/6/15.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Dictionary+Transform")
struct DictionaryTransformTests {
    
    
    @Test("mapKeys")
    func testMapKeys() throws {
        let raw: [String: String] = ["1001": "Alice", "1002": "Bob"]
        
        let transformed = raw.br.mapKeys { Int($0)! }
        
        #expect(transformed == [1001: "Alice", 1002: "Bob"])
    }

    
    @Test("mapValues")
    func testMapValues() throws {
        let raw: [String: String] = ["Alice": "100", "Bob": "200"]
        
        let converted = raw.br.mapValues { Int($0)! }
        
        #expect(converted == ["Alice": 100, "Bob": 200])
    }
    
    
    @Test("toStringDictionary")
    func testToStringDictionary() throws {
        let raw: [AnyHashable: Any] = [
            1: 100,
            "name": "Alice",
            3: true
        ]
        let stringDict = raw.br.toStringDictionary()
        #expect(stringDict == ["1": "100", "name": "Alice", "3": "true"])
    }
    
    
}
