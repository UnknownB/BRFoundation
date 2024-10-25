//
//  Array+Remove.swift
//  
//
//  Created by BR on 2022/2/15.
//

import Foundation

extension Array where Element: Equatable {
    
    
    /// 刪除陣列中第一個指定的元素
    ///
    ///     var array = [1, 2, 3, 2, 4]
    ///     array.removeFirstOccurrence(of: 2)
    ///     print(array) // "[1, 3, 2, 4]"
    ///
    /// - Parameter value: 陣列元素
    public mutating func removeFirstOccurrence(of value: Element) {
        if let index = self.firstIndex(of: value) {
            self.remove(at: index)
        }
    }
    
    
}
