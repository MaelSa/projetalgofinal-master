import XCTest
@testable import library

final class libraryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(library().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
