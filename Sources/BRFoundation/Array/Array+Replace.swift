//
//  Array+Replace.swift
//  
//
//  Created by BR on 2024/10/23.
//

import Foundation

extension Array {
    
    
    /// 將所有滿足條件的元素替換成新元素
    ///
    ///      var array = [1,2,1]
    ///
    ///      array.replaceAll(where: { $0 == 1 }, with: 2)
    ///      print(array) // [2,2,2]
    ///
    /// - Parameters:
    ///   - predicate: 等式條件
    ///   - newValue: 新元素
    public mutating func replaceAll(where predicate: (Element) -> Bool, with newValue: Element) {
        var startIndex = self.startIndex
        
        while let index = self[startIndex...].firstIndex(where: predicate) {
            self[index] = newValue
            startIndex = self.index(after: index)
        }
    }
    
    
}
