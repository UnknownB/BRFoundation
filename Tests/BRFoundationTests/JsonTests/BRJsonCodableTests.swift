//
//  JsonTests.swift
//  BRFoundation
//
//  Created by BR on 2025/6/16.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("BRJsonCodableTests")
struct BRJsonCodableTests {
    
    
    struct User: BRJSONCodable, Equatable {
        let id: Int
        let name: String
    }
    
    
    @Test("JsonData")
    func testJsonData() throws {
        let user = User(id: 1, name: "BR")
        let data = try user.toJSONData()
        let decoded = try User.fromJSONData(data)
        
        #expect(user == decoded)
    }
    
    
    @Test("JsonString")
    func testJsonString() throws {
        let user = User(id: 1, name: "BR")
        let jsonString = try user.toJSONString()
        let decoded = try User.fromJSONString(jsonString)
        
        #expect(user == decoded)
    }
    
    
}
