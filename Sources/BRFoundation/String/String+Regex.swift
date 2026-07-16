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


    /// 移除基礎注入攻擊樣式
    func removingBasicInjectionPatterns() -> String {
        let regexes: [NSRegularExpression] = [
            BRRegex.basicCLI,
            BRRegex.basicSQL,
            BRRegex.basicXML,
            BRRegex.basicJavaScript,
            BRRegex.formatString,
            BRRegex.localFile,
            BRRegex.securityTest,
        ]

        var result = base
        for regex in regexes {
            let range = NSRange(result.startIndex..<result.endIndex, in: result)
            result = regex.stringByReplacingMatches(in: result, options: [], range: range, withTemplate: "")
        }
        return result
    }

}
