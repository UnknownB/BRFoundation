//
//  BRJsonValue.swift
//  BRFoundation
//
//  Created by BR on 2026/11/10.
//

import Foundation


/// BRJSONValue 會將 JSON 的回傳值解析成宣告的型別，當解析失敗時 fallback 到型別預設值
///
/// ```swift
/// @BRJSONValue var count: Int = 0
/// @BRJSONValue var isEnable: Bool = false
/// @BRJSONValue var expiredOn: Date? = nil
/// ```
@propertyWrapper
public struct BRJSONValue<Value: BRJSONFallbackValue>: Codable {
    
    public var wrappedValue: Value
    
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        guard let value = Value.brDecode(container) else {
            #BRLog(.io, .error, "\(container.codingPath.map(\.stringValue).joined(separator: ".")) decode failed: \(Value.self), fallback to: \(Value.fallback)")
            wrappedValue = Value.fallback
            return
        }
        
        wrappedValue = value
    }
    
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.brEncode(to: encoder)
    }
    
}


extension BRJSONValue: Equatable where Value: Equatable {}
extension BRJSONValue: Hashable where Value: Hashable {}
extension BRJSONValue: Sendable where Value: Sendable {}


public extension KeyedDecodingContainer {
    
    /// 當 key 不存在或值為 null 時退回型別預設值
    func decode<Value>(_ type: BRJSONValue<Value>.Type, forKey key: Key) throws -> BRJSONValue<Value> {
        try decodeIfPresent(type, forKey: key) ?? BRJSONValue(wrappedValue: Value.fallback)
    }
    
}


public extension KeyedEncodingContainer {
    
    /// Optional 的欄位為 nil 時不輸出 key，與未包裝時編碼出相同的 JSON
    mutating func encode<Value: BRJSONFallbackValue & BRJSONOptionalValue>(_ value: BRJSONValue<Value>, forKey key: Key) throws {
        guard !value.wrappedValue.brIsNil else {
            return
        }
        try value.wrappedValue.brEncode(to: superEncoder(forKey: key))
    }
    
}


// MARK: - Protocol


/// JSON 寬鬆解析型別，嘗試解析 JSON 可能型別，失敗時回傳 nil
public protocol BRJSONDecodableValue: Codable {
    static func brDecode(_ container: SingleValueDecodingContainer) -> Self?
    func brEncode(to encoder: Encoder) throws
}


public extension BRJSONDecodableValue {
    
    func brEncode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self)
    }
}


/// JSON Fallback 包裝值，當 JSON 解析失敗時會 Fallback 中性預設值
public protocol BRJSONFallbackValue: BRJSONDecodableValue {
    static var fallback: Self { get }
}


/// JSON Optional 包裝值，當值為 nil 時不會邊碼進 JSON
public protocol BRJSONOptionalValue {
    var brIsNil: Bool { get }
}


// MARK: - 支援型別


extension Bool: BRJSONFallbackValue {
    
    public static var fallback: Bool { false }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> Bool? {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int.self) {
            return value != 0
        }
        guard let value = try? container.decode(String.self) else {
            return nil
        }
        switch value.lowercased() {
        case "1", "true", "yes":
            return true
        case "0", "false", "no", "":
            return false
        default:
            return nil
        }
    }
}


extension Int: BRJSONFallbackValue {
    
    public static var fallback: Int { 0 }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> Int? {
        if let value = try? container.decode(Int.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return Int(exactly: value)
        }
        guard let value = try? container.decode(String.self) else {
            return nil
        }
        return Int(value)
    }
}


extension Double: BRJSONFallbackValue {
    
    public static var fallback: Double { 0 }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> Double? {
        if let value = try? container.decode(Double.self) {
            return value
        }
        guard let value = try? container.decode(String.self), let number = Double(value), number.isFinite else {
            return nil
        }
        return number
    }
}


extension Float: BRJSONFallbackValue {
    
    public static var fallback: Float { 0 }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> Float? {
        if let value = try? container.decode(Float.self) {
            return value
        }
        guard let value = try? container.decode(String.self), let number = Float(value), number.isFinite else {
            return nil
        }
        return number
    }
}


extension String: BRJSONFallbackValue {
    
    public static var fallback: String { "" }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> String? {
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decode(Int.self) {
            return String(value)
        }
        if let value = try? container.decode(Double.self) {
            return String(value)
        }
        return nil
    }
}


extension Date: BRJSONDecodableValue {
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> Date? {
        if let date = try? container.decode(Date.self) {
            return date
        }
        guard let text = try? container.decode(String.self) else {
            return nil
        }
        if let date = BRDateFormatter.iso8601MsFormatter.date(from: text) {
            return date
        }
        if let date = BRDateFormatter.iso8601Formatter.date(from: text) {
            return date
        }
        return BRDateFormatter.mySQLFormatter.date(from: text)
    }
}


extension URL: BRJSONDecodableValue {
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> URL? {
        guard let value = try? container.decode(String.self) else {
            return nil
        }
        return URL(string: value)
    }
}


extension Array: BRJSONDecodableValue, BRJSONFallbackValue where Element: Codable {
    
    public static var fallback: [Element] { [] }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> [Element]? {
        try? container.decode([Element].self)
    }
}


extension Optional: BRJSONDecodableValue, BRJSONFallbackValue, BRJSONOptionalValue where Wrapped: BRJSONDecodableValue {
    
    public static var fallback: Wrapped? { nil }
    
    public var brIsNil: Bool { self == nil }
    
    public func brEncode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        guard let value = self else {
            try container.encodeNil()
            return
        }
        try container.encode(value)
    }
    
    public static func brDecode(_ container: SingleValueDecodingContainer) -> Wrapped?? {
        if container.decodeNil() {
            return .some(nil)
        }
        guard let value = Wrapped.brDecode(container) else {
            return nil
        }
        return .some(value)
    }
}
