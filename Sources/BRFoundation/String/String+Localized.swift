//
//  String+Localized.swift
//  BRFoundation
//
//  Created by BR on 2026/6/24.
//

import Foundation

public extension BRWrapper where Base == String {

    
    /// 轉換為本地化字串
    public var localized: String {
       return NSLocalizedString(base, comment: "")
    }

    
}
