//
//  BRJsonValueTests.swift
//  BRFoundation
//
//  Created by BR on 2026/11/11.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("BRJsonValueTests")
struct BRJsonValueTests {
    
    
    struct Model: BRJSONCodable, Equatable {
        @BRJSONValue var bool: Bool = false
        @BRJSONValue var int: Int = 0
        @BRJSONValue var double: Double = 0
        @BRJSONValue var float: Float = 0
        @BRJSONValue var string: String = ""
        @BRJSONValue var date: Date? = nil
        @BRJSONValue var url: URL? = nil
    }
    
    
    struct Plain: BRJSONCodable, Equatable {
        var bool: Bool = false
        var int: Int = 0
        var double: Double = 0
        var float: Float = 0
        var string: String = ""
        var date: Date? = nil
        var url: URL? = nil
    }
    
    
    struct OptionalModel: BRJSONCodable, Equatable {
        @BRJSONValue var flag: Bool? = nil
    }
    
    
    struct IntArrayModel: BRJSONCodable, Equatable {
        let ints: [BRJSONValue<Int>]
    }
    
    
    struct OptionalArrayModel: BRJSONCodable, Equatable {
        let optionals: [BRJSONValue<Int?>]
    }
    
    
    struct NestedArrayModel: BRJSONCodable, Equatable {
        let models: [Model]
    }
    
    
    struct WrappedArrayModel: BRJSONCodable, Equatable {
        @BRJSONValue var list: [Int] = []
    }
    
    
    struct DateArrayModel: BRJSONCodable, Equatable {
        @BRJSONValue var dates: [Date] = []
    }
    
    
    // MARK: - 型別轉換
    
    
    @Test("Bool")
    func testBool() throws {
        #expect(try Model.fromJSONString(#"{"bool": true}"#).bool == true)
        #expect(try Model.fromJSONString(#"{"bool": 1}"#).bool == true)
        #expect(try Model.fromJSONString(#"{"bool": 2}"#).bool == true)
        #expect(try Model.fromJSONString(#"{"bool": "1"}"#).bool == true)
        #expect(try Model.fromJSONString(#"{"bool": "true"}"#).bool == true)
        #expect(try Model.fromJSONString(#"{"bool": "YES"}"#).bool == true)
        
        #expect(try Model.fromJSONString(#"{"bool": false}"#).bool == false)
        #expect(try Model.fromJSONString(#"{"bool": 0}"#).bool == false)
        #expect(try Model.fromJSONString(#"{"bool": "0"}"#).bool == false)
        #expect(try Model.fromJSONString(#"{"bool": "false"}"#).bool == false)
        #expect(try Model.fromJSONString(#"{"bool": "no"}"#).bool == false)
        #expect(try Model.fromJSONString(#"{"bool": ""}"#).bool == false)
        #expect(try Model.fromJSONString(#"{"bool": "maybe"}"#).bool == false)
    }
    
    
    @Test("Int")
    func testInt() throws {
        #expect(try Model.fromJSONString(#"{"int": 42}"#).int == 42)
        #expect(try Model.fromJSONString(#"{"int": -42}"#).int == -42)
        #expect(try Model.fromJSONString(#"{"int": "42"}"#).int == 42)
        #expect(try Model.fromJSONString(#"{"int": 42.0}"#).int == 42)
        
        #expect(try Model.fromJSONString(#"{"int": 1.5}"#).int == 0)
        #expect(try Model.fromJSONString(#"{"int": "1.5"}"#).int == 0)
        #expect(try Model.fromJSONString(#"{"int": "abc"}"#).int == 0)
        #expect(try Model.fromJSONString(#"{"int": true}"#).int == 0)
    }
    
    
    @Test("Double")
    func testDouble() throws {
        #expect(try Model.fromJSONString(#"{"double": 1.5}"#).double == 1.5)
        #expect(try Model.fromJSONString(#"{"double": 2}"#).double == 2)
        #expect(try Model.fromJSONString(#"{"double": "1.5"}"#).double == 1.5)
        
        #expect(try Model.fromJSONString(#"{"double": "abc"}"#).double == 0)
        #expect(try Model.fromJSONString(#"{"double": "inf"}"#).double == 0)
        #expect(try Model.fromJSONString(#"{"double": "nan"}"#).double == 0)
        #expect(try Model.fromJSONString(#"{"double": true}"#).double == 0)
    }
    
    
    @Test("Float")
    func testFloat() throws {
        #expect(try Model.fromJSONString(#"{"float": 2.5}"#).float == 2.5)
        #expect(try Model.fromJSONString(#"{"float": "2.5"}"#).float == 2.5)
        
        #expect(try Model.fromJSONString(#"{"float": "abc"}"#).float == 0)
        #expect(try Model.fromJSONString(#"{"float": "inf"}"#).float == 0)
    }
    
    
    @Test("String")
    func testString() throws {
        #expect(try Model.fromJSONString(#"{"string": "BR"}"#).string == "BR")
        #expect(try Model.fromJSONString(#"{"string": 42}"#).string == "42")
        #expect(try Model.fromJSONString(#"{"string": 1.5}"#).string == "1.5")
        
        #expect(try Model.fromJSONString(#"{"string": true}"#).string == "")
    }
    
    
    @Test("Date")
    func testDate() throws {
        let mySQL = BRDateFormatter.mySQLFormatter.date(from: "2025-07-17 01:04:04")
        let iso8601 = BRDateFormatter.iso8601Formatter.date(from: "2025-04-21T22:12:00Z")
        let iso8601Ms = BRDateFormatter.iso8601MsFormatter.date(from: "2025-04-21T22:12:00.123Z")
        
        #expect(try Model.fromJSONString(#"{"date": "2025-07-17 01:04:04"}"#).date == mySQL)
        #expect(try Model.fromJSONString(#"{"date": "2025-04-21T22:12:00Z"}"#).date == iso8601)
        #expect(try Model.fromJSONString(#"{"date": "2025-04-21T22:12:00.123Z"}"#).date == iso8601Ms)
        #expect(try Model.fromJSONString(#"{"date": 774407044}"#).date == mySQL)
        
        #expect(try Model.fromJSONString(#"{"date": "2025/07/17"}"#).date == nil)
        #expect(try Model.fromJSONString(#"{"date": true}"#).date == nil)
    }
    
    
    @Test("URL")
    func testURL() throws {
        #expect(try Model.fromJSONString(#"{"url": "https://example.com"}"#).url == URL(string: "https://example.com"))
        #expect(try Model.fromJSONString(#"{"url": "https://a.b/c?d=1"}"#).url == URL(string: "https://a.b/c?d=1"))
        
        #expect(try Model.fromJSONString(#"{"url": 123}"#).url == nil)
    }
    
    
    // MARK: - 取不到值
    
    
    /// brDecode 只在「key 存在且有值」時才會被呼叫，fallback 的 error log 才不會被常態噪音淹沒
    struct Probe: BRJSONFallbackValue, Equatable {
        var touched: Bool
        
