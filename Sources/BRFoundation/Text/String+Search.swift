//
//  String+Search.swift
//  
//
//  Created by BR on 2024/10/26.
//

import Foundation

extension String {
    
    
    /// 查找第一個被 `head` 和 `end` 包裹的子字串，並返回該子字串與 `end` 之後的剩餘字串
    ///
    ///     let testString = "Start [head] content [end] remaining"
    ///     let result = testString.find(head: "[head]", end: "[end]")
    ///
    ///     print(result.matchedSubstring) // "[head] content [end]"
    ///     print(result.afterEndSubstring) // " remaining"
    ///
    /// - Parameters:
    ///   - head: 起始的字串標記
    ///   - end: 結尾的字串標記
    ///
    /// - Returns: matched: (matched 字串, end 後的字串), not matched: (nil, 原始字串)
    public func find(head: String, end: String) -> (matchedSubstring: String?, afterEndSubstring: String) {
        // 找到 head 的範圍
        guard let headRange = self.range(of: head) else {
            return (nil, self)
        }
        
        // 查找 head 後面的部分
        let substringAfterHead = self[headRange.upperBound...]
        
        // 找到 end 的範圍
        guard let endRange = substringAfterHead.range(of: end) else {
            return (nil, self)
        }
        
        // 提取從 head 到 end 的子字串 [head...end]
        let matchedSubstring = String(self[headRange.lowerBound..<endRange.upperBound])
        
        // 提取 end 後的部分
        let afterEndSubstring = String(substringAfterHead[endRange.upperBound...])
        
        return (matchedSubstring, afterEndSubstring)
    }
    
    
    /// 在字符串中查找從 `head` 到 `end` 之間的子字符串
    ///
    ///     let testString = "Start [head] content [end] remaining"
    ///     let result = testString.find(head: "[head]", to: "[end]")
    ///
    ///     print(result.matchedSubstring) // "content"
    ///     print(result.afterEndSubstring) // " remaining"
    ///
    /// - Parameters:
    ///   - head: 起始的字串標記
    ///   - end: 結尾的字串標記
    /// - Returns: matched: (matched 之間的字串, end 後的字串), not matched: (nil, 原始字串)
    public func find(head: String, to end: String) -> (matchedSubstring: String?, afterEndSubstring: String) {
        // 找到 head 的範圍
        guard let headRange = self.range(of: head) else {
            return (nil, self)
        }
        
        // 查找 head 後面的部分
        let substringAfterHead = self[headRange.upperBound...]
        
        // 找到 end 的範圍
        guard let endRange = substringAfterHead.range(of: end) else {
            return (nil, self)
        }
        
        // 提取從 head 到 end 之間的字串 head[...]end
        let matchedSubstring = String(self[headRange.upperBound..<endRange.lowerBound])
        
        // 提取 end 後的部分
        let afterEndSubstring = String(substringAfterHead[endRange.upperBound...])
        
        return (matchedSubstring, afterEndSubstring)
    }
    
    
}
