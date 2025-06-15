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
        BRLog.printTest.info("Identifier:", BRTimeZoneUtil.identifier)
        BRLog.printTest.info("GMT Offset:", BRTimeZoneUtil.formattedGMTOffset)
        BRLog.printTest.info("Localized:", BRTimeZoneUtil.localizedName)
        BRLog.printTest.info("Full Desc :", BRTimeZoneUtil.fullDescription)
        
        #expect(!BRTimeZoneUtil.identifier.isEmpty)
        #expect(BRTimeZoneUtil.formattedGMTOffset.contains(":"))
        #expect(!BRTimeZoneUtil.localizedName.isEmpty)
        #expect(BRTimeZoneUtil.fullDescription.contains("GMT"))
    }
    
    
}
