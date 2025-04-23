//
//  String+Search.swift
//  
//
//  Created by BR on 2024/10/26.
//

import Foundation

public extension BRWrapper where Base == String {

    
    /// 查找第一個被 `head` 和 `end` 包裹的子字串，並返回該子字串與 `end` 之後的剩餘字串
    ///
    ///     let testString = "Start [head] content [end] remaining"
    ///     let result = testString.br.find(head: "[head]", end: "[end]")
    ///
    ///     print(result.matchedSubstring) // "[head] content [end]"
    ///     print(result.afterEndSubstring) // " remaining"
    ///
    /// - Parameters:
    ///   - head: 起始的字串標記
    ///   - end: 結尾的字串標記
    /// - Returns: matched: (matched 字串, end 後的字串), not matched: (nil, 原始字串)
    func find(head: String, end: String) -> (matchedSubstring: String, afterEndSubstring: String)? {
        guard let headRange = base.range(of: head) else {
            return nil
        }
        let substringAfterHead = base[headRange.upperBound...]
        
        guard let endRange = substringAfterHead.range(of: end) else {
            return nil
        }
        
        // 提取從 head 到 end 的子字串 [head...end]
        let matchedSubstring = String(base[headRange.lowerBound..<endRange.upperBound])
        
        // 提取 end 後的部分
        let afterEndSubstring = String(substringAfterHead[endRange.upperBound...])
        
        return (matchedSubstring, afterEndSubstring)
    }
    
    
    /// 在字符串中查找從 `head` 到 `end` 之間的子字符串
    ///
    ///     let testString = "<a href=http...</a></div>"
    ///
    ///     let result = testString.br.findBetween(head: "<a href=", end: "</a>")
    ///
    ///     print(result.matchedSubstring) // "http..."
    ///     print(result.afterEndSubstring) // "</div>"
    ///
    /// - Parameters:
    ///   - head: 起始的字串標記
    ///   - end: 結尾的字串標記
    /// - Returns: matched: (matched 之間的字串, end 後的字串), not matched: nil
    func findBetween(head: String, end: String) -> (matchedSubstring: String, afterEndSubstring: String)? {
        guard let headRange = base.range(of: head) else {
            return nil
        }
        let substringAfterStart = base[headRange.upperBound...]
        
        guard let endRange = substringAfterStart.range(of: end) else { 
            return nil
        }
        
        // 獲取 head 和 end 之間的內容, head[...]end
        let matchedSubstring = String(base[headRange.upperBound..<endRange.lowerBound])
        
        // 獲取 end 後的內容
        let afterEndSubstring = String(substringAfterStart[endRange.upperBound...])
        
        return (matchedSubstring, afterEndSubstring)
    }
    
}
