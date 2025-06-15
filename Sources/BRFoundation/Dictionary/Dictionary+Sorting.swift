//
//  Dictionary+Sorting.swift
//  BRFoundation
//
//  Created by BR on 2025/6/14.
//

import Foundation

public extension BRWrapper where Base: BRDictionaryProtocol {
        

    /// 根據 value 排序，回傳排序後的陣列 (key, value)
    ///
    /// ```swift
    /// let scores: [String: Int] = [
    ///     "Alice": 95,
    ///     "Bob": 80,
    ///     "Charlie": 88
    /// ]
    ///
    /// let sorted = scores.br.sortedByValue(<)
    ///
    /// for (name, score) in sorted {
    ///     print("\(name): \(score)")
    ///     // [Bob: 80]
    ///     // [Charlie: 88]
    ///     // [Alice: 95]
    /// }
    /// ```
    func sortedByValue(_ areInIncreasingOrder: (Base.Value, Base.Value) throws -> Bool) rethrows -> [(Base.Key, Base.Value)] {
        return try base.sorted { try areInIncreasingOrder($0.value, $1.value) }
    }
    

    /// 根據 key 排序，回傳排序後的陣列 (key, value)
    ///
    /// ```swift
    /// let scores: [String: Int] = [
    ///     "Charlie": 88
    ///     "Alice": 95,
    ///     "Bob": 80,
    /// ]
    ///
    /// let sorted = scores.br.sortedByKey(<)
    ///
    /// for (name, score) in sorted {
    ///     print("\(name): \(score)")
    ///     // [Alice: 95]
    ///     // [Bob: 80]
    ///     // [Charlie: 88]
    /// }
    /// ```
    func sortedByKey(_ areInIncreasingOrder: (Base.Key, Base.Key) throws -> Bool) rethrows -> [(Base.Key, Base.Value)] {
        return try base.sorted { try areInIncreasingOrder($0.key, $1.key) }
    }
    
        
}
