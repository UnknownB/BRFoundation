//
//  Data+Encoder.swift
//  BRFoundation
//
//  Created by BR on 2026/5/8.
//

import Foundation
import CryptoKit


public extension BRWrapper where Base == Data {
    
    
    /// 將 Data 轉換為 MD5 十六進制字串
    var md5: String {
        let digest = Insecure.MD5.hash(data: base)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    
    /// 將 Data 轉換為 SHA256 十六進制字串
    var sha256: String {
        let digest = SHA256.hash(data: base)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    

}
