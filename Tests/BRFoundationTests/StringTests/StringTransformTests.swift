//
//  StringTransformTests.swift
//  BRFoundation
//
//  Created by BR on 2025/7/18.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("StringTransformTests")
struct StringTransformTests {
    
    
    @Test("Int")
    func testInt() throws {
        let str1: String = "123"
        let str2: String? = "123"
        let str3: String? = "abc"
        let int1: Int? = str1.br.intValue
        let int2: Int? = str2.br.intValue
        let int3: Int? = str3.br.intValue
        
        #expect(int1 == 123)
        #expect(int2 == 123)
        #expect(int3 == nil)
    }
    
    
    @Test("Float")
    func testFloat() throws {
        let str1: String = "123.45"
        let str2: String? = "123.45"
        let str3: String? = "abc"
        let float1: Float? = str1.br.floatValue
        let float2: Float? = str2.br.floatValue
        let float3: Float? = str3.br.floatValue
        
        #expect(float1 == 123.45)
        #expect(float2 == 123.45)
        #expect(float3 == nil)
    }
    
    
    @Test("Double")
    func testDouble() throws {
        let str1: String = "123.45"
        let str2: String? = "123.45"
        let str3: String? = "abc"
        let double1: Double? = str1.br.doubleValue
        let double2: Double? = str2.br.doubleValue
        let double3: Double? = str3.br.doubleValue
        
        #expect(double1 == 123.45)
        #expect(double2 == 123.45)
        #expect(double3 == nil)
    }
    
    
    @Test("Bool")
    func testBool() throws {
        let str1: String = "1"
        let str2: String? = "true"
        let str3: String? = "false"
        let bool1: Bool? = str1.br.boolValue
        let bool2: Bool? = str2.br.boolValue
        let bool3: Bool? = str3.br.boolValue
        
        #expect(bool1 == true)
        #expect(bool2 == true)
        #expect(bool3 == false)
    }
    
    
    @Test("URL")
    func testURL() throws {
        let str1: String = "https://www.google.com"
        let str2: String? = "https://www.google.com"
        let str3: String? = "abc"
        let url1: URL? = str1.br.urlValue
        let url2: URL? = str2.br.urlValue
        let url3: URL? = str3.br.urlValue
        
        #expect(url1?.absoluteString == "https://www.google.com")
        #expect(url2?.absoluteString == "https://www.google.com")
        #expect(url3?.absoluteString == "abc")
    }
    
    
    @Test("Date")
    func testDate() throws {
        let str1: String = "2020-01-01T00:00:00Z"
        let str2: String? = "2025-07-17 01:04:04"
        let str3: String? = "abc"
        let date1: Date? = str1.br.asDate(formatter: BRDateFormatter.iso8601Formatter)
        let date2: Date? = str2.br.asDate(formatter: BRDateFormatter.mySQLFormatter)
        let date3: Date? = str3.br.asDate(formatter: BRDateFormatter.iso8601Formatter)
        
        #expect(date1 != nil)
        #expect(date2 != nil)
        #expect(date3 == nil)
    }
    
}
