//
//  Data+Upload.swift
//  BRFoundation
//
//  Created by BR on 2025/10/28.
//

import Foundation


public extension BRWrapper where Base == Data {
    
    
    /// 從 Data 自動判斷 MIME type 並封裝成 BRUploadPart
    /// - Parameters:
    ///   - key: 對應伺服器的欄位名稱
    ///   - filename: 檔名（不含副檔名）
    func toUploadPart(key: String, filename: String) -> BRUploadPart {
        let mimeType = base.br.mimeType
        let ext = mimeType.fileExtension
        let fullFilename = filename + "." + ext
        return BRUploadPart(key: key, filename: fullFilename, mimeType: mimeType, data: base)
    }
    
    
}
