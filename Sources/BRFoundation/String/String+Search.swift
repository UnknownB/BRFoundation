//
//  String+Search.swift
//  
//
//  Created by BR on 2024/10/26.
//

import Foundation

public extension BRWrapper where Base == String {

    
    /// 搜尋符合 `head`...`end` 的字串，成功時獲得 `head`...`end` 字串
    ///
    /// ```swift
    /// let testString = "Start [head] content [end] remaining"
    /// let result = testString.br.find(head: "[head]", end: "[end]")
    ///
    /// print(result.matchedSubstring) // "[head] content [end]"
    /// print(result.afterEndSubstring) // " remaining"
    /// ```
    ///
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
    
    
    /// 搜尋符合 `head`...`end` 的字串，成功時獲得 `...` 字串
    ///
    /// ```swift
    /// let testString = "<a href=http...</a></div>"
    ///
    /// let result = testString.br.findBetween(head: "<a href=", end: "</a>")
    ///
    /// print(result.matchedSubstring) // "http..."
    /// print(result.afterEndSubstring) // "</div>"
    /// ```
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
