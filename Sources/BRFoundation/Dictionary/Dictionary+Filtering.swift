//
//  Dictionary+Filtering.swift
//  BRFoundation
//
//  Created by BR on 2025/6/14.
//

import Foundation

public extension BRWrapper where Base: BRDictionaryProtocol {

    
    /// 篩選符合條件的 key
    ///
    /// ```swift
    /// let original: [String: Int] = [
    ///     "apple": 3,
    ///     "banana": 5,
    ///     "cherry": 2,
    ///     "date": 7
    /// ]
    ///
    /// // 範例 1
    /// let filtered = original.br.filterKeys { $0.hasPrefix("b") }
    /// print(filtered) // ["banana": 5]
    ///
    /// // 範例 2
    /// let result = try original.br.filterKeys { key in
    ///     if key == "banana" {
    ///         throw NSError(domain: "Test", code: 999)
    ///     }
    ///     return true
    /// }
    /// ```
    func filterKeys(_ isIncluded: (Base.Key) throws -> Bool) rethrows -> [Base.Key: Base.Value] {
        var result: [Base.Key: Base.Value] = [:]
        for (key, value) in base {
            if try isIncluded(key) {
                result[key] = value
            }
        }
        return result
    }
    

    /// 篩選符合條件的 value
    ///
    /// ```swift
    /// let scores: [String: Int] = [
    ///     "Alice": 85,
    ///     "Bob": 92,
    ///     "Charlie": 76,
    ///     "Diana": 88
    /// ]
    ///
    /// let passed = scores.br.filterValues { $0 >= 80 }
    ///
    /// // 結果
    /// print(passed)  // ["Alice": 85, "Bob": 92, "Diana": 88]
    /// ```
    func filterValues(_ isIncluded: (Base.Value) throws -> Bool) rethrows -> [Base.Key: Base.Value] {
        var result: [Base.Key: Base.Value] = [:]
        for (key, value) in base {
            if try isIncluded(value) {
                result[key] = value
            }
        }
        return result
    }
    
    
    /// 篩選能轉換成指定類型的 key-value
    ///
    /// ```swift
    /// let raw: [AnyHashable: Any] = [
    ///     "id": 1001,
    ///     "name": "Alice",
    ///     42: "Should be removed",
    ///     "active": true
    /// ]
    ///
    /// // 將 Dictionary 中可轉為 String -> String 的項目挑出來
    /// let stringToString = raw.br.filterAsType<String, String>()
    /// // ["name": "Alice"]
    /// ```
    func filterAsType<K, V>() -> [K: V] {
        var result: [K: V] = [:]
        for (key, value) in base {
            if let k = key as? K, let v = value as? V {
                result[k] = v
            }
        }
        return result
    }
    
    
}
