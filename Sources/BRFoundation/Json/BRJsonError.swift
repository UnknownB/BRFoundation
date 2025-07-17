//
//  BRJsonError.swift
//  BRFoundation
//
//  Created by BR on 2025/7/5.
//

import Foundation


public enum BRJsonError: Error, LocalizedError {
    case invalidFormat
    case missingKey(String)
    case invalidType(key: String, expected: BRAnyType, actual: BRAnyType)
    
    public var errorDescription: String? {
        switch self {
        case .invalidFormat:
            return "json format is invalid"
        case .missingKey(let key):
            return "missing key: \(key)"
        case .invalidType(let key, let expected, let actual):
            return "invalid type for key: \(key), expected: \(expected), actual: \(actual)"
        }
    }
}
