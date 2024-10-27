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
}