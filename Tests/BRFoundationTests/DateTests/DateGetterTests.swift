//
//  DateGetterTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/23.
//

import Foundation
import Testing
@testable import BRFoundation


struct DateGetterTests {
    
    
    @Test("Date component getters")
    func testDateComponentGetters() throws {
        let date = Date.br.fromLocalYMDHmsSlashString("2025/04/21 15:30:45.123")!
        
        #expect(date.br.year() == 2025)
        #expect(date.br.month() == 4)
        #expect(date.br.day() == 21)
        #expect(date.br.hour() == 15)
        #expect(date.br.minute() == 30)
        #expect(date.br.second() == 45)
        #expect(date.br.weekOfYear() == 17)
    }
    
    
}
