//
//  BRJsonCodable.swift
//  BRFoundation
//
//  Created by BR on 2025/6/16.
//

import Foundation


public protocol BRJSONCodable: Codable {
    func toJSONData(output: JSONEncoder.OutputFormatting, date: JSONEncoder.DateEncodingStrategy) throws -> Data
    func toJSONString(output: JSONEncoder.OutputFormatting, date: JSONEncoder.DateEncodingStrategy) throws -> String
    static func fromJSONData(_ data: Data, date: JSONDecoder.DateDecodingStrategy) throws -> Self
    static func fromJSONString(_ jsonString: String, date: JSONDecoder.DateDecodingStrategy) throws -> Self
}


public extension BRJSONCodable {
    
    
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
    func toJSONData(output: JSONEncoder.OutputFormatting = [], date: JSONEncoder.DateEncodingStrategy = .deferredToDate) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = output
        encoder.dateEncodingStrategy = date
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
    func toJSONString(output: JSONEncoder.OutputFormatting = [.prettyPrinted], date: JSONEncoder.DateEncodingStrategy = .deferredToDate) throws -> String {
        let data = try toJSONData(output: output, date: date)
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
    static func fromJSONData(_ data: Data, date: JSONDecoder.DateDecodingStrategy = .deferredToDate) throws -> Self {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = date
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
    static func fromJSONString(_ jsonString: String, date: JSONDecoder.DateDecodingStrategy = .deferredToDate) throws -> Self {
        guard let data = jsonString.data(using: .utf8) else {
            throw NSError(domain: "JSONDecoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "無法將字串轉為 Data"])
        }
        return try fromJSONData(data, date: date)
    }
    
    
}
