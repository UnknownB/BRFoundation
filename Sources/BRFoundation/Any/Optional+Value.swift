//
//  Optional+Value.swift
//  BRFoundation
//
//  Created by BR on 2025/12/24.
//

import Foundation

public extension BRWrapper where Base: BROptionalType {
    
    
    /// 當 optional 為 nil 時，回傳預設值，並在走 default 時印出指定的 log 訊息
    ///
    /// ```swift
    /// let value = optional.br.or(.zero, missing: "Missing value")
    /// ```
    func or(_ defaultValue: @autoclosure () -> Base.Wrapped, missing log: String? = nil) -> Base.Wrapped {
        if let value = base.value {
            return value
        }
        
        if let log = log {
            #BRLog(.core, .error, log)
        }
        
        return defaultValue()
    }
    
    
}
