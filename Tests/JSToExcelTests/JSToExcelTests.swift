import XCTest
@testable import JSToExcel

final class JSToExcelTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(JSToExcel().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
