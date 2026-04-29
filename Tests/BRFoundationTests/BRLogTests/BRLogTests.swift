//
//  BRLogTests.swift
//  BRFoundation
//
//  Created by BR on 2025/3/27.
//

import Testing
@testable import BRFoundation

@Suite("BRLogTests")
struct BRLogTests {
    
    
    @Test("format")
    func testLogFormat() {
        let log = BRLog.format(.init(category: .test, level: .debug, items: ["item"], file: #file, function: #function, line: #line))
        #expect(log == "🛠️ [Test] BRLogTests・17 -- item")
    }
    
    
    @available(iOS 15.0, *)
    @Test("OSLog")
    func testOSLog() throws {
        #BRLog(.test, .debug, "debug")
        #BRLog(.test, .info, "info")
        #BRLog(.test, .notice, "notice")
        #BRLog(.test, .error, "error")
        #BRLog(.test, .fault, "fault")
        
        let logs = try BRLog.fetchOSLogStore()
        #expect(logs.count >= 5)
    }
}
