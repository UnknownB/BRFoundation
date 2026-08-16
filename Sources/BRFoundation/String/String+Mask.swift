//
//  String+Mask.swift
//  BRFoundation
//
//  Created by BR on 2026/8/7.
//

import Foundation


public extension BRWrapper where Base == String {


    /// 遮蔽字串部分資訊
    ///
    /// - Parameters:
    ///     - keep: 開頭與結尾保留的字元數
    ///     - mask: 替換後的遮蔽字串
    ///
    /// 當字元數不夠時，將確保至少遮蔽2個字元
    func masking(keep: Int = 3, mask: String = "***") -> String {
        if base.count < 4 {
            return mask
        }
        let keep = min(keep, (base.count - 2) / 2)
        return "\(base.prefix(keep))\(mask)\(base.suffix(keep))"
    }
    

}
