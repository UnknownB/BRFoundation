//
//  BRTimeZoneUtil.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation


/// 提供時區相關的資訊與格式化工具
public enum BRTimeZoneUtil {
    
    
    /// 當前時區的標識符，例如 "Asia/Taipei"
    public static var identifier: String {
        TimeZone.current.identifier
    }
    

    /// 當前時區的 GMT 偏移（以秒為單位），例如 +28800
    public static var gmtOffsetSeconds: Int {
        TimeZone.current.secondsFromGMT()
    }

    
    /// 當前時區的 GMT 偏移（以小時為單位），例如 +8
    public static var gmtOffsetHours: Int {
        gmtOffsetSeconds / 3600
    }

    
    /// 當前時區是否正在使用夏令時間（DST）
    public static var isDaylightSavingTime: Bool {
        TimeZone.current.isDaylightSavingTime()
    }

    
    /// 當前時區的本地化名稱，例如 "台北標準時間"
    public static var localizedName: String {
        TimeZone.current.localizedName(for: .standard, locale: .current) ?? identifier
    }

    
    /// 以 "+08:00" 格式顯示的 GMT 偏移
    public static var formattedGMTOffset: String {
        let hours = gmtOffsetHours
        return String(format: "%+03d:00", hours)
    }

    
    /// 結合 GMT 偏移與本地化名稱的完整描述，例如 "GMT+08:00 台北標準時間"
    public static var fullDescription: String {
        "GMT\(formattedGMTOffset) \(localizedName)"
    }
    
    
}
