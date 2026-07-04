//
//  BRAnyValue.swift
//  BRFoundation
//
//  Created by BR on 2025/7/5.
//

import Foundation


/// `BRAnyValue` 是用於包裝 `Any?` 型別的通用結構體，提供快速的型別辨識功能
public struct BRAnyValue {
    public let value: Any?
    
    public var type: BRAnyType {
        switch value {
        case is Int: return .int
        case is Double: return .double
        case is String: return .string
        case is Bool: return .bool
        case is Date: return .date
        case is [Any]: return .array
        case is [String: Any]: return .dictionary
        default: return .unknown
        }
    }
    
    public init(_ value: Any?) {
        self.value = value
    }
}


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
