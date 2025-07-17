//
//  BRDateFormatter.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation


public enum BRDateFormatter {
    
    
    /// ISO 8601 格式
    ///
    /// - 特性
    ///     - 標準 UTC 時間
    /// - 範例
    ///     - `2025-04-21T22:12:00Z`
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.formatOptions = [
            .withInternetDateTime
        ]
        return formatter
    }()
    
    
    /// ISO 8601 格式（含毫秒）
    ///
    /// - 特性
    ///     - 標準 UTC 時間
    ///     - 精確到毫秒
    /// - 範例
    ///     - `2025-04-21T22:12:00.123Z`
    static let iso8601MsFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        return formatter
    }()
    
    
    /// RFC 3339 格式
    ///
    /// - 特性
    ///     - 與 ISO8601 類似，常用於 API 傳輸
    ///     - 支援時區偏移表示
    /// - 範例
    ///     - `2025-04-21T22:12:00+00:00`
    static let rfc3339Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter
    }()
    
    
    /// MySQL 格式
    ///
    /// - 特性
    ///     - 後端語言預設輸出
    ///     - 標準 UTC 時間
    /// - 範例
    ///     - `2025-07-17 01:04:04`
    static let mySQLFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    
    /// 本地日期 (`yyyy-MM-dd`)
    ///
    /// - 特性
    ///     - 適用於日曆、日期選擇器
    /// - 範例
    ///     - `2025-04-21`
    static let localYMDFormatterDash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    /// 本地日期 (`yyyy/MM/dd`)
    ///
    /// - 特性
    ///     - 顯示完整西元年月日
    /// - 範例
    ///     - `2025/04/21`
    static let localYMDFormatterSlash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    
    /// 本地日期 (`MM-dd`)
    ///
    /// - 特性
    ///     - 與某些地區習慣一致
    ///     - 適合精簡顯示、報表欄位
    /// - 範例
    ///     - `04-21`
    static let localMDFormatterDash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM-dd"
        return formatter
    }()

    
    /// 本地日期 (`MM/dd`)
    ///
    /// - 特性
    ///     - 精簡顯示，不含年份
    ///     - 適用於當年內的事件
    /// - 範例
    ///     - `04/21`
    static let localMDFormatterSlash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM/dd"
        return formatter
    }()

    
    
    /// 本地日期 (`yyyy/MM/dd HH:mm`)
    ///
    /// - 特性
    ///     - 精確至分鐘
    /// - 範例
    ///     - `2025/04/21 18:30`
    static let localYMDHmFormatterSlash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    
    
    /// 本地日期 (`yyyy/MM/dd HH:mm:ss.SSS`)
    ///
    /// - 特性
    ///     - 精確至毫秒
    /// - 範例
    ///     - `2025/04/21 18:30:45.123`
    static let localYMDHmsFormatterSlash: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        return formatter
    }()
    
    
    /// 本地時間 (`HH:mm:ss`)
    ///
    /// - 特性
    ///     - 適合用於提醒、排程
    /// - 範例
    ///     - `18:30:45`
    static let localHmsFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    
    /// 本地時間 (`HH:mm`)
    ///
    /// - 特性
    ///     - 適合用於提醒、排程
    /// - 範例
    ///     - `18:30`
    static let localHmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
    /// 本地時間 `週日 ~ 週六`
    static let localWeekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "EEEEEE"
        return formatter
    }()

    
}
