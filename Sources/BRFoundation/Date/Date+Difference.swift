//
//  Date+Difference.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation


public extension BRWrapper where Base == Date {
    
    
    /// 回傳 self 到指定日期相差幾天（只要跨日就算一天）
    func toDays(_ date: Date, calendar: Calendar = BRDateConfig.calendar) -> Int {
        let start = base.br.startOfDay(calendar: calendar)
        let end = date.br.startOfDay(calendar: calendar)
        return calendar.dateComponents([.day], from: start, to: end).day!
    }
    

    /// 回傳 self 到指定日期相差幾週（只要跨週就算一週）
    func toWeeks(_ date: Date, calendar: Calendar = BRDateConfig.calendar) -> Int? {
        let start = base.br.startOfWeek(calendar: calendar)
        let end = date.br.startOfWeek(calendar: calendar)
        return calendar.dateComponents([.weekOfYear], from: start, to: end).weekOfYear!
    }
    

    /// 回傳 self 到指定日期相差幾月（只要跨月就算一月）
    func toMonths(_ date: Date, calendar: Calendar = BRDateConfig.calendar) -> Int? {
        let start = base.br.startOfMonth(calendar: calendar)
        let end = date.br.startOfMonth(calendar: calendar)
        return calendar.dateComponents([.month], from: start, to: end).month!
    }
    

    /// 回傳 self 到指定日期相差幾年（只要跨年就算一年）
    func toYears(_ date: Date, calendar: Calendar = BRDateConfig.calendar) -> Int? {
        let start = base.br.startOfYear(calendar: calendar)
        let end = date.br.startOfYear(calendar: calendar)
        return calendar.dateComponents([.year], from: start, to: end).year!
    }
    
    
}
