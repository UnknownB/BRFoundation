//
//  BRRegex.swift
//  BRFoundation
//
//  Created by BR on 2026/6/11.
//

import Foundation


public enum BRRegex {
    
    private static func make(pattern: String) -> NSRegularExpression {
        do {
            return try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        } catch {
            assertionFailure("[BRRegex] 錯誤的正規表示法: \(pattern)")
            return try! NSRegularExpression(pattern: "a^", options: [])
        }
    }

    /// 電子郵件格式
    public static let email = make(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    
    /// 台灣身分證字號
    public static let taiwanID = make(pattern: "([A-Z][12])(\\d{5})(\\d{3})")
    
    /// 台灣手機號碼
    public static let taiwanPhone = make(pattern: "(09\\d{2})[-]?(\\d{3})[-]?(\\d{3})")
}
