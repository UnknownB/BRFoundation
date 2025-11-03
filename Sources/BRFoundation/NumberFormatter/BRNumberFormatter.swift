//
//  BRNumberFormatter.swift
//  BRFoundation
//
//  Created by BR on 2025/11/3.
//

import Foundation


public enum BRNumberFormatter {
    
    
    /// 顯示「千分位」的金額格式，例如：`1,234`
    public static let decimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    
    /// 顯示兩位小數，常用於金額精算，例如：`1,234.56`
    public static let decimal2: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    
    /// 顯示「貨幣符號 + 千分位」，例如：`$ 1,234`
    public static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.positiveFormat = "¤ #,##0"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    
    /// 顯示「貨幣符號 + 千分位」，例如：`$ 1,234.00`
    public static let currency2: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.positiveFormat = "¤ #,##0.00"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    /// 顯示「台幣符號 + 千分位」，例如：`NT$ 1,234`
    public static let currencyTWD: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "NT$"
        formatter.positiveFormat = "¤ #,##0"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    
}

