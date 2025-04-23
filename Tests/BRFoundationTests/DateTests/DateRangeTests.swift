//
//  DateRangeTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation
import Testing
@testable import BRFoundation


struct DateRangeTests {

    
    @Test("Start and end of day")
    func testStartAndEndOfDay() throws {
        let original = "2025/01/01 18:30:45.123"
        let date = Date.br.fromLocalYMDHmsSlashString(original)!
        let startOfDay = date.br.startOfDay()
        let endOfDay = date.br.endOfDay()
        
        #expect(startOfDay.br.localYMDHmsSlashString() == "2025/01/01 00:00:00.000")
        #expect(endOfDay.br.localYMDHmsSlashString() == "2025/01/02 00:00:00.000")
    }

    
    @Test("Start and end of week")
    func testStartAndEndOfWeek() throws {
        let original = "2025/01/01 18:30:45.123"
        let date = Date.br.fromLocalYMDHmsSlashString(original)!
        let startOfWeek = date.br.startOfWeek()
        let endOfWeek = date.br.endOfWeek()
        
        #expect(startOfWeek.br.localYMDHmsSlashString() == "2024/12/29 00:00:00.000")
        #expect(endOfWeek.br.localYMDHmsSlashString() == "2025/01/05 00:00:00.000")
    }
    
    
    @Test("Start and end of month")
    func testStartAndEndOfMonth() throws {
        let original = "2025/01/01 18:30:45.123"
        let date = Date.br.fromLocalYMDHmsSlashString(original)!
        let startOfMonth = date.br.startOfMonth()
        let endOfMonth = date.br.endOfMonth()
        
        #expect(startOfMonth.br.localYMDHmsSlashString() == "2025/01/01 00:00:00.000")
        #expect(endOfMonth.br.localYMDHmsSlashString() == "2025/02/01 00:00:00.000")
    }
    
    
    @Test("Start and end of year")
    func testStartAndEndOfYear() throws {
        let original = "2025/01/01 18:30:45.123"
        let date = Date.br.fromLocalYMDHmsSlashString(original)!
        let startOfYear = date.br.startOfYear()
        let endOfYear = date.br.endOfYear()
        
        #expect(startOfYear.br.localYMDHmsSlashString() == "2025/01/01 00:00:00.000")
        #expect(endOfYear.br.localYMDHmsSlashString() == "2026/01/01 00:00:00.000")
    }
    
}
