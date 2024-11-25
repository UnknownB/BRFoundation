//
//  Array+Replace.swift
//  
//
//  Created by BR on 2024/10/23.
//

import Foundation


public extension BRWrapper where Base: RangeReplaceableCollection & MutableCollection {
    
    /// 將所有滿足條件的元素替換成新元素
    ///
    ///      let array = [1,2,1]
    ///      let newArray = array.br.replacingAll(where: { $0 == 1 }, with: 2)
    ///      print(newArray) // [2,2,2]
    ///
    /// - Parameters:
    ///   - predicate: 替換條件
    ///   - newValue: 新元素
    func replacingAll(where predicate: (Base.Element) -> Bool, with newValue: Base.Element) -> Base {
        var array = base
        var startIndex = array.startIndex
        while let index = array[startIndex...].firstIndex(where: predicate) {
            array[index] = newValue
            startIndex = array.index(after: index)
        }
        return array
    }
}
