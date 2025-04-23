//
//  DateCalculationsTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation
import Testing
@testable import BRFoundation


struct DateOperationsTests {

    
    @Test("Date adding operations")
    func testAddingUnits() throws {
        let original = "2025-01-01T00:00:00Z"
        let date = Date.br.fromISO8601String(original)!
        #expect(date.br.adding(seconds: 1).br.iso8601String() == "2025-01-01T00:00:01Z")
        #expect(date.br.adding(seconds: -1).br.iso8601String() == "2024-12-31T23:59:59Z")
        #expect(date.br.adding(minutes: 1).br.iso8601String() == "2025-01-01T00:01:00Z")
        #expect(date.br.adding(hours: 1).br.iso8601String() == "2025-01-01T01:00:00Z")
        #expect(date.br.adding(days: 1).br.iso8601String() == "2025-01-02T00:00:00Z")
        #expect(date.br.adding(days: 1).br.iso8601String() == "2025-01-02T00:00:00Z")
        #expect(date.br.adding(weeks: 1).br.iso8601String() == "2025-01-08T00:00:00Z")
        #expect(date.br.adding(months: 1).br.iso8601String() == "2025-02-01T00:00:00Z")
        #expect(date.br.adding(years: 1).br.iso8601String() == "2026-01-01T00:00:00Z")
    }
    
    
}
