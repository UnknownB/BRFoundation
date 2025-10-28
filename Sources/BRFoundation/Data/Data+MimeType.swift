//
//  Data+MimeType.swift
//  BRFoundation
//
//  Created by BR on 2025/10/28.
//

import Foundation


public extension BRWrapper where Base == Data {
    
    
    /// 從 Data 判斷 MIME Type
    var mimeType: BRMimeType {
        if base.starts(with: [0x89, 0x50, 0x4E, 0x47]) {
            return .png
        } else if base.starts(with: [0xFF, 0xD8, 0xFF]) {
            return .jpeg
        } else if base.starts(with: [0x47, 0x49, 0x46, 0x38]) { // GIF8
            return .gif
        } else if base.starts(with: [0x52, 0x49, 0x46, 0x46]) { // RIFF → WEBP/AVI/WAV
            if base.count >= 12, let typeRange = String(data: base[8..<12], encoding: .ascii) {
                switch typeRange {
                case "WEBP":
                    return .webp
                case "AVI ":
                    return .avi
                case "WAVE":
                    return .wav
                default:
                    break
                }
            }
        } else if base.starts(with: [0x25, 0x50, 0x44, 0x46]) { // %PDF
            return .pdf
        } else if base.starts(with: [0x50, 0x4B, 0x03, 0x04]) { // ZIP (含 docx/xlsx/pptx)
            return .zip
        } else if base.starts(with: [0x52, 0x61, 0x72, 0x21]) { // RAR !
            return .rar
        } else if base.starts(with: [0x1F, 0x8B]) { // GZIP
            return .gzip
        } else if base.starts(with: [0xFF, 0xFB]) || base.starts(with: [0x49, 0x44, 0x33]) { // MP3
            return .mp3
        } else if base.starts(with: [0x00, 0x00, 0x00, 0x18]) || base.starts(with: [0x66,0x74,0x79,0x70]) { // MP4/MOV
            return .mp4
        } else if base.starts(with: [0x00, 0x00, 0x00, 0x1C]) { // QuickTime MOV fallback
            return .mov
        }
        return .custom("application/octet-stream")
    }
    
    
}
