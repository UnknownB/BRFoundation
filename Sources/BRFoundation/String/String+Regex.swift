//
//  String+Regex.swift
//  BRFoundation
//
//  Created by BR on 2026/6/11.
//

import Foundation

public extension BRWrapper where Base == String {

    
    /// 檢查字串是否符合特定的 NSRegularExpression
    func matches(_ regex: NSRegularExpression) -> Bool {
        let range = NSRange(base.startIndex..<base.endIndex, in: base)
        return regex.firstMatch(in: base, options: [], range: range) != nil
    }
    
    
}
