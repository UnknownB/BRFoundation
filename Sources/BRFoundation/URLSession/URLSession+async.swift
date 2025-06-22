//
//  URLSession+async.swift
//  BRFoundation
//
//  Created by BR on 2025/6/22.
//

import Foundation

public extension BRWrapper where Base: URLSession {
    
    
    /// 在 iOS 13+ 中模擬 async/await 的 `data(for:)`
    @available(iOS 13.0.0, *)
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = base.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
            task.resume()
        }
    }
    
    
}
