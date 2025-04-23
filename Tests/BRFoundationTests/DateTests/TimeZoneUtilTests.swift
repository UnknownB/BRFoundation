//
//  TimeZoneUtilTests.swift
//  BRFoundation
//
//  Created by BR on 2025/4/22.
//

import Foundation
import Testing
@testable import BRFoundation

@Suite("TimeZoneUtil")
struct BRTimeZoneUtilTests {
    
    
    @Test("TimeZone Description")
    func testTimeZoneDescription() {
        BRLog.printInfo("Identifier:", BRTimeZoneUtil.identifier)
        BRLog.printInfo("GMT Offset:", BRTimeZoneUtil.formattedGMTOffset)
        BRLog.printInfo("Localized:", BRTimeZoneUtil.localizedName)
        BRLog.printInfo("Full Desc :", BRTimeZoneUtil.fullDescription)
        
        #expect(!BRTimeZoneUtil.identifier.isEmpty)
        #expect(BRTimeZoneUtil.formattedGMTOffset.contains(":"))
        #expect(!BRTimeZoneUtil.localizedName.isEmpty)
        #expect(BRTimeZoneUtil.fullDescription.contains("GMT"))
    }
    
    
}
