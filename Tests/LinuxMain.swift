#if os(Linux)

import XCTest
@testable import VaporPostgreSQLTests

XCTMain([
    testCase(VaporPostgreSQL.allTests),
])

#endif
