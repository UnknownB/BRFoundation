//
//  BRAnyType.swift
//  BRFoundation
//
//  Created by BR on 2025/7/5.
//

import Foundation


/// 與 BRAnyValue 搭配，用來比對 Any 型別
public enum BRAnyType: CustomStringConvertible {
    case int
    case double
    case string
    case bool
    case date
    case array
    case dictionary
    case unknown
    
    public var description: String {
        switch self {
        case .int: return "Int"
        case .double: return "Double"
        case .string: return "String"
        case .bool: return "Bool"
        case .date: return "Date"
        case .array: return "Array"
        case .dictionary: return "Dictionary"
        case .unknown: return "Unknown"
        }
    }
}
