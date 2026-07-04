//
//  BRFile.swift
//  BRFoundation
//
//  Created by BR on 2026/5/4.
//

import Foundation
import CryptoKit


public enum BRFile {
    
    
    // MARK: - 常用路徑
    
    
    /// App 文件目錄
    public static var document: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    /// App 快取目錄
    public static var caches: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    
    /// App 暫存目錄 (Session 結束時自動刪除)
    public static var temporary: URL {
        FileManager.default.temporaryDirectory
    }
    
    
    // MARK: - 檢查檔案 or 目錄是否存在
    
    
    /// 檢查是否存在路徑檔案
    public static func exists(at path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }
    
    
    /// 檢查是否存在路徑檔案
    public static func exists(at url: URL) -> Bool {
        FileManager.default.fileExists(atPath: url.path)
    }
    
    
    /// 檢查是否存在路徑目錄
    public static func existsDirectory(at path: String) -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    
    /// 檢查是否存在路徑目錄
    public static func existsDirectory(at url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    
    // MARK: - iCloud 備份
    
    
    /// 檢查 URL 是否跳過 iCloud 備份
    ///
    /// - `.documents` 目錄下預設會進行備份
    /// - `.caches` 目錄下預設不會進行備份
    public static func isExcludedFromBackup(at url: URL) throws -> Bool {
        let resourceValues = try url.resourceValues(forKeys: [.isExcludedFromBackupKey])
        return resourceValues.isExcludedFromBackup ?? false
    }
    
    
    /// 設定 URL 是否跳過 iCloud 備份
    public static func setExcludedFromBackup(_ isExcluded: Bool, at url: URL) throws {
        var url = url
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = isExcluded
        try url.setResourceValues(resourceValues)
    }
    
    
    // MARK: - 建立目錄
    
    
    /// 建立目錄
    ///
    /// ## isExcluded
    ///
    /// - 系統預設為 flase，代表不跳過備份
    /// - `.documents` 目錄下預設會進行備份
    /// - `.caches` 目錄下預設不進行備份
    /// - 需注意可重新下載或生成的檔案 (如圖片緩存、暫存檔) 不應該被備份
    @discardableResult
    public static func createDirectory(_ url: URL, attributes: [FileAttributeKey : Any]? = nil, isExcluded: Bool? = nil) throws -> URL {
        if !existsDirectory(at: url) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: attributes)
        }
        if let isExcluded {
            try setExcludedFromBackup(isExcluded, at: url)
        }
        return url
    }
    
    
    /// 建立目錄
    ///
    /// ## isExcluded
    ///
    /// - 系統預設為 flase，代表不跳過備份
    /// - `.documents` 目錄下預設會進行備份
    /// - `.caches` 目錄下預設不進行備份
    /// - 需注意可重新下載或生成的檔案 (如圖片緩存、暫存檔) 不應該被備份
    @discardableResult
    public static func createDirectory(_ path: String, attributes: [FileAttributeKey : Any]? = nil, isExcluded: Bool? = nil) throws -> String {
        let url = URL(fileURLWithPath: path)
        try createDirectory(url, attributes: attributes, isExcluded: isExcluded)
        return path
    }

    
    // MARK: - 建立檔案
    
    
    /// 建立空檔案到 URL
    public static func createEmptyFile(at url: URL, attributes: [FileAttributeKey : Any]? = nil) throws {
        let success = FileManager.default.createFile(atPath: url.path, contents: nil, attributes: attributes)
        if !success {
            throw BRFileError.createFileFailed(at: url)
        }
    }
    
    
    /// 建立空檔案到 path
    public static func createEmptyFile(at path: String, attributes: [FileAttributeKey : Any]? = nil) throws {
        let success = FileManager.default.createFile(atPath: path, contents: nil, attributes: attributes)
        if !success {
            throw BRFileError.createFileFailed(at: URL(fileURLWithPath: path))
        }
    }

    
    /// 寫入 data 到 URL
    public static func write(_ data: Data, options: Data.WritingOptions = [.atomic], at url: URL, encryptionKey: SymmetricKey? = nil) throws {
        var dataToWrite = data
        
        if let key = encryptionKey {
            dataToWrite = try data.br.aesGCMEncrypt(key: key)
        }
        
        try dataToWrite.write(to: url, options: options)
    }
    
    
    /// 寫入 data 到 path
    public static func write(_ data: Data, options: Data.WritingOptions = [.atomic], at path: String, encryptionKey: SymmetricKey? = nil) throws {
        let url = URL(fileURLWithPath: path)
        try write(data, options: options, at: url, encryptionKey: encryptionKey)
    }
    
    
    /// 寫入 text 到 URL
    public static func write(_ text: String, options: Data.WritingOptions = [.atomic], at url: URL, encryptionKey: SymmetricKey? = nil) throws {
        guard let data = text.data(using: .utf8) else {
            throw BRFileError.dataDecodingFailed(at: url)
        }
        try write(data, options: options, at: url, encryptionKey: encryptionKey)
    }
    
    
    /// 寫入 text 到 path
    public static func write(_ text: String, options: Data.WritingOptions = [.atomic], at path: String, encryptionKey: SymmetricKey? = nil) throws {
        let url = URL(fileURLWithPath: path)
        try write(text, options: options, at: url, encryptionKey: encryptionKey)
    }
    
    
    // MARK: - 讀取檔案
    
    
    /// 讀取 url data
    public static func readData(at url: URL, options: Data.ReadingOptions = [], encryptionKey: SymmetricKey? = nil) -> Data? {
        var data = try? Data(contentsOf: url, options: options)
        
        if let key = encryptionKey {
            data = try? data?.br.aesGCMDecrypt(key: key)
        }
        
        return data
    }
    
    
    /// 讀取 path data
    public static func readData(at path: String, options: Data.ReadingOptions = [], encryptionKey: SymmetricKey? = nil) -> Data? {
        let url = URL(fileURLWithPath: path)
        return readData(at: url, options: options, encryptionKey: encryptionKey)
    }
    
    
    /// 讀取 url text
    public static func readText(at url: URL, options: Data.ReadingOptions = [], encryptionKey: SymmetricKey? = nil) -> String? {
        if let data = readData(at: url, options: options, encryptionKey: encryptionKey) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
    /// 讀取 path text
    public static func readText(at path: String, options: Data.ReadingOptions = [], encryptionKey: SymmetricKey? = nil) -> String? {
        let url = URL(fileURLWithPath: path)
        return readText(at: url, options: options, encryptionKey: encryptionKey)
    }


    // MARK: - 刪除
    
    
    /// 刪除 URL 檔案 or 目錄
    @discardableResult
    public static func remove(at url: URL) -> Bool {
        guard exists(at: url) else {
            return true
        }
        
        do {
            try FileManager.default.removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
    
    
    /// 刪除 path 檔案 or 目錄
    @discardableResult
    public static func remove(at path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        return remove(at: url)
    }
    
    
    // MARK: - 移動
    
    
    /// 移動 URL 檔案 or 目錄
    @discardableResult
    public static func move(at sourceURL: URL, to destinationURL: URL) -> Bool {
        guard exists(at: sourceURL) else {
            return false
        }
        
        do {
            try FileManager.default.moveItem(at: sourceURL, to: destinationURL)
            return true
        } catch {
            return false
        }
    }
    
    
    /// 移動 path 檔案 or 目錄
    @discardableResult
    public static func move(at sourcePath: String, to destinationPath: String) -> Bool {
        let sourceURL = URL(fileURLWithPath: sourcePath)
        let destinationURL = URL(fileURLWithPath: destinationPath)
        return move(at: sourceURL, to: destinationURL)
    }
    
    
    // MARK: - 目錄檔案清單
    
    
    /// 獲取目錄內容
    ///
    /// ## keys
    ///
    /// 預先獲取的資源屬性
    ///
    /// ### .fileSizeKey
    ///     - 檔案容量
    /// ### .creationDateKey
    ///     - 檔案建立日期
    /// ### .contentModificationDateKey
    ///     - 檔案修改日期
    ///
    /// ## options
    ///
    /// 列舉選項
    ///
    /// ### .skipsHiddenFiles
    ///     - 跳過隱藏檔案 (以點開頭的檔案，如 .DS_Store)
    /// ### .skipsSubdirectoryDescendants
    ///     - 只搜尋當前層級，不進入子目錄內部。
    /// ### .skipsPackageDescendants
    ///     - 跳過封裝包內容，如 .app 或 .bundle
    /// ### .includesDirectoriesPostOrder
    ///     - 先列出檔案內容後，最後才列出目錄本身
    /// ### .producesRelativePathURLs
    ///     - 使回傳的 URL 為相對於目錄的相對路徑
    public static func contents(at url: URL, keys: [URLResourceKey]? = nil, options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles]) throws -> [URL] {
        try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: keys, options: options)
    }
    
    
    // MARK: - 容量計算
    
    
    /// 計算目錄或檔案的總大小 (Bytes)
    /// - Note: 若為目錄，會自動遞迴累加所有子項目的容量
    public static func size(at url: URL, options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsPackageDescendants]) -> Int64 {
        var isDirectory: ObjCBool = false
        if !FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) {
            return 0
        }
        
        if !isDirectory.boolValue {
            let attrs = try? FileManager.default.attributesOfItem(atPath: url.path)
            return attrs?[.size] as? Int64 ?? 0
        }
        
        guard let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.fileSizeKey], options: options) else {
            return 0
        }
        
        var totalSize: Int64 = 0
        for case let fileURL as URL in enumerator {
            let resourceValues = try? fileURL.resourceValues(forKeys: [.fileSizeKey])
            totalSize += Int64(resourceValues?.fileSize ?? 0)
        }
        return totalSize
    }
    
    
    // MARK: - JSON
    
    
    /// 寫入 JSON 到 URL
    public static func writeJSON<T: Encodable>(_ object: T, options: Data.WritingOptions = [.atomic], at url: URL, encryptionKey: SymmetricKey? = nil) throws {
        let data = try JSONEncoder().encode(object)
        try write(data, options: options, at: url, encryptionKey: encryptionKey)
    }

    
    /// 從 URL 讀取 JSON
    public static func readJSON<T: Decodable>(_ type: T.Type, at url: URL, options: Data.ReadingOptions = [], encryptionKey: SymmetricKey? = nil) -> T? {
        guard let data = readData(at: url, options: options, encryptionKey: encryptionKey) else {
            return nil
        }
        return try? JSONDecoder().decode(type, from: data)
    }
    

}
