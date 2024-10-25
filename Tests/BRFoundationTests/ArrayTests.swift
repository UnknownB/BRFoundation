//
//  ArrayTests.swift
//
//
//  Created by BR on 2024/10/25.
//

import XCTest

final class ArrayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testReplaceAll() {
        // 測試整數陣列
        var array = [1, 2, 3, 4, 2, 5]
        array.replaceAll(where: { $0 == 2 }, with: 99)
        XCTAssertEqual(array, [1, 99, 3, 4, 99, 5], "Failed to replace all instances of 2 with 99")
        
        // 測試字串陣列
        var stringArray = ["apple", "banana", "apple", "cherry"]
        stringArray.replaceAll(where: { $0 == "apple" }, with: "orange")
        XCTAssertEqual(stringArray, ["orange", "banana", "orange", "cherry"], "Failed to replace all instances of 'apple' with 'orange'")
        
        // 測試空陣列
        var emptyArray: [Int] = []
        emptyArray.replaceAll(where: { $0 == 1 }, with: 99)
        XCTAssertEqual(emptyArray, [], "Empty array should remain unchanged")
        
        // 測試無匹配
        var noMatchArray = [1, 2, 3]
        noMatchArray.replaceAll(where: { $0 == 99 }, with: 42)
        XCTAssertEqual(noMatchArray, [1, 2, 3], "Array should remain unchanged when no matches found")
    }
    
    
    func testRemoveFirstOccurrence() {
        // 測試：移除第一個匹配的元素
        var array = [1, 2, 3, 2, 4]
        array.removeFirstOccurrence(of: 2)
        XCTAssertEqual(array, [1, 3, 2, 4], "Failed to remove first occurrence of 2")
        
        // 測試：移除不存在的元素
        var noMatchArray = [1, 2, 3, 4]
        noMatchArray.removeFirstOccurrence(of: 5)
        XCTAssertEqual(noMatchArray, [1, 2, 3, 4], "Array should remain unchanged when element is not found")
        
        // 測試：移除唯一的元素
        var singleElementArray = [1]
        singleElementArray.removeFirstOccurrence(of: 1)
        XCTAssertEqual(singleElementArray, [], "Failed to remove the only element in the array")
        
        // 測試：移除重複元素中的第一個
        var repeatedArray = [1, 1, 1]
        repeatedArray.removeFirstOccurrence(of: 1)
        XCTAssertEqual(repeatedArray, [1, 1], "Failed to remove the first occurrence in an array with all identical elements")
        
        // 測試：空陣列
        var emptyArray: [Int] = []
        emptyArray.removeFirstOccurrence(of: 1)
        XCTAssertEqual(emptyArray, [], "Empty array should remain unchanged")
    }
    

}
