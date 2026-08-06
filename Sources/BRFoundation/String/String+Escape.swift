//
//  String+Escape.swift
//  BRFoundation
//
//  Created by BR on 2026/8/6.
//

import Foundation


public extension BRWrapper where Base == String {


    /// HTTP Header multipart/form-data 字元跳脫
    var multipartEscaped: String {
        base
            .replacingOccurrences(of: "\r", with: "%0D")
            .replacingOccurrences(of: "\n", with: "%0A")
            .replacingOccurrences(of: "\"", with: "%22")
    }
    

}
