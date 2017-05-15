import XCTest
import Vapor
@testable import PostgreSQLProvider

class VaporPostgreSQL: XCTestCase {
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

// import XCTest
// import Vapor
// @testable import PostgreSQLProvider
//
//
// class ProviderTests: XCTestCase {
//     static let allTests = [
//        ("testFileConfig", testFileConfig),
//        ("testFileConfigWithoutPortOrHost", testFileConfigWithoutPortOrHost),
//         ("testURLConfig", testURLConfig),
//         ("testURLConfigWithoutport", testURLConfigWithoutport),
//         ("testConfigWithAllOptions", testConfigWithAllOptions),
//         ("testConfigWithNoOptions", testConfigWithNoOptions)
//     ]
//
//     func testFileConfig() throws {
//         let config = try Config(node: [
//             "postgresql": [
//                 "hostname": "127.0.0.1",
//                 "user": "postgres",
//                 "password": "",
//                 "database": "test",
//                 "port": 5432
//             ]
//         ]
//
//         try config.addProvider(Provider.self)
//         let drop = try Droplet(config)
//         let database = try drop.assertDatabase()
//
//         XCTAssertNotNil(postgresql.driver.database)
//         let result = try database.raw("SELECT version()")
//     }
//
//     func testFileConfigWithoutPortOrHost() {
//         let config = try Config(node: [
//             "postgresql": [
//                 "user": "postgres",
//                 "password": "",
//                 "database": "test",
//             ]
//         ]
//
//         try config.addProvider(Provider.self)
//         let drop = try Droplet(config)
//         let database = try drop.assertDatabase()
//
//         XCTAssertNotNil(postgresql.driver.database)
//         let result = try database.raw("SELECT version()")
//
//         // do {
//         //     let config = Config(partialConfig)
//         //     let postgresql = try Provider.init(config: config)
//         //     print("Database config parsed successfully")
//         //     XCTAssertNotNil(postgresql.driver.database)
//         // } catch {
//         //     XCTFail("Could not parse config: \(error)")
//         // }
//     }
//
//     func testURLConfig() throws {
//         do {
//             let postgresql = try Provider.init(url: "psql://user:pass@host:5432/database")
//             print("Database config parsed successfully")
//             XCTAssertNotNil(postgresql.driver.database)
//         } catch {
//             XCTFail("Could not parse url: \(error)")
//         }
//     }
//
//     func testURLConfigWithoutport() throws {
//         do {
//             let postgresql = try Provider.init(url: "psql://user:pass@host/database")
//             print("Database config parsed successfully")
//             XCTAssertNotNil(postgresql.driver.database)
//         } catch {
//             XCTFail("Could not parse url: \(error)")
//         }
//     }
//
//     func testConfigWithAllOptions() throws {
//         do {
//             let postgresql = try Provider.init(hostname: "remotehost", port: 1234, database: "birdwatcher", user: "root", password: "")
//             print("Database config parsed successfully")
//             XCTAssertNotNil(postgresql.driver.database)
//         } catch {
//             XCTFail("Could not parse url: \(error)")
//         }
//     }
//
//     func testConfigWithNoOptions() throws {
//         do {
//             let postgresql = try Provider.init(dbname: "birdwatcher", user: "root", password: "")
//             print("Database config parsed successfully")
//             XCTAssertNotNil(postgresql.driver.database)
//         } catch {
//             XCTFail("Could not parse url: \(error)")
//         }
//     }
//
//     func testBoot() throws {
//         do {
//             let drop = Droplet()
//             let postgresql = try Provider.init(url: "psql://user:pass@host:5432/database")
//             postgresql.boot(drop)
//             XCTAssertNotNil(drop.database)
//         } catch {
//             XCTFail("Could prepare database: \(error)")
//         }
//     }
//
// }
