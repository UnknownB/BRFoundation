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
    
    
    

}
