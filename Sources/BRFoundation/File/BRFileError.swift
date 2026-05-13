//
//  BRFileError.swift
//  BRFoundation
//
//  Created by BR on 2026/5/4.
//

import Foundation

public enum BRFileError: Error, LocalizedError {
    case createFileFailed(at: URL)
    case dataDecodingFailed(at: URL)
    case listDirectoryFailed(at: URL)
    case encryptionFailed
    case decryptionFailed
    
    public var errorDescription: String? {
        switch self {
        case .createFileFailed(at: let url):
            return "create file failed at \(url.lastPathComponent)"
            
        case .dataDecodingFailed(at: let url):
            return "data decoding failed at \(url.lastPathComponent)"
            
        case .listDirectoryFailed(at: let url):
            return "list directory failed at \(url.lastPathComponent)"
            
        case .encryptionFailed:
            return "encryption failed"
            
        case .decryptionFailed:
            return "decryption failed"
        }
    }
}
