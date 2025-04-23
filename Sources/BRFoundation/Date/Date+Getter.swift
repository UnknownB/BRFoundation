//
//  Date+Getter.swift
//  BRFoundation
//
//  Created by BR on 2025/4/23.
//

import Foundation


public extension BRWrapper where Base == Date {
    
    
    func second(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.second, from: base)
    }
    
    
    func minute(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.minute, from: base)
    }
    
    
    func hour(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.hour, from: base)
    }
    
    
    func day(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.day, from: base)
    }

    
    func weekOfYear(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.weekOfYear, from: base)
    }

    
    func month(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.month, from: base)
    }

    
    func year(calendar: Calendar = BRDateConfig.calendar) -> Int {
        calendar.component(.year, from: base)
    }
    
    
}
