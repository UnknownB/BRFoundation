//
//  BRJsonEnumCodable.swift
//  BRFoundation
//
//  Created by BR on 2026/11/9.
//

import Foundation


/// 讓 rawValue 型別的 enum 遇到未知的值時，安全退回 `fallback` 避免 JSON 解析失敗
///
/// ```swift
/// enum Style: String, BRJSONEnumCodable {
///     case normal = "1"
///     case unknown
///
///     static let fallback = MatchType.unknown
/// }
/// ```
public protocol BRJSONEnumCodable: BRJSONCodable, RawRepresentable where RawValue: Codable {
    
    static var fallback: Self { get }
}


public extension BRJSONEnumCodable {
    
    
    init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(RawValue.self)
        
        guard let value = Self(rawValue: rawValue) else {
            #BRLog(.io, .error, "\(Self.self) decode failed: \(rawValue), fallback to: \(Self.fallback)")
            self = Self.fallback
            return
        }
        self = value
    }
    
}
