//
//  BRCachePolicy.swift
//  BRFoundation
//
//  Created by BR on 2025/11/3.
//

import Foundation


public enum BRCachePolicy {
    
    /// 快取存活時間（預設 7 天）
    public static var ttl: TimeInterval = 60 * 60 * 24 * 7
    
    
    /// 最大快取容量（單位 MB，預設 200 MB）
    public static var maxCacheSizeMB: Double = 200

    
    /// 快取存放目錄名稱
    public static var cacheDirectoryName: String = "BRURLCache"
    
}
