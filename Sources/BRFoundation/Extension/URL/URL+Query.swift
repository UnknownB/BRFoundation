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
    
    
}
