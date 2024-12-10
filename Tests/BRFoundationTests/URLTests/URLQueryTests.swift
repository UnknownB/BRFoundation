//
//  URLQueryTests.swift
//  
//
//  Created by BR on 2024/12/10.
//

import XCTest

final class URLQueryTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppendingQuery() throws {
        // 測試 URL Scheme (啟動 App 的自定義 URL)
        var url = URL(string: "MyApp")!
        url = url.br.appendingQuery(key: "key", value: "value")!
        XCTAssertEqual(url.absoluteString, "MyApp?key=value")
        
        url = URL(string: "MyApp://home")!
        url = url.br.appendingQuery(key: "key", value: "value")!
        XCTAssertEqual(url.absoluteString, "MyApp://home?key=value")

        // 測試原本有含值的情況
        url = URL(string: "MyApp://home?page=2")!
        url = url.br.appendingQuery(key: "key", value: "value")!
        XCTAssertEqual(url.absoluteString, "MyApp://home?page=2&key=value")

        // 測試 value 包含空白的情況
        url = URL(string: "MyApp://home?page=2")!
        url = url.br.appendingQuery(key: "key", value: "hello world!")!
        XCTAssertEqual(url.absoluteString, "MyApp://home?page=2&key=hello%2520world!")
    }
    
}
