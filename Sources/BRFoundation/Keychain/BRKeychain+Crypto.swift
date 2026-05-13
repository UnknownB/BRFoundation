//
//  BRKeychain+Crypto.swift
//  BRFoundation
//
//  Created by BR on 2026/5/13.
//

import Foundation
import CryptoKit


public extension BRKeychain {
    
    
    /// 獲取或建立一個持久化的對稱金鑰 (AES-GCM 使用)
    func symmetricKey(for account: Account, accessControl: AccessControl = .whenUnlockedThisDeviceOnly) throws -> SymmetricKey {
        if let data = try? get(for: account) {
            return SymmetricKey(data: data)
        }
        
        let newKey = SymmetricKey(size: .bits256)
        let keyData = newKey.withUnsafeBytes { Data($0) }
        
        try save(data: keyData, for: account, accessControl: accessControl)
        return newKey
    }
    
    
    /// 獲取或建立一個持久化的唯一識別碼 (UUID)
    ///
    /// 常用於 Device ID 等需要在重新安裝或重置前保持不變的識別需求
    func persistentUUID(for account: Account, accessControl: AccessControl = .afterFirstUnlock) throws -> String {
        if let uuidString = try? getString(for: account) {
            return uuidString
        }
        
        let newUUID = UUID().uuidString
        try saveString(newUUID, for: account, accessControl: accessControl)
        return newUUID
    }
    
    
}
