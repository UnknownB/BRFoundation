//
//  BRKeychain.swift
//  BRFoundation
//
//  Created by BR on 2025/10/1.
//

import Foundation
import Security


public enum BRKeychainError: Error, LocalizedError {
    case duplicateItem
    case itemNotFound
    case invalidData
    case unexpectedStatus(OSStatus)
    
    public static func status(from status: OSStatus) -> BRKeychainError {
        switch status {
        case errSecDuplicateItem: return .duplicateItem
        case errSecItemNotFound: return .itemNotFound
        default: return .unexpectedStatus(status)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .duplicateItem: return "Duplicate item"
        case .itemNotFound: return "Item not found"
        case .invalidData: return "Invalid data"
        case .unexpectedStatus(let status):
            if let cfString = SecCopyErrorMessageString(status, nil) {
               return cfString as String
            }
            return "Unexpected status: \(status)"
        }
    }
}


/// BRKeychain 封裝鑰匙圈的操作功能
public class BRKeychain {
    
    
    /// 封裝 kSecAttrAccessible 存取級別
    public enum AccessControl {
        
        /// 裝置解鎖後即可存取
        case whenUnlocked
        
        /// 首次解鎖後，即使裝置鎖定也可存取
        case afterFirstUnlock
        
        /// 只有裝置設定密碼後才能存取，且不能備份到 iCloud/電腦 (高安全性)。
        case whenPasscodeSetThisDeviceOnly
        
        /// 只有裝置解鎖時才能存取，且不能備份到 iCloud/電腦 (最高限制級別)。
        case whenUnlockedThisDeviceOnly
        
        internal var rawValue: CFString {
            switch self {
            case .whenUnlocked:
                return kSecAttrAccessibleWhenUnlocked
            case .afterFirstUnlock:
                return kSecAttrAccessibleAfterFirstUnlock
            case .whenPasscodeSetThisDeviceOnly:
                return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            case .whenUnlockedThisDeviceOnly:
                return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            }
        }
    }
    
    
    /// 鑰匙圈的存取值的 Key
    public struct Account: Hashable, Equatable, RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(stringLiteral value: String) {
            self.rawValue = value
        }
                
        public static func custom(for token: String) -> Account {
            return Account(rawValue: token)
        }
    }
    
    private let service: String?
    private let accessGroup: String?
    
    
    public init(service: String? = Bundle.main.bundleIdentifier, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
    
    
    /// 構建基礎查詢字典 (加入可選的存取控制級別)
    private func baseQuery(for account: Account) -> [String: Any] {
        var query = [String: Any]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service
        query[kSecAttrAccount as String] = account.rawValue
        query[kSecAttrAccessGroup as String] = accessGroup

        return query
    }
    

    /// 儲存 data 到指定的 account
    public func save(data: Data?, for account: Account, accessControl: AccessControl = .afterFirstUnlock) throws {
        try delete(for: account)
        
        guard let data else { return }
        
        var query = baseQuery(for: account)
        query[kSecValueData as String] = data
        query[kSecAttrAccessible as String] = accessControl.rawValue
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw BRKeychainError.status(from: status)
        }
    }
    

    /// 取得指定的 account 的 data
    public func get(for account: Account) throws -> Data {
        var query = baseQuery(for: account)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            throw BRKeychainError.status(from: status)
        }
        
        guard let data = item as? Data else {
            throw BRKeychainError.invalidData
        }
        
        return data
    }
    

    /// 刪除指定的 account
    public func delete(for account: Account) throws {
        let query = baseQuery(for: account)
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecItemNotFound || status == errSecSuccess {
            return
        }
        
        throw BRKeychainError.status(from: status)
    }
    
    
    /// 查詢指定的 account 是否存在
    public func contains(account: Account) -> Bool {
        var query = baseQuery(for: account)
        query[kSecReturnData as String] = kCFBooleanFalse
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    
}
