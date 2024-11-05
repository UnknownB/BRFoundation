//
//  StringSearchTests.swift
//
//
//  Created by BR on 2024/10/27.
//

import XCTest

final class StringSearchTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - find(head:end:)
    
    func testFindWithValidHeadAndEnd() {
        let testString = "This is a [test] string with [head]content[end] after."
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNotNil(result, "Expected to find a substring between head and end.")
        XCTAssertEqual(result?.matchedSubstring, "[head]content[end]", "Incorrect matched substring.")
        XCTAssertEqual(result?.afterEndSubstring, " after.", "Incorrect substring after end.")
    }
    
    func testFindWithMissingHead() {
        let testString = "This string has no matching head or end."
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNil(result, "Expected nil result when head is missing.")
    }
    
    func testFindWithMissingEnd() {
        let testString = "This is a string with [head] but no end marker."
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNil(result, "Expected nil result when end is missing.")
    }
    
    func testFindWithHeadAndEndAtStartAndEnd() {
        let testString = "[head]This is all content[end]"
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNotNil(result, "Expected to find substring with head and end at start and end.")
        XCTAssertEqual(result?.matchedSubstring, "[head]This is all content[end]", "Incorrect matched substring.")
        XCTAssertEqual(result?.afterEndSubstring, "", "Expected an empty substring after end.")
    }
    
    func testFindWithMultipleHeadsAndEnds() {
        let testString = "Intro [head]first content[end] middle [head]second content[end] outro"
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNotNil(result, "Expected to find first instance of head and end.")
        XCTAssertEqual(result?.matchedSubstring, "[head]first content[end]", "Incorrect matched substring for first instance.")
        XCTAssertEqual(result?.afterEndSubstring, " middle [head]second content[end] outro", "Incorrect substring after first end.")
    }
    
    // MARK: - findBetween(head:end:)
    
    func testFindBetweenWithValidDelimiters() {
        let testString = "這是一段測試字符串 [start] 這是匹配內容 [end] 後續內容"
        let result = testString.findBetween(head: "[start]", end: "[end]")
        
        XCTAssertNotNil(result, "應該找到 start 和 end 的範圍")
        XCTAssertEqual(result?.matchedSubstring, " 這是匹配內容 ", "應該返回 start 和 end 之間的內容")
        XCTAssertEqual(result?.afterEndSubstring, " 後續內容", "應該返回 end 後的剩餘內容")
    }
    
    func testFindBetweenWithNoStartDelimiter() {
        let testString = "這是一段測試字符串 這是匹配內容 [end] 後續內容"
        let result = testString.findBetween(head: "[start]", end: "[end]")
        
        XCTAssertNil(result, "找不到 start 時應返回 nil")
    }
    
    func testFindBetweenWithNoEndDelimiter() {
        let testString = "這是一段測試字符串 [start] 這是匹配內容 後續內容"
        let result = testString.findBetween(head: "[start]", end: "[end]")
        
        XCTAssertNil(result, "找不到 end 時應返回 nil")
    }
    
    func testFindBetweenWithStartAdjacentToEnd() {
        let testString = "這是一段測試字符串 [start][end] 後續內容"
        let result = testString.findBetween(head: "[start]", end: "[end]")
        
        XCTAssertNotNil(result, "應該找到 start 和 end 的範圍")
        XCTAssertEqual(result?.matchedSubstring, "", "當 start 和 end 相鄰時應返回空字符串")
        XCTAssertEqual(result?.afterEndSubstring, " 後續內容", "應返回 end 後的剩餘內容")
    }
    
    func testFindBetweenWithIdenticalDelimiters() {
        let testString = "這是一段測試字符串 [start] 這是匹配內容 [start] 後續內容"
        let result = testString.findBetween(head: "[start]", end: "[start]")
        
        XCTAssertNotNil(result, "應該找到 start 到下一個 start 的範圍")
        XCTAssertEqual(result?.matchedSubstring, " 這是匹配內容 ", "應該返回第一次匹配到的 start 到下一個 start 之間的內容")
        XCTAssertEqual(result?.afterEndSubstring, " 後續內容", "應返回第二個 start 後的剩餘內容")
    }
}
