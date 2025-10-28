//
//  BRUploadPart.swift
//  BRFoundation
//
//  Created by BR on 2025/10/22.
//

import Foundation


/// 上傳檔案資料封裝
public struct BRUploadPart {
    public let key: String
    public let filename: String
    public let mimeType: BRMimeType
    public let data: Data
    
    
    public init(key: String, filename: String, mimeType: BRMimeType, data: Data) {
        self.key = key
        self.filename = filename
        self.mimeType = mimeType
        self.data = data
    }
}
