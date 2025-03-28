//
//  BRLogTests.swift
//  BRFoundation
//
//  Created by BR on 2025/3/27.
//

import XCTest
@testable import BRFoundation

final class BRLogTests: XCTestCase {
    
    
    func testLogFormat() {
        let log = BRLog.format("admin: BR", "password: ******")
        XCTAssertEqual(log, "BRLogTests・15 -- admin: BR, password: ******")  // 在 XCTest 環境無法取得 app.log
    }
    
    
    func testPrintLog() {
        BRLog.printDebug("debug")
        BRLog.printInfo("info")
        BRLog.printNotice("notice")
        BRLog.printError("error")
        BRLog.printFault("fault")
        let appLog = BRLog.fetchPrintLog()
        XCTAssertEqual(appLog, "")  // 在 XCTest 環境無法取得 app.log
    }
    
    
    @available(iOS 15.0, *)
    func testOSLog() throws {
        BRLog.test.debug("debug")
        BRLog.test.info("info")
        BRLog.test.notice("notice")
        BRLog.test.error("error")
        BRLog.test.fault("fault")
        
        let logs = try BRLog.fetchOSLogStore()
        XCTAssertTrue(logs.count >= 5)
    }
}
