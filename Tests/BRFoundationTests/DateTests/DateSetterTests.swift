//
//  DateSetterTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/23.
//

import Foundation
import Testing
@testable import BRFoundation


struct DateSetterTests {
    
    
    @Test("Date component setters")
    func testDateComponentSetters() throws {
        let original = "2025/04/21 18:30:45.123"
        let date = Date.br.fromLocalYMDHmsSlashString(original)!

        #expect(date.br.settingYear(2020)?.br.localYMDHmsSlashString() == "2020/04/21 18:30:45.123")
        #expect(date.br.settingMonth(12)?.br.localYMDHmsSlashString() == "2025/12/21 18:30:45.123")
        #expect(date.br.settingDay(1)?.br.localYMDHmsSlashString() == "2025/04/01 18:30:45.123")
        #expect(date.br.settingHour(0)?.br.localYMDHmsSlashString() == "2025/04/21 00:30:45.123")
        #expect(date.br.settingMinute(0)?.br.localYMDHmsSlashString() == "2025/04/21 18:00:45.123")
        #expect(date.br.settingSecond(0)?.br.localYMDHmsSlashString() == "2025/04/21 18:30:00.123")
    }
    
}
