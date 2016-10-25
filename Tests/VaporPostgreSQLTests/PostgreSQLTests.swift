import XCTest
import Fluent
import Node
import Settings
import Vapor
@testable import VaporPostgreSQL


class VaporPostgreSQL: XCTestCase {
    static let allTests = [
       ("testFileConfig", testFileConfig),
       ("testFileConfigWithoutPortOrHost", testFileConfigWithoutPortOrHost),
        ("testURLConfig", testURLConfig),
        ("testURLConfigWithoutport", testURLConfigWithoutport),
        ("testConfigWithAllOptions", testConfigWithAllOptions),
        ("testConfigWithNoOptions", testConfigWithNoOptions)
    ]

    func testFileConfig() throws {
        let fullConfig: Node = [
            "postgresql": [
                "host": "127.0.0.1",
                "user": "postgres",
                "password": "",
                "database": "test",
                "port": 5432
            ]
        ]

        do {
            let config = Config(fullConfig)
            let postgresql = try Provider.init(config: config)
            print("Database config parsed successfully")
            XCTAssertNotNil(postgresql.driver.database)
        } catch {
            XCTFail("Could not parse config: \(error)")
        }
    }

    func testFileConfigWithoutPortOrHost() {
        let partialConfig: Node = [
            "postgresql": [
                "user": "postgres",
                "password": "",
                "database": "test",
            ]
        ]

        do {
            let config = Config(partialConfig)
            let postgresql = try Provider.init(config: config)
            print("Database config parsed successfully")
            XCTAssertNotNil(postgresql.driver.database)
        } catch {
            XCTFail("Could not parse config: \(error)")
        }
    }

    func testURLConfig() throws {
        do {
            let postgresql = try Provider.init(url: "psql://user:pass@host:5432/database")
            print("Database config parsed successfully")
            XCTAssertNotNil(postgresql.driver.database)
        } catch {
            XCTFail("Could not parse url: \(error)")
        }
    }

    func testURLConfigWithoutport() throws {
        do {
            let postgresql = try Provider.init(url: "psql://user:pass@host/database")
            print("Database config parsed successfully")
            XCTAssertNotNil(postgresql.driver.database)
        } catch {
            XCTFail("Could not parse url: \(error)")
        }
    }

    func testConfigWithAllOptions() throws {
        do {
            let postgresql = try Provider.init(host: "remotehost", port: 1234, dbname: "birdwatcher", user: "root", password: "")
            print("Database config parsed successfully")
            XCTAssertNotNil(postgresql.driver.database)
        } catch {
            XCTFail("Could not parse url: \(error)")
        }
    }

    func testConfigWithNoOptions() throws {
        do {
            let postgresql = try Provider.init(dbname: "birdwatcher", user: "root", password: "")
            print("Database config parsed successfully")
            XCTAssertNotNil(postgresql.driver.database)
        } catch {
            XCTFail("Could not parse url: \(error)")
        }
    }

    func testBoot() throws {
        do {
            let drop = Droplet()
            let postgresql = try Provider.init(url: "psql://user:pass@host:5432/database")
            postgresql.boot(drop)
            XCTAssertNotNil(drop.database)
        } catch {
            XCTFail("Could prepare database: \(error)")
        }
    }

}
