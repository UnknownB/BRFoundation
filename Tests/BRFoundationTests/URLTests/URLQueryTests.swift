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
    
    func testAppendingAndDecodedQueryDictionary() throws {
        // 測試 URL Scheme (啟動 App 的自定義 URL)
        var url = URL(string: "MyApp")!
        let query = ["key": "value", "string": "hello world!"]
        url = url.br.appendingQuery(from: query)!
        var decodedQuery = url.br.decodedQueryParameters()
        XCTAssertEqual(query, decodedQuery)
        
        url = URL(string: "MyApp://home")!
        url = url.br.appendingQuery(from: query)!
        decodedQuery = url.br.decodedQueryParameters()
        XCTAssertEqual(query, decodedQuery)

        // 測試原本有含值的情況
        url = URL(string: "MyApp://home?page=2")!
        url = url.br.appendingQuery(from: query)!
        decodedQuery = url.br.decodedQueryParameters()
        XCTAssertEqual(decodedQuery, ["page": "2", "key": "value", "string": "hello world!"])
        
        // 測試 url 原始字串包含編譯過的空白值
        url = URL(string: "MyApp://home?page=2&key=value&string=hello%2520world!")!
        decodedQuery = url.br.decodedQueryParameters()
        XCTAssertEqual(decodedQuery, ["page": "2", "key": "value", "string": "hello world!"])
        
        // 測試 url 不含任何 query 值
        url = URL(string: "MyApp")!
        decodedQuery = url.br.decodedQueryParameters()
        XCTAssertEqual(decodedQuery, [:])
    }
    
}
