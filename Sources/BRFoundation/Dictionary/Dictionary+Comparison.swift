//
//  Dictionary+Comparison.swift
//  BRFoundation
//
//  Created by BR on 2025/6/14.
//

import Foundation

public extension BRWrapper where Base: BRDictionaryProtocol, Base.Key: Equatable, Base.Value: Equatable {

    
    /// 判定另一個 dictionary 是否為此 dictionary 的子集合
    ///
    /// ```swift
    /// let dict = ["a": 1, "b": 2, "c": 3]
    /// let dictSub = ["a": 1, "b": 2]
    ///
    /// dict.br.contains(dictSub) // true
    /// dictSub.br.contains(dict) // false
    /// ```
    func contains(_ other: [Base.Key: Base.Value]) -> Bool {
        for (key, value) in other {
            if base[key] != value {
                return false
            }
        }
        return true
    }
    
    
    /// 判定是否為另一個 dictionary 的子集合
    ///
    /// ```swift
    /// let dict = ["a": 1, "b": 2, "c": 3]
    /// let dictSub = ["a": 1, "b": 2]
    ///
    /// dict.br.isSubset(of: dictSub) // false
    /// dictSub.br.isSubset(of: dict) // true
    /// ```
    func isSubset(of other: [Base.Key: Base.Value]) -> Bool {
        for (key, value) in base {
            if other[key] != value {
                return false
            }
        }
        return true
    }
    
    
}
