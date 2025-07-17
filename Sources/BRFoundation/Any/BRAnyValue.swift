//
//  BRAnyValue.swift
//  BRFoundation
//
//  Created by BR on 2025/7/5.
//

import Foundation


/// 與 BRAnyType 搭配，用來比對 Any 型別
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
