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
        let log = BRLog.format("admin: BR", "password: ******", tag: "Test")
        #expect(log == "[Test] BRLogTests・17 -- admin: BR, password: ******")
    }
    
    
    @Test("printLog")
    func testPrintLog() {
        BRLog.printTest.debug("debug")
        BRLog.printTest.info("info")
        BRLog.printTest.notice("notice")
        BRLog.printTest.error("error")
        BRLog.printTest.fault("fault")
        let appLog = BRLog.fetchPrintLog()
        
        var logs = ""
        logs += "🛠️ [Test] BRLogTests・24 -- debug\n"
        logs += "⚙️ [Test] BRLogTests・25 -- info\n"
        logs += "☑️ [Test] BRLogTests・26 -- notice\n"
        logs += "❌ [Test] BRLogTests・27 -- error\n"
        logs += "⚠️ [Test] BRLogTests・28 -- fault\n"

        #expect(appLog == logs)
    }
    
    
    @available(iOS 15.0, *)
    @Test("OSLog")
    func testOSLog() throws {
        BRLog.test.debug("debug")
        BRLog.test.info("info")
        BRLog.test.notice("notice")
        BRLog.test.error("error")
        BRLog.test.fault("fault")
        
        let logs = try BRLog.fetchOSLogStore()
        #expect(logs.count >= 5)
    }
}
