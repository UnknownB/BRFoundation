//
//  BRJsonCodable.swift
//  BRFoundation
//
//  Created by BR on 2025/6/16.
//

import Foundation


protocol BRJSONCodable: Codable {
    func toJSONData() throws -> Data
    func toJSONString() throws -> String
    static func fromJSONData(_ data: Data) throws -> Self
    static func fromJSONString(_ jsonString: String) throws -> Self
}


extension BRJSONCodable {
    
    
    /// 轉換成 Json data
    ///
    /// ```swift
    /// struct User: BRJSONCodable, Equatable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let user = User(id: 1, name: "BR")
    /// let data = try user.toJSONData()
    /// ```
    func toJSONData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
    
    /// 轉換成 Json String
    ///
    /// ```swift
    /// struct User: BRJSONCodable, Equatable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let user = User(id: 1, name: "BR")
    /// let data = try user.toJSONString()
    /// ```
    func toJSONString() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // 格式化排版
        let data = try encoder.encode(self)
        guard let string = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "Encoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "無法轉為字串"])
        }
        return string
    }
    
    
    /// 從 Json data 轉換成物件
    ///
    /// ```swift
    /// struct User: BRJSONCodable, Equatable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let user = try User.fromJSONData()
    /// ```
    static func fromJSONData(_ data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
    
    
    /// 從 Json String 轉換成物件
    ///
    /// ```swift
    /// struct User: BRJSONCodable, Equatable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let user = try User.fromJSONString()
    /// ```
    static func fromJSONString(_ jsonString: String) throws -> Self {
        guard let data = jsonString.data(using: .utf8) else {
            throw NSError(domain: "JSONDecoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "無法將字串轉為 Data"])
        }
        return try fromJSONData(data)
    }
    
    
}
