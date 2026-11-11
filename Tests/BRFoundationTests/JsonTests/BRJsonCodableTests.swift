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
    
    
    struct Event: BRJSONCodable, Equatable {
        let at: Date
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
    
    
    @Test("Date decode")
    func testDateDecode() throws {
        let date = BRDateFormatter.mySQLFormatter.date(from: "2025-07-17 01:04:04")
        
        #expect(try Event.fromJSONString(#"{"at": 774407044}"#).at == date)
        #expect(try Event.fromJSONString(#"{"at": 1752714244}"#, date: .secondsSince1970).at == date)
        #expect(try Event.fromJSONString(#"{"at": "2025-07-17T01:04:04Z"}"#, date: .iso8601).at == date)
        #expect(try Event.fromJSONString(#"{"at": "2025-07-17 01:04:04"}"#, date: .formatted(BRDateFormatter.mySQLFormatter)).at == date)
        #expect(throws: DecodingError.self) {
            try Event.fromJSONString(#"{"at": "2025-07-17 01:04:04"}"#)
        }
    }
    
    
    @Test("Date encode")
    func testDateEncode() throws {
        let event = Event(at: Date(timeIntervalSince1970: 1752714244))
        
        #expect(try event.toJSONString(output: []) == #"{"at":774407044}"#)
        #expect(try event.toJSONString(output: [], date: .secondsSince1970) == #"{"at":1752714244}"#)
        #expect(try event.toJSONString(output: [], date: .iso8601) == #"{"at":"2025-07-17T01:04:04Z"}"#)
        #expect(try Event.fromJSONString(event.toJSONString()) == event)
    }
    
    
}
