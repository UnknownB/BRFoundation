//
//  BRMimeType.swift
//  BRFoundation
//
//  Created by BR on 2025/10/28.
//

import Foundation
import MobileCoreServices


public struct BRMimeType: Hashable, Equatable, RawRepresentable, ExpressibleByStringLiteral {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }
    
    public static func custom(_ type: String) -> BRMimeType {
        BRMimeType(rawValue: type)
    }

    // MARK: - Images
    
    public static let jpeg: BRMimeType = "image/jpeg"
    public static let png: BRMimeType = "image/png"
    public static let gif: BRMimeType = "image/gif"
    public static let webp: BRMimeType = "image/webp"
    public static let svg: BRMimeType = "image/svg+xml"
    
    // MARK: - Documents
    
    public static let pdf: BRMimeType = "application/pdf"
    public static let doc: BRMimeType = "application/msword"
    public static let docx: BRMimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    public static let xls: BRMimeType = "application/vnd.ms-excel"
    public static let xlsx: BRMimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    public static let ppt: BRMimeType = "application/vnd.ms-powerpoint"
    public static let pptx: BRMimeType = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    public static let txt: BRMimeType = "text/plain"

    // MARK: - Archives
    
    public static let zip: BRMimeType = "application/zip"
    public static let rar: BRMimeType = "application/x-rar-compressed"
    public static let tar: BRMimeType = "application/x-tar"
    public static let gzip: BRMimeType = "application/gzip"

    // MARK: - Media
    
    public static let mp3: BRMimeType = "audio/mpeg"
    public static let mp4: BRMimeType = "video/mp4"
    public static let avi: BRMimeType = "video/x-msvideo"
    public static let mov: BRMimeType = "video/quicktime"
    public static let wav: BRMimeType = "audio/wav"

    // MARK: - Data
    
    public static let json: BRMimeType = "application/json"
    public static let xml: BRMimeType = "application/xml"
    public static let csv: BRMimeType = "text/csv"
    
    
    // MARK: - 類型判斷
    
    
    public var isImage: Bool {
        switch self {
        case .jpeg, .png, .gif, .webp, .svg:
            return true
        default:
            return false
        }
    }
    
    
    public var isVideo: Bool {
        switch self {
        case .mp4, .avi, .mov:
            return true
        default:
            return false
        }
    }
    

    // MARK: - 副檔名轉換
    
    
    public static func from(fileExtension ext: String) -> BRMimeType {
        let ext = ext.lowercased()
        
        // 系統方法查 UTI → MIME
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext as CFString, nil)?.takeRetainedValue(),
           let mime = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
            return BRMimeType(rawValue: mime as String)
        }
        
        switch ext {
        case "jpg", "jpeg": return .jpeg
        case "png": return .png
        case "gif": return .gif
        case "webp": return .webp
        case "svg": return .svg
        case "pdf": return .pdf
        case "doc": return .doc
        case "docx": return .docx
        case "xls": return .xls
        case "xlsx": return .xlsx
        case "ppt": return .ppt
        case "pptx": return .pptx
        case "txt": return .txt
        case "zip": return .zip
        case "rar": return .rar
        case "tar": return .tar
        case "gz": return .gzip
        case "mp3": return .mp3
        case "mp4": return .mp4
        case "avi": return .avi
        case "mov": return .mov
        case "wav": return .wav
        case "json": return .json
        case "xml": return .xml
        case "csv": return .csv
        default: return .custom("application/octet-stream")
        }
    }
    
    
    public var fileExtension: String {
        switch self {
        case .jpeg: "jpg"
        case .png: "png"
        case .gif: "gif"
        case .webp: "webp"
        case .svg: "svg"
        case .pdf: "pdf"
        case .doc: "doc"
        case .docx: "docx"
        case .xls: "xls"
        case .xlsx: "xlsx"
        case .ppt: "ppt"
        case .pptx: "pptx"
        case .txt: "txt"
        case .zip: "zip"
        case .rar: "rar"
        case .tar: "tar"
        case .gzip: "gz"
        case .mp3: "mp3"
        case .mp4: "mp4"
        case .avi: "avi"
        case .mov: "mov"
        case .wav: "wav"
        case .json: "json"
        case .xml: "xml"
        case .csv: "csv"
        default:
            "bin"
        }
    }
    
    
}
