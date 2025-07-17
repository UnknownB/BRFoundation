//
//  String+Transform.swift
//  BRFoundation
//
//  Created by BR on 2025/7/18.
//

import Foundation


public extension BRWrapper where Base == String {
    
    
    var intValue: Int? {
        Int(base)
    }
    
    
    var doubleValue: Double? {
        Double(base)
    }
    
    
    var floatValue: Float? {
        Float(base)
    }
    
    
    var boolValue: Bool {
        switch base.lowercased() {
        case "1", "true", "yes":
            return true
        default:
            return false
        }
    }
    
    
    var urlValue: URL? {
        URL(string: base)
    }
    
    
    func asDate(formatter: DateFormatter) -> Date? {
        formatter.date(from: base)
    }
    
    
    func asDate(formatter: ISO8601DateFormatter) -> Date? {
        formatter.date(from: base)
    }
    
    
}


public extension BRWrapper where Base == String? {
    
    
    var intValue: Int? {
        guard let base = base else {
            return nil
        }
        return Int(base)
    }
    
    
    var doubleValue: Double? {
        guard let base = base else {
            return nil
        }
        return Double(base)
    }
    
    
    var floatValue: Float? {
        guard let base = base else {
            return nil
        }
        return Float(base)
    }
    
    
    var boolValue: Bool {
        guard let base = base else {
            return false
        }
        switch base.lowercased() {
        case "1", "true", "yes":
            return true
        default:
            return false
        }
    }
    
    
    var urlValue: URL? {
        guard let base = base else {
            return nil
        }
        return URL(string: base)
    }
    
    
    func asDate(formatter: DateFormatter) -> Date? {
        guard let base = base else {
            return nil
        }
        return formatter.date(from: base)
    }
    
    
    func asDate(formatter: ISO8601DateFormatter) -> Date? {
        guard let base = base else {
            return nil
        }
        return formatter.date(from: base)
    }
    
    
}
