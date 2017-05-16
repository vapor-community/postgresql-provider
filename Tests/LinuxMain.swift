#if os(Linux)

import XCTest
@testable import PostgreSQLProviderTests

XCTMain([
    testCase(ProviderTests.allTests),
])

#endif
