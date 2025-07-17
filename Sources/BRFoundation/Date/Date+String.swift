//
//  Date+String.swift
//  BRFoundation
//
//  Created by BR on 2025/4/21.
//

import Foundation


/// 日期格式的 `Date <-> String` 轉換功能
///
/// - 使用範圍
///     - 日期解析（由字串轉日期）
///     - 日期格式化（由日期轉字串）
///
/// - 格式類型
///     - ISO 8601 / RFC 3339
///     - 本地時間格式（簡易 / 詳細）
///     - 僅日期、僅時間
public extension BRWrapper where Base == Date {
    
    
    // MARK: String -> Date

    
    /// 將 ISO 8601 格式字串轉換為 Date
    ///
    /// - 範例
    ///     - `2025-04-21T22:12:00Z`
    static func fromISO8601String(_ iso8601String: String) -> Date? {
        return BRDateFormatter.iso8601Formatter.date(from: iso8601String)
    }
    
    
    /// 將 ISO 8601（含毫秒）格式字串轉換為 Date
    ///
    /// - 範例
    ///     - `2025-04-21T22:12:00.123Z`
    static func fromISO8601MsString(_ iso8601MsString: String) -> Date? {
        return BRDateFormatter.iso8601MsFormatter.date(from: iso8601MsString)
    }
    
    
    /// 將 RFC 3339 格式字串轉換為 Date
    ///
    /// - 範例
    ///     - `2025-04-21T22:12:00+00:00`
    static func fromRfc3339String(_ rfc3339String: String) -> Date? {
        return BRDateFormatter.rfc3339Formatter.date(from: rfc3339String)
    }
    
    
    /// 將 MySQL DATETIME 格式字串轉換為 Date
    ///
    /// - 範例
    ///     - `2025-07-17 01:04:04`
    static func fromMySQLDateString(_ mySQLDateString: String) -> Date? {
        return BRDateFormatter.mySQLFormatter.date(from: mySQLDateString)
    }
    
    
    /// 本地日期 (`yyyy-MM-dd`) 轉換為 Date
    ///
    /// - 範例
    ///     - `2025-04-21`
    static func fromLocalYMDDashString(_ localYMDDashString: String) -> Date? {
        return BRDateFormatter.localYMDFormatterDash.date(from: localYMDDashString)
    }
    
    
    /// 本地日期 (`yyyy/MM/dd`) 轉換為 Date
    ///
    /// - 範例
    ///     - `2025/04/21`
    static func fromLocalYMDSlashString(_ localYMDSlashString: String) -> Date? {
        return BRDateFormatter.localYMDFormatterSlash.date(from: localYMDSlashString)
    }
    
    
    /// 本地日期 (`MM-dd`) 轉換為 Date
    ///
    /// - 範例
    ///     - `04-21`
    static func fromLocalMDDashString(_ localMDDashString: String) -> Date? {
        return BRDateFormatter.localMDFormatterDash.date(from: localMDDashString)
    }
    
    
    /// 本地日期 (`MM/dd`) 轉換為 Date
    ///
    /// - 範例
    ///     - `04/21`
    static func fromLocalMDSlashString(_ localMDSlashString: String) -> Date? {
        return BRDateFormatter.localMDFormatterSlash.date(from: localMDSlashString)
    }

    
    /// 本地日期 (`yyyy/MM/dd HH:mm`) 轉換為 Date
    ///
    /// - 範例
    ///     - `2025/04/21 18:30`
    static func fromLocalYMDHmSlashString(_ localYMDHmSlashString: String) -> Date? {
        return BRDateFormatter.localYMDHmFormatterSlash.date(from: localYMDHmSlashString)
    }
    
    
    /// 本地日期 (`yyyy/MM/dd HH:mm:ss.SSS`) 轉換為 Date
    ///
    /// - 範例
    ///     - `2025/04/21 18:30:45.123`
    static func fromLocalYMDHmsSlashString(_ localYMDHmsSlashString: String) -> Date? {
        return BRDateFormatter.localYMDHmsFormatterSlash.date(from: localYMDHmsSlashString)
    }
    
    
    /// 本地時間 (`HH:mm:ss`) 轉換為 Date
    ///
    /// - 範例
    ///     - `18:30:45`
    static func fromLocalHmsString(_ localHmsString: String) -> Date? {
        return BRDateFormatter.localHmsFormatter.date(from: localHmsString)
    }
    
    
    /// 本地時間 (`HH:mm`) 轉換為 Date
    ///
    /// - 範例
    ///     - `18:30`
    static func fromLocalHmString(_ localHmString: String) -> Date? {
        return BRDateFormatter.localHmFormatter.date(from: localHmString)
    }
    
    
    // MARK: Date -> String
    
    
    /// 將日期轉換為 ISO 8601 格式字串
    ///
    /// - 範例
    ///     - `2025-04-21T22:12:00Z`
    func iso8601String() -> String {
        return BRDateFormatter.iso8601Formatter.string(from: base)
    }
    
    
    /// 將日期轉換為 ISO 8601（含毫秒）格式字串
    ///
    /// - 範例
    ///     - `2025-04-21T22:12:00.123Z`
    func iso8601MsString() -> String {
        return BRDateFormatter.iso8601MsFormatter.string(from: base)
    }
    
    
    /// 將日期轉換為 RFC 3339 格式字串
    ///
    /// - 範例
    ///     - `2025-04-21T22:12:00+00:00`
    func rfc3339String() -> String {
        return BRDateFormatter.rfc3339Formatter.string(from: base)
    }
    
    
    /// 將日期轉換為 MySQL DATETIME 格式字串
    ///
    /// - 範例
    ///     - `2025-07-17 01:04:04`
    func mySQLDateString() -> String {
        return BRDateFormatter.mySQLFormatter.string(from: base)
    }

        
    /// 本地日期 (`yyyy-MM-dd`) 轉換成字串
    ///
    /// - 範例
    ///     - `2025-04-21`
    func localYMDDashString() -> String {
        return BRDateFormatter.localYMDFormatterDash.string(from: base)
    }

    
    /// 本地日期 (`yyyy/MM/dd`) 轉換成字串
    ///
    /// - 範例
    ///     - `2025/04/21`
    func localYMDSlashString() -> String {
        return BRDateFormatter.localYMDFormatterSlash.string(from: base)
    }
    
    
    /// 本地日期 (`MM-dd`) 轉換成字串
    ///
    /// - 範例
    ///     - `04-21`
    func localMDDashString() -> String {
        return BRDateFormatter.localMDFormatterDash.string(from: base)
    }
    
    
    /// 本地日期 (`MM/dd`) 轉換成字串
    ///
    /// - 範例
    ///     - `04/21`
    func localMDSlashString() -> String {
        return BRDateFormatter.localMDFormatterSlash.string(from: base)
    }
    
    
    /// 本地日期 (`yyyy/MM/dd HH:mm`) 轉換成字串
    ///
    /// - 範例
    ///     - `2025/04/21 18:30`
    func localYMDHmSlashString() -> String {
        return BRDateFormatter.localYMDHmFormatterSlash.string(from: base)
    }
    
    
    /// 本地日期 (`yyyy/MM/dd HH:mm:ss.SSS`) 轉換成字串
    ///
    /// - 範例
    ///     - `2025/04/21 18:30:45.123`
    func localYMDHmsSlashString() -> String {
        return BRDateFormatter.localYMDHmsFormatterSlash.string(from: base)
    }
    
    
    /// 本地時間 (`HH:mm:ss`) 轉換成字串
    ///
    /// - 範例
    ///     - `18:30:45`
    func localHmsString() -> String {
        return BRDateFormatter.localHmsFormatter.string(from: base)
    }
    
    
    /// 本地時間 (`HH:mm`) 轉換成字串
    ///
    /// - 範例
    ///     - `18:30`
    func localHmString() -> String {
        return BRDateFormatter.localHmFormatter.string(from: base)
    }

    
    /// 本地時間 `週日 ~ 週六`
    func localWeekdayString() -> String {
        return BRDateFormatter.localWeekdayFormatter.string(from: base)
    }
    
    
}
