//
//  DictionaryQueryTests.swift
//  BRFoundation
//
//  Created by BR on 2025/6/15.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Dictionary+Query")
struct DictionaryQueryTests {
    
    
    @Test("containsKey")
    func testContainsKey() throws {
        let userInfo: [String: Any] = [
            "name": "Alice",
            "age": 30,
            "isMember": true
        ]
        #expect(userInfo.br.containsKey("age"))
        #expect(!userInfo.br.containsKey("email"))
    }
    
    
}
