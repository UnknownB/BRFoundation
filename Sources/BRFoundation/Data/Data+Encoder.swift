//
//  Data+Encoder.swift
//  BRFoundation
//
//  Created by BR on 2026/5/8.
//

import Foundation
import CryptoKit


public extension BRWrapper where Base == Data {
    
    
    /// 將 Data 轉換為 MD5 十六進制字串，僅用於確保資訊一致性 (非安全加密用)
    var md5: String {
        let digest = Insecure.MD5.hash(data: base)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    
    /// 將 Data 轉換為 SHA256 十六進制字串
    var sha256: String {
        let digest = SHA256.hash(data: base)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    
    /// AES-GCM 加密
    func aesGCMEncrypt(key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.seal(base, using: key)
        guard let combined = sealedBox.combined else {
            throw BRFileError.encryptionFailed
        }
        return combined
    }
    
    
    /// AES-GCM 解密
    func aesGCMDecrypt(key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: base)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    
    /// AES-GCM 解密
    func aesGCMDecryptString(key: SymmetricKey) throws -> String? {
        let sealedBox = try AES.GCM.SealedBox(combined: base)
        let data = try AES.GCM.open(sealedBox, using: key)
        return String(data: data, encoding: .utf8)
    }
    

}
