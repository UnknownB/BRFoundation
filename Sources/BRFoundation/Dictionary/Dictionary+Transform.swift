//
//  Dictionary+Transform.swift
//  BRFoundation
//
//  Created by BR on 2025/6/14.
//

import Foundation

public extension BRWrapper where Base: BRDictionaryProtocol {

    
    /// 對 Dictionary 的 key 做映射轉換，value 保留不變
    ///
    /// ```swift
    /// let raw = ["1001": "Alice", "1002": "Bob"]
    ///
    /// let transformed = raw.br.mapKeys { Int($0)! }
    /// // [1001: "Alice", 1002: "Bob"]
    /// ```
    func mapKeys<T: Hashable>(_ transform: (Base.Key) throws -> T) rethrows -> [T: Base.Value] {
        var result: [T: Base.Value] = [:]
        for (key, value) in base {
            result[try transform(key)] = value
        }
        return result
    }
    

    /// 對 Dictionary 的 value 做映射轉換，key 保留不變
    ///
    /// ```swift
    /// let raw: [String: String] = [
    ///     "Alice": "100",
    ///     "Bob": "200"
    /// ]
    ///
    /// let converted = raw.br.mapValues { Int($0)! }
    /// // ["Alice": 100, "Bob": 200]
    /// ```
    func mapValues<T>(_ transform: (Base.Value) throws -> T) rethrows -> [Base.Key: T] {
        var result: [Base.Key: T] = [:]
        for (key, value) in base {
            result[key] = try transform(value)
        }
        return result
    }
    
    
    /// 轉換成 String 型態的 Dictionary
    ///
    /// ```swift
    /// let raw: [AnyHashable: Any] = [
    ///     1: 100,
    ///     "name": "Alice",
    ///     3: true
    /// ]
    /// let stringDict = raw.br.toStringDictionary()
    /// print(stringDict) // ["1": "100", "name": "Alice", "3": "true"]
    /// ```
    func toStringDictionary() -> [String: String] {
        var result: [String: String] = [:]
        
        for (key, value) in base {
            let keyString = String(describing: key)
            let valueString = String(describing: value)
            result[keyString] = valueString
        }
        
        return result
    }



}
