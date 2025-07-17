//
//  BRJsonTests.swift
//  BRFoundation
//
//  Created by BR on 2025/7/17.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("BRJsonTests")
struct BRJsonTests {
    
    
    @Test("ParseData")
    func testParseData() throws {
        let jsonString = """
            {
              "id" : 1,
              "name" : "BR"
            }
            """
        let data = jsonString.data(using: .utf8)!
        let decoded: [String: Any] = try BRJson.parse(data, keys: [
            "id": .int,
            "name": .string
        ])
        #expect(decoded["id"] as? Int == 1)
        #expect(decoded["name"] as? String == "BR")
    }
    
    
    @Test("ParseJsonString")
    func testParseJsonString() throws {
        let json = "[\"a\", \"b\", \"c\"]"
        let array: [String] = try BRJson.parse(json)
        #expect(array[0] == "a")
        #expect(array[1] == "b")
        #expect(array[2] == "c")
    }
    
    
    @Test("ToJsonData")
    func testToJsonData() throws {
        let user: [String: Any] = ["id": 1, "name": "BR"]
        let jsonData = try JSONSerialization.data(withJSONObject: user, options: [])
        let data = try BRJson.data(with: user)
        #expect(jsonData == data)
    }
    
    
    @Test("ToJsonString")
    func testToJsonString() throws {
        let user: [String: Any] = ["id": 1, "name": "BR"]
        let json = try BRJson.string(with: user)
        let jsonString = """
            {
              "id" : 1,
              "name" : "BR"
            }
            """
        #expect(json == jsonString)
    }
    
    
}
