//
//  BRRegex.swift
//  BRFoundation
//
//  Created by BR on 2026/6/11.
//

import Foundation


public enum BRRegex {
    
    public static func make(pattern: String) -> NSRegularExpression {
        do {
            return try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        } catch {
            assertionFailure("[BRRegex] 錯誤的正規表示法: \(pattern)")
            return try! NSRegularExpression(pattern: "a^", options: [])
        }
    }

    /// 電子郵件格式
    public static let email = make(pattern: #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#)
    
    /// 台灣身分證字號
    public static let taiwanID = make(pattern: #"([A-Z][12])(\d{5})(\d{3})"#)
    
    /// 台灣手機號碼
    public static let taiwanPhone = make(pattern: #"09\d{2}[-]?\d{3}[-]?\d{3}"#)
    
    /// 基礎的 CLI 指令偵測
    public static let basicCLI = make(pattern: #"(?i)([;&|]+\s*(ls|cat|rm|mv|cp|chmod|chown|touch|curl|wget|sh|bash)\b)"#)

    /// 基礎的 SQL 語法偵測
    public static let basicSQL = make(pattern: ##"(?i)(['"]\s*(or|and)\s+\d+\s*=\s*\d+|\bunion\s+select\b|\bdrop\s+table\b|\binsert\s+into\b)"##)

    /// 基礎的 XML 偵測
    public static let basicXML = make(pattern: #"(?i)(<!DOCTYPE|<!ENTITY|<\?xml)"#)

    /// 基礎的 JavaScript 語法偵測
    public static let basicJavaScript = make(pattern: #"(?i)(<!--|<script\b|javascript:|\bon(?:error|click|load|mouseover)\s*=)"#)

    /// Local File 存取偵測
    public static let localFile = make(pattern: #"(?i)(\.\./|\.\.\\|/etc/passwd|/etc/shadow|/proc/self|file://)"#)

    /// Format String 偵測
    public static let formatString = make(pattern: #"(?:%[A-Za-z]){2,}"#)
    
    /// 資訊安全檢測特殊字串
    public static let securityTest = make(pattern: #"(?i)\b\w+\s+&\s*del\s+\w+\b"#)
}
