//
//  Dictionary+Query.swift
//  BRFoundation
//
//  Created by BR on 2025/6/14.
//

import Foundation

public extension BRWrapper where Base: BRDictionaryProtocol {

    
    /// 查詢是否包含指定 key
    ///
    /// ```swift
    /// let userInfo: [String: Any] = [
    ///     "name": "Alice",
    ///     "age": 30,
    ///     "isMember": true
    /// ]
    /// let hasAge = userInfo.br.containsKey("age")
    /// let hasEmail = userInfo.br.containsKey("email")
    ///
    /// print(hasAge)   // true
    /// print(hasEmail) // false
    /// ```
    func containsKey(_ key: Base.Key) -> Bool {
        return base[key] != nil
    }
    
    
}