        static var fallback: Probe { Probe(touched: false) }
        
        static func brDecode(_ container: SingleValueDecodingContainer) -> Probe? {
            Probe(touched: true)
        }
    }
    
    
    struct ProbeModel: BRJSONCodable, Equatable {
        @BRJSONValue var value: Probe = .fallback
    }
    
    
    @Test("缺 key 與 null 不會進入 brDecode")
    func testFallbackPathIsolation() throws {
        #expect(try ProbeModel.fromJSONString("{}").value.touched == false)
        #expect(try ProbeModel.fromJSONString(#"{"value": null}"#).value.touched == false)
        
        #expect(try ProbeModel.fromJSONString(#"{"value": 1}"#).value.touched == true)
        #expect(try ProbeModel.fromJSONString(#"{"value": "x"}"#).value.touched == true)
    }
    
    
    @Test("缺 key 退回預設值")
    func testMissingKey() throws {
        let model = try Model.fromJSONString("{}")
        
        #expect(model == Model())
    }
    
    
    @Test("值為 null 退回預設值")
    func testNull() throws {
        let json = #"{"bool": null, "int": null, "double": null, "float": null, "string": null, "date": null, "url": null}"#
        let model = try Model.fromJSONString(json)
        
        #expect(model == Model())
    }
    
    
    @Test("單一欄位解析失敗不影響其他欄位")
    func testPartialFailure() throws {
        let model = try Model.fromJSONString(#"{"int": "abc", "string": "ok"}"#)
        
        #expect(model.int == 0)
        #expect(model.string == "ok")
    }
    
    
    @Test("Optional 可以分辨缺 key 與 false")
    func testOptionalValue() throws {
        #expect(try OptionalModel.fromJSONString("{}").flag == nil)
        #expect(try OptionalModel.fromJSONString(#"{"flag": null}"#).flag == nil)
        #expect(try OptionalModel.fromJSONString(#"{"flag": "maybe"}"#).flag == nil)
        #expect(try OptionalModel.fromJSONString(#"{"flag": "0"}"#).flag == false)
        #expect(try OptionalModel.fromJSONString(#"{"flag": "1"}"#).flag == true)
    }
    
    
    // MARK: - 陣列
    
    
    @Test("陣列元素一樣會做型別轉換")
    func testArrayElement() throws {
        let model = try IntArrayModel.fromJSONString(#"{"ints": [1, "2", 3.0]}"#)
        
        #expect(model.ints.map(\.wrappedValue) == [1, 2, 3])
    }
    
    
    @Test("陣列中解析失敗的元素退回預設值")
    func testArrayElementFallback() throws {
        let model = try IntArrayModel.fromJSONString(#"{"ints": [1, "abc", 3]}"#)
        
        #expect(model.ints.map(\.wrappedValue) == [1, 0, 3])
    }
    
    
    @Test("陣列中的 null 元素")
    func testArrayNullElement() throws {
        let ints = try IntArrayModel.fromJSONString(#"{"ints": [1, null]}"#)
        let optionals = try OptionalArrayModel.fromJSONString(#"{"optionals": [1, null]}"#)
        
        #expect(ints.ints.map(\.wrappedValue) == [1, 0])
        #expect(optionals.optionals.map(\.wrappedValue) == [1, nil])
    }
    
    
    @Test("陣列元素的 nil 會編碼成 null")
    func testArrayNullElementEncode() throws {
        let model = try OptionalArrayModel.fromJSONString(#"{"optionals": [1, null]}"#)
        let json = try model.toJSONString(output: [.sortedKeys])
        
        #expect(json.contains(#""optionals":[1,null]"#))
    }
    
    
    @Test("陣列中單一元素的欄位壞掉不影響其他元素")
    func testArrayOfModels() throws {
        let json = #"{"models": [{"int": "1", "string": "a"}, {"int": "abc"}, {"int": 3}]}"#
        let model = try NestedArrayModel.fromJSONString(json)
        
        #expect(model.models.map(\.int) == [1, 0, 3])
        #expect(model.models.map(\.string) == ["a", "", ""])
    }
    
    
    @Test("陣列本身缺 key 會解析失敗")
    func testArrayMissingKey() throws {
        #expect(throws: DecodingError.self) {
            try IntArrayModel.fromJSONString("{}")
        }
    }
    
    
    @Test("包起來的陣列取不到值時退回空陣列")
    func testWrappedArrayFallback() throws {
        #expect(try WrappedArrayModel.fromJSONString("{}").list == [])
        #expect(try WrappedArrayModel.fromJSONString(#"{"list": null}"#).list == [])
        #expect(try WrappedArrayModel.fromJSONString(#"{"list": {}}"#).list == [])
        #expect(try WrappedArrayModel.fromJSONString(#"{"list": []}"#).list == [])
    }
    
    
    @Test("包起來的陣列正常解析")
    func testWrappedArray() throws {
        #expect(try WrappedArrayModel.fromJSONString(#"{"list": [1, 2, 3]}"#).list == [1, 2, 3])
    }
    
    
    @Test("包起來的陣列只要一個元素型別不符就整包退回空陣列")
    func testWrappedArrayElementMismatch() throws {
        #expect(try WrappedArrayModel.fromJSONString(#"{"list": [1, "2", 3]}"#).list == [])
    }
    
    
    @Test("陣列中的 Date 跟著 date 參數走")
    func testDateArray() throws {
        let date = BRDateFormatter.mySQLFormatter.date(from: "2025-07-17 01:04:04")
        
        #expect(try DateArrayModel.fromJSONString(#"{"dates": [774407044]}"#).dates == [date])
        #expect(try DateArrayModel.fromJSONString(#"{"dates": [1752714244]}"#, date: .secondsSince1970).dates == [date])
        #expect(try DateArrayModel.fromJSONString(#"{"dates": ["2025-07-17T01:04:04Z"]}"#, date: .iso8601).dates == [date])
    }
    
    
    @Test("陣列中的 Date 編碼跟著 date 參數走")
    func testDateArrayEncode() throws {
        let model = try DateArrayModel.fromJSONString(#"{"dates": [774407044]}"#)
        
        #expect(try model.toJSONString(output: [.sortedKeys]).contains(#""dates":[774407044]"#))
        #expect(try model.toJSONString(output: [.sortedKeys], date: .secondsSince1970).contains(#""dates":[1752714244]"#))
        #expect(try model.toJSONString(output: [.sortedKeys], date: .iso8601).contains(#""dates":["2025-07-17T01:04:04Z"]"#))
        #expect(try DateArrayModel.fromJSONString(model.toJSONString()) == model)
    }
    
    
    @Test("包起來的陣列編碼結果與未包裝時相同")
    func testWrappedArrayEncode() throws {
        struct PlainArray: BRJSONCodable {
            var list: [Int] = []
        }
        
        let empty = try WrappedArrayModel().toJSONString(output: [.sortedKeys])
        let filled = try WrappedArrayModel.fromJSONString(#"{"list": [1, 2]}"#).toJSONString(output: [.sortedKeys])
        
        #expect(empty == (try PlainArray().toJSONString(output: [.sortedKeys])))
        #expect(filled == (try PlainArray(list: [1, 2]).toJSONString(output: [.sortedKeys])))
    }
    
    
    // MARK: - 編碼
    
    
    @Test("編碼結果與未包裝時相同")
    func testEncodeMatchesPlain() throws {
        let empty = try Model().toJSONString(output: [.sortedKeys])
        let filled = try Model.fromJSONString(#"{"bool": "1", "int": "42", "string": "BR", "url": "https://example.com"}"#).toJSONString(output: [.sortedKeys])
        
        var plain = Plain()
        #expect(empty == (try plain.toJSONString(output: [.sortedKeys])))
        
        plain.bool = true
        plain.int = 42
        plain.string = "BR"
        plain.url = URL(string: "https://example.com")
        #expect(filled == (try plain.toJSONString(output: [.sortedKeys])))
    }
    
    
    @Test("Date 編碼跟著 date 參數走")
    func testEncodeDate() throws {
        let model = try Model.fromJSONString(#"{"date": "2025-07-17 01:04:04"}"#)
        
        #expect(try model.toJSONString(output: [.sortedKeys]).contains(#""date":774407044"#))
        #expect(try model.toJSONString(output: [.sortedKeys], date: .secondsSince1970).contains(#""date":1752714244"#))
        #expect(try model.toJSONString(output: [.sortedKeys], date: .iso8601).contains(#""date":"2025-07-17T01:04:04Z""#))
    }
    
    
    @Test("補上的字串格式不需要 SDK 的 coder")
    func testExtraFormatsWorkWithPlainDecoder() throws {
        let date = BRDateFormatter.mySQLFormatter.date(from: "2025-07-17 01:04:04")
        let formats = [
            #"{"date": "2025-07-17 01:04:04"}"#,
            #"{"date": "2025-07-17T01:04:04Z"}"#,
            #"{"date": "2025-07-17T01:04:04.000Z"}"#,
        ]
        
        for json in formats {
            let data = json.data(using: .utf8)!
            
            #expect(try JSONDecoder().decode(Model.self, from: data).date == date)
            #expect(try Model.fromJSONData(data).date == date)
        }
    }
    
    
    @Test("秒數跟著 date 參數走")
    func testSecondsFollowsStrategy() throws {
        let date = BRDateFormatter.mySQLFormatter.date(from: "2025-07-17 01:04:04")
        
        #expect(try Model.fromJSONString(#"{"date": 774407044}"#).date == date)
        #expect(try Model.fromJSONString(#"{"date": 1752714244}"#, date: .secondsSince1970).date == date)
        #expect(try Model.fromJSONString(#"{"date": 1752714244000}"#, date: .millisecondsSince1970).date == date)
        
        let data = #"{"date": 774407044}"#.data(using: .utf8)!
        #expect(try JSONDecoder().decode(Model.self, from: data).date == date)
    }
    
    
    @Test("編碼後可以還原")
    func testRoundTrip() throws {
        let json = #"{"bool": "1", "int": "42", "double": "1.5", "float": "2.5", "string": 7, "date": "2025-07-17 01:04:04", "url": "https://example.com"}"#
        let model = try Model.fromJSONString(json)
        let decoded = try Model.fromJSONString(model.toJSONString())
        
        #expect(model == decoded)
    }
    
    
}
