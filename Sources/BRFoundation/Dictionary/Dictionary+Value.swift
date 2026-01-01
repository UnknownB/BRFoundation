//
//  Dictionary+Value.swift
//  BRFoundation
//
//  Created by BR on 2025/12/24.
//

import Foundation

public extension BRWrapper where Base: BRDictionaryProtocol {
        

    /// 依 key 取值並轉型，失敗時回傳預設值，並在遺失資料時印 log
    ///
    /// - Parameter missingLog: 當 key 不存在或型別不符、走 default 時要印的 log 訊息
    func value<T>(for key: Base.Key, or defaultValue: @autoclosure () -> T, missing log: String? = nil) -> T {
        if let value = base[key] as? T {
            return value
        } else {
            if let log = log {
                #BRLog(.core, .error, log)
            }
            return defaultValue()
        }
    }
    
        
}
