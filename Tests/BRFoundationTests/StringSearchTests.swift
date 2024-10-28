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
    
    func testFindWithHeadAndEndPresent() {
        let testString = "Start [head] content [end] remaining"
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertEqual(result.matchedSubstring, "[head] content [end]", "Expected to match content between [head] and [end]")
        XCTAssertEqual(result.afterEndSubstring, " remaining", "Expected remaining string after [end]")
    }
    
    func testFindWithNoHead() {
        let testString = "No head marker here [end]"
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNil(result.matchedSubstring, "Expected matchedSubstring to be nil when head is not found")
        XCTAssertEqual(result.afterEndSubstring, testString, "Expected afterEndSubstring to be the entire string when head is not found")
    }
    
    func testFindWithNoEndAfterHead() {
        let testString = "Contains [head] but no end marker"
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNil(result.matchedSubstring, "Expected matchedSubstring to be nil when end is not found after head")
        XCTAssertEqual(result.afterEndSubstring, testString, "Expected afterEndSubstring to be the entire string when end is not found after head")
    }
    
    func testFindWithEmptyString() {
        let testString = ""
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertNil(result.matchedSubstring, "Expected matchedSubstring to be nil for an empty string")
        XCTAssertEqual(result.afterEndSubstring, "", "Expected afterEndSubstring to be empty for an empty input string")
    }
    
    func testFindWithMultipleHeadAndEndPairs() {
        let testString = "Prefix [head] first [end] and [head] second [end] suffix"
        let result = testString.find(head: "[head]", end: "[end]")
        
        XCTAssertEqual(result.matchedSubstring, "[head] first [end]", "Expected to match only the first [head]...[end] pair")
        XCTAssertEqual(result.afterEndSubstring, " and [head] second [end] suffix", "Expected remaining string after the first [end] marker")
    }
    
    func testFindHeadEqualsEnd() {
        let testString = "This is [marker] content [marker] with more text"
        let result = testString.find(head: "[marker]", end: "[marker]")
        
        XCTAssertEqual(result.matchedSubstring, "[marker] content [marker]", "Expected to match content between identical head and end markers")
        XCTAssertEqual(result.afterEndSubstring, " with more text", "Expected remaining string after the matched segment")
    }
    
    // MARK: - find(head:to:)
    
    func testFindWithValidHeadAndEnd() {
        let testString = "這是一段測試字符串 [head] 這是匹配內容 [end] 後續內容"
        let result = testString.find(head: "[head]", to: "[end]")
        
        XCTAssertEqual(result.matchedSubstring, " 這是匹配內容 ", "應該返回 head 到 end 之間的內容")
        XCTAssertEqual(result.afterEndSubstring, " 後續內容", "應該返回 end 後的剩餘內容")
    }
    
    func testFindWithNotHead() {
        let testString = "這是一段測試字符串 這是匹配內容 [end] 後續內容"
        let result = testString.find(head: "[head]", to: "[end]")
        
        XCTAssertNil(result.matchedSubstring, "找不到 head 時應該返回 nil")
        XCTAssertEqual(result.afterEndSubstring, testString, "找不到 head 時應返回原始字符串作為 afterEndSubstring")
    }
    
    func testFindWithNoEnd() {
        let testString = "這是一段測試字符串 [head] 這是匹配內容 後續內容"
        let result = testString.find(head: "[head]", to: "[end]")
        
        XCTAssertNil(result.matchedSubstring, "找不到 end 時應該返回 nil")
        XCTAssertEqual(result.afterEndSubstring, testString, "找不到 end 時應返回原始字符串作為 afterEndSubstring")
    }
    
    func testFindWithHeadAdjacentToEnd() {
        let testString = "這是一段測試字符串 [head][end] 後續內容"
        let result = testString.find(head: "[head]", to: "[end]")
        
        XCTAssertEqual(result.matchedSubstring, "", "當 head 和 end 相鄰時應返回空字符串")
        XCTAssertEqual(result.afterEndSubstring, " 後續內容", "應返回 end 後的剩餘內容")
    }
    
    func testFindWithHeadEqualsEnd() {
        let testString = "這是一段測試字符串 [head] 這是匹配內容 [head] 後續內容"
        let result = testString.find(head: "[head]", to: "[head]")
        
        XCTAssertEqual(result.matchedSubstring, " 這是匹配內容 ", "應該返回第一次匹配到的 head 到 end 之間的內容")
        XCTAssertEqual(result.afterEndSubstring, " 後續內容", "應返回第二個 head 後的剩餘內容")
    }
}
