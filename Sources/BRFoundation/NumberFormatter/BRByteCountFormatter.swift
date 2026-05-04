//
//  BRByteCountFormatter.swift
//  BRFoundation
//
//  Created by BR on 2026/5/4.
//

import Foundation


public enum BRByteCountFormatter {
    
    
    /// 將 Byte 轉換為人類易讀的格式 (KB, MB, GB)
    public static let useAllFile: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useAll]
        formatter.countStyle = .file
        return formatter
    }()
    
    
}
