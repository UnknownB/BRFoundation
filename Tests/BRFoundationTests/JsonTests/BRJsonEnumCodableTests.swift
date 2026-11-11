//
//  BRJsonEnumCodableTests.swift
//  BRFoundation
//
//  Created by BR on 2026/11/11.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("BRJsonEnumCodableTests")
struct BRJsonEnumCodableTests {
    
    
    enum Status: String, BRJSONEnumCodable {
        case normal = "1"
        case banned = "2"
        case unknown
        
        static let fallback = Status.unknown
    }
    
    
    enum Level: Int, BRJSONEnumCodable {
        case low = 1
        case high = 2
        case unknown = -1
        
        static let fallback = Level.unknown
    }
    
    
    struct StatusModel: BRJSONCodable, Equatable {
        let id: String
        let status: Status
    }
    
    
    struct LevelModel: BRJSONCodable, Equatable {
        let level: Level
    }
    
    
    struct ArrayModel: BRJSONCodable, Equatable {
        let statuses: [Status]
    }
    
    
    struct OptionalModel: BRJSONCodable, Equatable {
        var status: Status? = nil
    }
    
    
    // MARK: - 解析
    
    
    @Test("已知的 rawValue")
    func testKnownRawValue() throws {
        #expect(try StatusModel.fromJSONString(#"{"id": "1", "status": "2"}"#).status == .banned)
        #expect(try LevelModel.fromJSONString(#"{"level": 2}"#).level == .high)
    }
    
    
    @Test("未知的 rawValue 退回 fallback")
    func testUnknownRawValue() throws {
        #expect(try StatusModel.fromJSONString(#"{"id": "1", "status": "99"}"#).status == .unknown)
        #expect(try LevelModel.fromJSONString(#"{"level": 99}"#).level == .unknown)
    }
    
    
    @Test("未知的 rawValue 不影響其他欄位")
    func testUnknownRawValueKeepsOtherFields() throws {
        let model = try StatusModel.fromJSONString(#"{"id": "BR", "status": "99"}"#)
        
        #expect(model.id == "BR")
        #expect(model.status == .unknown)
    }
    
    
    @Test("陣列中的未知值只影響該元素")
    func testUnknownRawValueInArray() throws {
        let model = try ArrayModel.fromJSONString(#"{"statuses": ["1", "99", "2"]}"#)
        
        #expect(model.statuses == [.normal, .unknown, .banned])
    }
    
    
    @Test("Optional 欄位缺 key 與 null 都是 nil")
    func testOptionalField() throws {
        #expect(try OptionalModel.fromJSONString("{}").status == nil)
        #expect(try OptionalModel.fromJSONString(#"{"status": null}"#).status == nil)
        #expect(try OptionalModel.fromJSONString(#"{"status": "99"}"#).status == .unknown)
    }
    
    
    @Test("rawValue 型別不符會解析失敗")
    func testRawValueTypeMismatch() throws {
        #expect(throws: DecodingError.self) {
            try StatusModel.fromJSONString(#"{"id": "1", "status": 1}"#)
        }
        #expect(throws: DecodingError.self) {
            try LevelModel.fromJSONString(#"{"level": "1"}"#)
        }
    }
    
    
    // MARK: - 編碼
    
    
    @Test("編碼回原本的 rawValue")
    func testEncode() throws {
        let status = try StatusModel.fromJSONString(#"{"id": "1", "status": "2"}"#).toJSONString(output: [.sortedKeys])
        let level = try LevelModel.fromJSONString(#"{"level": 2}"#).toJSONString(output: [.sortedKeys])
        
        #expect(status.contains(#""status":"2""#))
        #expect(level.contains(#""level":2"#))
    }
    
    
    @Test("退回 fallback 後原始值不會被保留")
    func testEncodeAfterFallback() throws {
        let json = try StatusModel.fromJSONString(#"{"id": "1", "status": "99"}"#).toJSONString(output: [.sortedKeys])
        
        #expect(json.contains(#""status":"unknown""#))
    }
    
    
}
