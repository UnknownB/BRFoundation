//
//  String+Encoder.swift
//  BRFoundation
//
//  Created by BR on 2026/5/8.
//

import Foundation
import CryptoKit


public extension BRWrapper where Base == String {
    
    
    /// 將字串轉換為 MD5 (通常用於快取檔名)
    var md5: String {
        guard let data = base.data(using: .utf8) else { return base }
        return data.br.md5
    }
    
    
    /// 將字串轉換為 SHA256 (用於高安全性校驗)
    var sha256: String {
        guard let data = base.data(using: .utf8) else { return base }
        return data.br.sha256
    }
    
    
}
