import XCTest
@testable import RefreshableSubject

final class RefreshableSubjectTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RefreshableSubject().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
