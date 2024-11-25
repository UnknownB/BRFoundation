//
//  ArrayRemoveTests.swift
//  
//
//  Created by BR on 2024/11/25.
//

import XCTest

final class ArrayRemoveTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    func testRemoveFirstOccurrence() {
        // 測試：移除第一個匹配的元素
        var array = [1, 2, 3, 2, 4]
        array = array.br.removingFirstOccurrence(of: 2)
        XCTAssertEqual(array, [1, 3, 2, 4], "Failed to remove first occurrence of 2")
        
        // 測試：移除不存在的元素
        var noMatchArray = [1, 2, 3, 4]
        noMatchArray = noMatchArray.br.removingFirstOccurrence(of: 5)
        XCTAssertEqual(noMatchArray, [1, 2, 3, 4], "Array should remain unchanged when element is not found")
        
        // 測試：移除唯一的元素
        var singleElementArray = [1]
        singleElementArray = singleElementArray.br.removingFirstOccurrence(of: 1)
        XCTAssertEqual(singleElementArray, [], "Failed to remove the only element in the array")
        
        // 測試：移除重複元素中的第一個
        var repeatedArray = [1, 1, 1]
        repeatedArray = repeatedArray.br.removingFirstOccurrence(of: 1)
        XCTAssertEqual(repeatedArray, [1, 1], "Failed to remove the first occurrence in an array with all identical elements")
        
        // 測試：空陣列
        var emptyArray: [Int] = []
        emptyArray = emptyArray.br.removingFirstOccurrence(of: 1)
        XCTAssertEqual(emptyArray, [], "Empty array should remain unchanged")
    }

    
}
