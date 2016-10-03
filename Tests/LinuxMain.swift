#if os(Linux)

import XCTest
@testable import VaporPostgreSQLTests

XCTMain([
    testCase(PostgreSQLTests.allTests),
])

#endif
