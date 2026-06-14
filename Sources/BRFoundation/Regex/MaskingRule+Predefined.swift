//
//  MaskingRule+Predefined.swift
//  BRFoundation
//
//  Created by BR on 2026/6/11.
//

import Foundation
import BRMacros

public extension BRLogInfo.MaskingRule {
    static let email = BRLogInfo.MaskingRule(regex: BRRegex.email, replacement: "[EMAIL]")
    static let taiwanID = BRLogInfo.MaskingRule(regex: BRRegex.taiwanID, replacement: "$1*****$3")
    static let taiwanPhone = BRLogInfo.MaskingRule(regex: BRRegex.taiwanPhone, replacement: "$1-***-$3")
}
