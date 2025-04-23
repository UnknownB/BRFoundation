//
//  DateDifferenceTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("Date difference tests")
struct DateDifferenceTests {
    
    
    @Test("Date difference - Days")
    func testDaysDifference() throws {
        let date1 = DateComponents(calendar: .current, year: 2025, month: 4, day: 21, hour: 23).date!
        let date2 = DateComponents(calendar: .current, year: 2025, month: 4, day: 22, hour: 0).date!
        
        let diff = date1.br.toDays(date2)
        #expect(diff == 1)
    }
    

    @Test("Date difference - Weeks")
    func testWeeksDifference() throws {
        let date1 = DateComponents(calendar: .current, year: 2025, month: 4, day: 19).date!
        let date2 = DateComponents(calendar: .current, year: 2025, month: 4, day: 24).date!
        
        let diff = date1.br.toWeeks(date2)
        #expect(diff == 1)
    }

    
    @Test("Date difference - Months")
    func testMonthsDifference() throws {
        let date1 = DateComponents(calendar: .current, year: 2025, month: 3, day: 30).date!
        let date2 = DateComponents(calendar: .current, year: 2025, month: 6, day: 1).date!
        
        let diff = date1.br.toMonths(date2)
        #expect(diff == 3)
    }
    

    @Test("Date difference - Years")
    func testYearsDifference() throws {
        let date1 = DateComponents(calendar: .current, year: 2022, month: 12, day: 21).date!
        let date2 = DateComponents(calendar: .current, year: 2025, month: 4, day: 21).date!
        
        let diff = date1.br.toYears(date2)
        #expect(diff == 3)
    }
    
    
}
