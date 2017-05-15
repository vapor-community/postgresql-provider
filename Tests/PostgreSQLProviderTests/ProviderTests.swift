import XCTest
import Vapor
@testable import PostgreSQLProvider

class ProviderTests: XCTestCase {
    func testHappyPath() throws {
        let config = try Config(node: [
            "fluent": [
                "driver": "postgresql",
                "maxConnections": 1337
            ],
            "postgresql": [
                "hostname": "127.0.0.1",
                "user": "ubuntu",
                "password": "",
                "database": "circle_test"
            ]
        ])
        
        try config.addProvider(Provider.self)
        let drop = try Droplet(config)
        let database = try drop.assertDatabase()
        
        XCTAssertNotNil(database)
        XCTAssertEqual(database.threadConnectionPool.maxConnections, 1337)
    }

    func testDifferentDriver() throws {
        var config = Config([:])
        try config.set("fluent.driver", "memory")
        try config.addProvider(Provider.self)
        let drop = try Droplet(config: config)
        
        // we're still adding the VaporPostgreSQL provider,
        // but nothing should fail since we are specifying "memory"
        _ = try drop.assertDatabase()
    }

    func testMissingConfigFails() throws {
        let config = try Config(node: [
            "fluent": [
                "driver": "postgresql"
            ]
        ])
        try config.addProvider(Provider.self)

        do {
            _ = try Droplet(config)
            XCTFail("Should have failed.")
        } catch ConfigError.missingFile(let file) {
            XCTAssert(file == "postgresql")
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }

    static let allTests = [
        ("testHappyPath", testHappyPath),
        ("testDifferentDriver", testDifferentDriver),
        ("testMissingConfigFails", testMissingConfigFails)
    ]
}
