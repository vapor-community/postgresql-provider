import XCTest
@testable import VaporPostgreSQL
import Fluent


class VaporPostgreSQL: XCTestCase {
    static let allTests = [
        ("testBasic", testBasic)
    ]

    func testBasic() {
        XCTAssertEqual(2 + 2, 4)
    }
}
