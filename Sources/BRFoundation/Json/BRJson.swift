//
//  BRJson.swift
//  BRFoundation
//
//  Created by BR on 2025/7/5.
//

import Foundation


public enum BRJson {
    
    
    /// 將 JSON `Data` 解析為指定型別，並可選擇性驗證 Dictionary 內部欄位的資料型別
    ///
    /// ```swift
    /// let jsonString = """
    ///     {
    ///       "id" : 1,
    ///       "name" : "BR"
    ///     }
    ///     """
    /// let data = jsonString.data(using: .utf8)!
    /// let decoded: [String: Any] = try BRJson.parse(data, keys: [
    ///     "id": .int,
    ///     "name": .string
    /// ])
    /// ```
    public static func parse<T>(_ data: Data, keys: [String: BRAnyType]? = nil) throws -> T {
        guard let raw = try JSONSerialization.jsonObject(with: data) as? T else {
            throw BRJsonError.invalidFormat
        }
        
        if let dict = raw as? [String: Any] {
            for (key, expectedType) in keys ?? [:] {
                guard let value = dict[key] else {
                    throw BRJsonError.missingKey(key)
                }
                let actualType = BRAnyValue(value).type
                if actualType != expectedType {
                    throw BRJsonError.invalidType(key: key, expected: expectedType, actual: actualType)
                }
            }
        }
        return raw
    }
    
    
    /// 將 JSON 格式的字串解析成指定型別（如 [String]、[String: Any] 等）
    ///
    /// ```swift
    /// let json = "[\"a\", \"b\", \"c\"]"
    /// let array: [String] = try BRJson.parse(json)
    /// ```
    public static func parse<T>(_ jsonString: String) throws -> T {
        guard let data = jsonString.data(using: .utf8) else {
            throw BRJsonError.invalidFormat
        }
        return try parse(data)
    }
    
    
    /// 將 Array、Dictionary 類型轉換成 Data
    public static func data(with object: Any, options: JSONSerialization.WritingOptions = []) throws -> Data {
        try JSONSerialization.data(withJSONObject: object, options: options)
    }
    
    
    /// 將 Array、Dictionary 類型轉換成方便閱讀的 JSON 字串
    ///
    /// ```swift
    /// let user: [String: Any] = ["id": 1, "name": "BR"]
    /// let json = try BRJson.string(with: user)
    ///
    /// print(json)
    /// // {
    /// //   "id" : 1,
    /// //   "name" : "BR"
    /// // }
    /// ```
    @available(iOS 13.0, *)
    public static func string(with object: Any, options: JSONSerialization.WritingOptions = []) throws -> String {
        let data = try JSONSerialization.data(withJSONObject: object, options: [
            .prettyPrinted,
            .sortedKeys,
            .withoutEscapingSlashes
        ])
        return String(data: data, encoding: .utf8)!
    }

    
}
