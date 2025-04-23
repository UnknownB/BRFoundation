//
//  Date+Operations.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation


public extension BRWrapper where Base == Date {
    
    
    func adding(seconds: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .second, value: seconds, to: base)!
    }

    
    func adding(minutes: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .minute, value: minutes, to: base)!
    }
    

    func adding(hours: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .hour, value: hours, to: base)!
    }

    
    func adding(days: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .day, value: days, to: base)!
    }

    
    func adding(weeks: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .weekOfYear, value: weeks, to: base)!
    }

    
    func adding(months: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .month, value: months, to: base)!
    }

    
    func adding(years: Int, calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.date(byAdding: .year, value: years, to: base)!
    }
    
    
}
