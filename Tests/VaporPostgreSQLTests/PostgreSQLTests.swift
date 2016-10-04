import XCTest
@testable import VaporPostgreSQL
import Fluent


class VaporPostgreSQL: XCTestCase {
    static let allTests = [
        ("testURLConfig", testURLConfig),
        ("testURLConfigWithoutport", testURLConfigWithoutport),
        ("testConfigWithAllOptions", testConfigWithAllOptions),
        ("testConfigWithNoOptions", testConfigWithNoOptions)
    ]

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
}
