//
//  URL+Query.swift
//
//
//  Created by BR on 2024/12/10.
//

import Foundation

public extension BRWrapper where Base == URL {
    
    
    /// 在 URL 上追加查詢參數
    ///
    ///     let url = URL(string: "https://example.com")!
    ///     let newUrl = url.br.appendingQuery(key: "key", value: "value")!
    ///     print(newUrl) // "https://example.com?key=value"
    ///
    /// - Parameters:
    ///   - key: 查詢參數的名稱
    ///   - value: 查詢參數的值
    /// - Returns: 帶有新查詢參數的 URL
    func appendingQuery(key: String, value: String) -> URL? {
        guard var components = URLComponents(url: base, resolvingAgainstBaseURL: false) else {
            return nil
        }
        var queryItems = components.queryItems ?? []
        let queryValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        queryItems.append(URLQueryItem(name: key, value: queryValue))
        components.queryItems = queryItems
        return components.url
    }
    
    
    /// 使用字典批量追加查詢參數
    ///
    ///     let url = URL(string: "https://example.com")!
    ///     let newUrl = url.br.appendingQuery(from: ["key1": "value1", "key2": "value2"])
    ///     print(newUrl) // "https://example.com?key1=value1&key2=value2"
    ///
    /// - Parameter query: 查詢參數的字典
    /// - Returns: 帶有新查詢參數的 URL
    func appendingQuery(from query: [String: String]) -> URL? {
        guard var components = URLComponents(url: base, resolvingAgainstBaseURL: false) else {
            return nil
        }
        var queryItems = components.queryItems ?? []
        
        for (key, value) in query {
            let queryValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            queryItems.append(URLQueryItem(name: key, value: queryValue))
        }
        
        components.queryItems = queryItems
        return components.url
    }
    
    
    /// 獲取 URL 的查詢參數字典
    ///
    ///     let url = URL(string: "https://example.com?key=value&another=1")!
    ///     let queryDict = url.br.decodedQueryParameters()
    ///     print(queryDict) // ["key": "value", "another": "1"]
    ///
    /// - Returns: 查詢參數的字典
    func decodedQueryParameters() -> [String: String] {
        guard let components = URLComponents(url: base, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return [:]
        }
        
        return queryItems.reduce(into: [String: String]()) { dict, item in
            dict[item.name] = item.value?.removingPercentEncoding ?? item.value
        }
    }
    
    
}
