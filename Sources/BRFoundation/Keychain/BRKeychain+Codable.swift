//
//  BRKeychain+Codable.swift
//  BRFoundation
//
//  Created by BR on 2026/5/13.
//

import Foundation


extension BRKeychain {
    
    
    /// 儲存字串到鑰匙圈
    public func saveString(_ string: String?, for account: Account, accessControl: AccessControl = .afterFirstUnlock) throws {
        let data = string?.data(using: .utf8)
        try save(data: data, for: account, accessControl: accessControl)
    }

    
    /// 從鑰匙圈讀取字串
    public func getString(for account: Account) throws -> String {
        let data = try get(for: account)
        
        guard let string = String(data: data, encoding: .utf8) else {
            throw BRKeychainError.invalidData
        }
        return string
    }
    
    
    /// 儲存任何遵循 Codable 協定的物件到鑰匙圈
    public func saveObject<T: Codable>(_ object: T?, for key: Account, accessControl: AccessControl = .afterFirstUnlock) throws {
        do {
            let data = try object.map { try JSONEncoder().encode($0) }
            try save(data: data, for: key, accessControl: accessControl)
        } catch {
            throw error
        }
    }
    
    
    /// 從鑰匙圈讀取並解碼為指定的 Codable 物件
    public func getObject<T: Codable>(of type: T.Type, for key: Account) throws -> T {
        let data = try get(for: key)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
    
}
