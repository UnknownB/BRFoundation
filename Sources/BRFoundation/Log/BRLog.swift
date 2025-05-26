//
//  BRLog.swift
//
//
//  Created by BR on 2024/10/24.
//

import Foundation
import OSLog


/// BRLog - 用於記錄日誌的工具類，提供控制台輸出與日誌檔案儲存功能
///
/// 系統支援
///
/// - iOS 15+
///     - fetchOSLogStore
///         - 取得 Logger 輸出紀錄
/// - iOS 14+
///     - Logger
///         - 制定 UI、Core、Network、IO、Library、Test 分類
/// - iOS 14-
///     - print
///         - 制定 debug、info、notice、errer、fault 分級模擬
///         - 相似於 Logger 的封裝
///         - 升級成 Logger 版本替換範例
///             - BRLog.printUI.info("") -> BRLog.ui.info("")
///     - fetchPrintLog
///         - 取得 print 輸出紀錄
///
public enum BRLog {
    
    
    public static let printUI = PrintLog(tag: "UI")
    public static let printCore = PrintLog(tag: "Core")
    public static let printNet = PrintLog(tag: "Network")
    public static let printIO = PrintLog(tag: "IO")
    public static let printLib = PrintLog(tag: "Library")
    public static let printTest = PrintLog(tag: "Test")

    
    public struct PrintLog {
        
        let tag: String
        
        public func debug(_ items: Any..., file: String = #file, line: Int = #line) {
            let log = "🛠️ " + format(items, tag: tag, file: file, line: line)
            writeOrPrint(log)
        }
        
        
        public func info(_ items: Any..., file: String = #file, line: Int = #line) {
            let log = "⚙️ " + format(items, tag: tag, file: file, line: line)
            writeOrPrint(log)
        }

        
        public func notice(_ items: Any..., file: String = #file, line: Int = #line) {
            let log = "☑️ " + format(items, tag: tag, file: file, line: line)
            writeOrPrint(log)
        }
        
        
        public func error(_ items: Any..., file: String = #file, line: Int = #line) {
            let log = "❌ " + format(items, tag: tag, file: file, line: line)
            writeOrPrint(log)
        }
        
        
        public func fault(_ items: Any..., file: String = #file, line: Int = #line) {
            let log = "⚠️ " + format(items, tag: tag, file: file, line: line)
            writeOrPrint(log)
        }
    }
    
    
    /// 格式化日誌訊息，包含檔案名稱、行號
    /// - Returns: 格式化後的日誌訊息字串
    public static func format(_ items: Any..., tag: String, file: String = #file, line: Int = #line) -> String {
        let fileName = URL(fileURLWithPath: file).deletingPathExtension().lastPathComponent
        let message = items.map { "\($0)" }.joined(separator: ", ")
        return "[\(tag)] \(fileName)・\(line) -- \(message)"
    }

    
    private static func writeOrPrint(_ message: String) {
        #if DEBUG
        print(message)
        #endif
        writeLogToFile(message)
    }
    
    
    // MARK: IO
    
    
    private static var logHandle : FileHandle?
    private static let lockQueue = DispatchQueue(label: "com.br.brfoundation.logHandle", attributes: .concurrent)
    private static let logFile = FileManager.default.temporaryDirectory.appendingPathComponent("app.log")
    
    
    private static func createFileHandle() -> FileHandle? {
        do {
            FileManager.default.createFile(atPath: logFile.path, contents: nil, attributes: nil)
            return try FileHandle(forWritingTo: logFile)
        } catch {
            BRLog.printIO.error("[BRLog] [建立 app.log] [error] \(error)")
            return nil
        }
    }
    
    
    private static func writeLogToFile(_ message: String) {
        lockQueue.async(flags: .barrier) {
            if BRLog.logHandle == nil {
                BRLog.logHandle = createFileHandle()
            }
            
            guard let logHandle = BRLog.logHandle else {
                return
            }
            
            let messageData = "\(message)\n".data(using: .utf8)!
            logHandle.seekToEndOfFile()
            logHandle.write(messageData)
        }
    }
    
    
    public static func fetchPrintLog() -> String {
        lockQueue.sync {
            logHandle?.closeFile()
            logHandle = nil
        }
        
        do {
            let log = try String(contentsOf: logFile)
            return log
        } catch {
            BRLog.printIO.error("[讀取崩潰日誌] [error]: \(error)")
            return ""
        }
    }


}


// MARK: - Logger

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension BRLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    public static let ui = Logger(subsystem: subsystem, category: "UI")
    public static let core = Logger(subsystem: subsystem, category: "Core")
    public static let net = Logger(subsystem: subsystem, category: "Network")
    public static let io = Logger(subsystem: subsystem, category: "IO")
    public static let lib = Logger(subsystem: subsystem, category: "Library")
    public static let test = Logger(subsystem: subsystem, category: "Test")
    
    
    /// 取得目前 Process 內的 OSLog 紀錄
    /// - Throws: 若 OSLogStore 無法存取，則拋出錯誤
    /// - Returns: `OSLogEntryLog` 陣列
    @available(macOS 10.15, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public static func fetchOSLogStore() throws -> [OSLogEntryLog] {
        let logStore = try OSLogStore(scope: .currentProcessIdentifier)
        let predicate = NSPredicate(format: "subsystem == %@", subsystem)
        
        let entries = try logStore.getEntries(matching: predicate)
        let logs = entries.compactMap { $0 as? OSLogEntryLog } // 轉換成 OSLogEntryLog 獲得更多屬性
        return logs
    }
    
    
}


// MARK: Description


@available(macOS 10.15, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension OSLogEntryLog {
    
    
    public override var description: String {
        let symbol = OSLogEntryLog.levelSymbols[self.level] ?? "❔"
        return "\(symbol) \(self.date) [\(self.category)] -- \(self.composedMessage)"
    }
    
    
    private static let levelSymbols: [OSLogEntryLog.Level: String] = [
        .undefined: "❔",
        .debug: "🛠️",
        .info: "⚙️",
        .notice: "☑️",
        .error: "❌",
        .fault: "⚠️"
    ]
    
    
}
