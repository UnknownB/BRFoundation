//
//  Date+Setter.swift
//  BRFoundation
//
//  Created by BR on 2025/4/23.
//

import Foundation


public extension BRWrapper where Base == Date {
    
    
    func settingSecond(_ second: Int, calendar: Calendar = BRDateConfig.calendar) -> Date? {
        var component = calendar.dateComponents(in: calendar.timeZone, from: base)
        component.second = second
        return calendar.date(from: component)
    }
    
    
    func settingMinute(_ minute: Int, calendar: Calendar = BRDateConfig.calendar) -> Date? {
        var component = calendar.dateComponents(in: calendar.timeZone, from: base)
        component.minute = minute
        return calendar.date(from: component)
    }
    
    
    func settingHour(_ hour: Int, calendar: Calendar = BRDateConfig.calendar) -> Date? {
        var component = calendar.dateComponents(in: calendar.timeZone, from: base)
        component.hour = hour
        return calendar.date(from: component)
    }

    
    func settingDay(_ day: Int, calendar: Calendar = BRDateConfig.calendar) -> Date? {
        var component = calendar.dateComponents(in: calendar.timeZone, from: base)
        component.day = day
        return calendar.date(from: component)
    }

    
    func settingMonth(_ month: Int, calendar: Calendar = BRDateConfig.calendar) -> Date? {
        var component = calendar.dateComponents(in: calendar.timeZone, from: base)
        component.month = month
        return calendar.date(from: component)
    }

    
    func settingYear(_ year: Int, calendar: Calendar = BRDateConfig.calendar) -> Date? {
        let diff = year - base.br.year(calendar: calendar)
        return base.br.adding(years: diff, calendar: calendar)
    }
    
    
}
