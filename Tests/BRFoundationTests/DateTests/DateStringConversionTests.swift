//
//  DateStringConversionTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/21.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Date <-> String Conversion")
struct DateStringConversionTests {
    
    
    @Test("ISO 8601")
    func testISO8601Conversion() throws {
        let original = "2025-04-21T22:12:00Z"
        let date = Date.br.fromISO8601String(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).iso8601String() == original)
    }

    
    @Test("ISO 8601 + Milliseconds")
    func testISO8601MsConversion() throws {
        let original = "2025-04-21T22:12:00.123Z"
        let date = Date.br.fromISO8601MsString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).iso8601MsString() == original)
    }

    
    @Test("RFC 3339")
    func testRFC3339Conversion() throws {
        let original = "2025-04-21T22:12:00+00:00"
        let date = Date.br.fromRfc3339String(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).rfc3339String() == "2025-04-21T22:12:00Z")
    }
    
    
    @Test("Local YMD Dash")
    func testLocalYMDDashConversion() throws {
        let original = "2025-04-21"
        let date = Date.br.fromLocalYMDDashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localYMDDashString() == original)
    }
    
    
    @Test("Local YMD Slash")
    func testLocalYMDSlashConversion() throws {
        let original = "2025/04/21"
        let date = Date.br.fromLocalYMDSlashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localYMDSlashString() == original)
    }
    
    
    @Test("Local MD Dash")
    func testLocalMDDashConversion() throws {
        let original = "04-21"
        let date = Date.br.fromLocalMDDashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localMDDashString() == original)
    }
    
    
    @Test("Local MD Slash")
    func testLocalMDSlashConversion() throws {
        let original = "04/21"
        let date = Date.br.fromLocalMDSlashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localMDSlashString() == original)
    }

    
    @Test("Local YMDHm Slash")
    func testLocalYMDHmSlashConversion() throws {
        let original = "2025/04/21 18:30"
        let date = Date.br.fromLocalYMDHmSlashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localYMDHmSlashString() == original)
    }

    
    @Test("Local YMDHms Slash")
    func testLocalYMDHmsSlashConversion() throws {
        let original = "2025/04/21 18:30:45.123"
        let date = Date.br.fromLocalYMDHmsSlashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localYMDHmsSlashString() == original)
    }

    
    @Test("Loacl Hms")
    func testLoaclHmsConversion() throws {
        let original = "18:30:45"
        let date = Date.br.fromLocalHmsString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localHmsString() == original)
    }
    
    
    @Test("Local Hm")
    func testLocalHmConversion() throws {
        let original = "18:30"
        let date = Date.br.fromLocalHmString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localHmString() == original)
    }
    
    
    @Test("Loacl Weekday")
    func testLoaclWeekdayConversion() throws {
        let original = "2025/04/21 18:30"
        let date = Date.br.fromLocalYMDHmSlashString(original)
        #expect(date != nil)
        #expect(BRWrapper(date!).localWeekdayString() == "一")
    }
    
    
}
