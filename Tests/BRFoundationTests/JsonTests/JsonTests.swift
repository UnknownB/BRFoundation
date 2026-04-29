//
//  JsonTests.swift
//  BRFoundation
//
//  Created by BR on 2026/4/29.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("JsonTests")
struct JsonTests {
    
    
    struct CodableTest: BRJSONCodable, Equatable {
        let id: String
        let name: String
    }
    
    
    @Test("StringArray")
    func testStringArray() throws {
        let json =
            """
            ["a","b","c"]
            """
        let array = try [String].br.fromJSON(json)
        
        #expect(array[0] == "a")
        #expect(array[1] == "b")
        #expect(array[2] == "c")
        
        let outputJson = try array.br.toJSONString(output: [.sortedKeys, .withoutEscapingSlashes])
        #expect(json == outputJson)
    }
    
    
    @Test("CodableArray")
    func testCodableArray() throws {
        let array = [
            CodableTest(id: "0", name: "BR"),
            CodableTest(id: "1", name: "Swift"),
            CodableTest(id: "2", name: "Foundation"),
        ]
        let jsonString = try array.br.toJSONString()
        let newArray = try [CodableTest].br.fromJSON(jsonString)
        #expect(array == newArray)
    }
    
    
    @Test("StringDictionary")
    func testStringDictionary() throws {
        let json = """
            {
              "id" : "1",
              "name" : "BR"
            }
            """
        let dictionary = try [String: String].br.fromJSON(json)
        
        #expect(dictionary["id"] == "1")
        #expect(dictionary["name"] == "BR")
        
        let outputJson = try dictionary.br.toJSONString(output: [.sortedKeys, .withoutEscapingSlashes, .prettyPrinted])
        #expect(json == outputJson)
    }
    
    
    @Test("CodableDictionary")
    func testCodableDictionary() throws {
        let dictionary: [String: CodableTest] = [
            "0": CodableTest(id: "0", name: "BR"),
            "1": CodableTest(id: "1", name: "Swift"),
            "2": CodableTest(id: "2", name: "Foundation"),
        ]
        let jsonString = try dictionary.br.toJSONString()
        let newDictionary = try [String: CodableTest].br.fromJSON(jsonString)
        
        #expect(dictionary == newDictionary)
    }
    
    
}
