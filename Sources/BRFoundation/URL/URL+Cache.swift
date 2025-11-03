//
//  URL+Cache.swift
//  BRFoundation
//
//  Created by BR on 2025/11/3.
//

import Foundation

public extension BRWrapper where Base == URL {
    
    
    /// 快取目錄
    var cacheDirectory: URL {
        let cachedDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let dir = cachedDirectoryURL.appendingPathComponent(BRCachePolicy.cacheDirectoryName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir
    }
    
    
    /// 快取檔案名稱
    var cacheFileName: String {
        base.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }
    
    
    /// 取得快取後的 Data（若無則自動下載並建立快取）
    func cachedData() async throws -> Data {
        let cacheURL = try await cachedURL()
        return try Data(contentsOf: cacheURL)
    }
    
    
    /// 取得快取後的本地 URL（若無則自動下載並建立快取）
    func cachedURL() async throws -> URL {
        cleanupCacheIfNeeded()
        
        let cacheURL = cacheDirectory.appendingPathComponent(cacheFileName)
        
        if isCached {
            return cacheURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: base)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        try? data.write(to: cacheURL, options: .atomic)
        return cacheURL
    }
    
    
    /// 是否已有快取
    var isCached: Bool {
        FileManager.default.fileExists(atPath: cacheDirectory.appendingPathComponent(cacheFileName).path)
    }
    
    
    /// 清理過期的檔案，以及當容量超出上限時從最舊的檔案開始清理
    private func cleanupCacheIfNeeded() {
        let dir = cacheDirectory
        guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.contentModificationDateKey, .fileSizeKey]) else {
            return
        }
        
        var totalSize: UInt64 = 0
        var fileInfos: [(url: URL, size: UInt64, date: Date)] = []
        
        let now = Date()
        
        for file in files {
            if let attrs = try? file.resourceValues(forKeys: [.fileSizeKey, .contentModificationDateKey]),
               let size = attrs.fileSize,
               let date = attrs.contentModificationDate {
                
                if now.timeIntervalSince(date) > BRCachePolicy.ttl {
                    try? FileManager.default.removeItem(at: file)
                    continue
                }
                
                totalSize += UInt64(size)
                fileInfos.append((file, UInt64(size), date))
            }
        }
        
        let maxBytes = UInt64(BRCachePolicy.maxCacheSizeMB * 1024 * 1024)
        
        guard totalSize > maxBytes else {
            return
        }
        
        for file in fileInfos.sorted(by: { $0.date < $1.date }) {
            try? FileManager.default.removeItem(at: file.url)
            totalSize -= file.size
            if totalSize <= maxBytes {
                break
            }
        }
    }
    
    
}
