//
//  octospoonTests.swift
//  octospoonTests
//
//  Created by Ben Frearson on 09/01/2024.
//

import XCTest
@testable import octospoon

final class octospoonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_examplePass_shouldPass() throws {
        XCTAssertTrue(true, "This test will always pass")
    }

    func disabled_test_exampleFail_shouldFail() throws {
        XCTFail("This test will always fail")
    }

}
