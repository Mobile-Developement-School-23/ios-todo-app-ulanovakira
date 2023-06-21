//
//  TodoItemTests.swift
//  TodoItemTests
//
//  Created by Кира on 14.06.2023.
//

import XCTest
@testable import TodoItem

final class TodoItemTests: XCTestCase {
    
    var item1 = TodoItem(id: "Walk", text: "Go for a walk", doneFlag: false, importance: .normal)
    var item2 = TodoItem(text: "Dow my HW", doneFlag: false, importance: .important)

    func testExample() throws {
        XCTAssertNotNil(item2.id)
        XCTAssertEqual(item1.id, "Walk")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
