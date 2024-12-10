//
//  Array+Remove.swift
//  
//
//  Created by BR on 2022/2/15.
//

import Foundation

public extension BRWrapper where Base: RangeReplaceableCollection, Base.Element: Equatable {
    
    
    /// 刪除陣列中第一個指定的元素
    ///
    ///     let array = [1, 2, 3, 2, 4]
    ///     let newArray = array.br.removingFirstOccurrence(of: 2)
    ///     print(newArray) // "[1, 3, 2, 4]"
    ///
    /// - Parameter value: 陣列元素
    func removingFirstOccurrence(of value: Base.Element) -> Base {
        var array = base
        if let index = array.firstIndex(of: value) {
            array.remove(at: index)
        }
        return array
    }

    
}
