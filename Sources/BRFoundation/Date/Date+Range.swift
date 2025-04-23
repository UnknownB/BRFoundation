//
//  Date+Range.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation


public extension BRWrapper where Base == Date {
    
    
    /// 回傳指定日期的當天起始時間（00:00:00.000)
    func startOfDay(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.startOfDay(for: base)
    }
    
    
    /// 回傳指定日期的當天結束時間（隔天 00:00:00.000)
    func endOfDay(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .day, for: base)!.end
    }
    
    
    /// 回傳指定日期所屬週的起始時間（週日 00:00:00.000)
    func startOfWeek(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .weekOfYear, for: base)!.start
    }
    
    
    /// 回傳指定日期所屬週的結束時間（下週日 00:00:00.000)
    func endOfWeek(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .weekOfYear, for: base)!.end
    }
    
    
    /// 回傳指定日期所屬月的起始時間（月初 00:00:00.000)
    func startOfMonth(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .month, for: base)!.start
    }
    
    
    /// 回傳指定日期的當月結束時間（下個月初 00:00:00.000)
    func endOfMonth(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .month, for: base)!.end
    }
    
    
    /// 回傳指定日期所屬年的起始時間（年初 00:00:00.000)
    func startOfYear(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .year, for: base)!.start
    }
    
    
    /// 回傳指定日期的當年結束時間（明年初 00:00:00.000)
    func endOfYear(calendar: Calendar = BRDateConfig.calendar) -> Date {
        calendar.dateInterval(of: .year, for: base)!.end
    }
    
    
}
