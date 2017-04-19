import URI
import Vapor
import Fluent
import FluentPostgreSQL

public final class Provider: Vapor.Provider {

    // PostgreSQL database driver created by the provider.
    public let driver: PostgreSQLDriver

    // Hold onto database until provider.boot is called.
    private var database: Database

    // Creates a PostgreSQL provider from a `postgresql.json` config file.
    //
    // The file should contain similar JSON:
    //
    // {
    //     "host": "127.0.0.1", // optional
    //     "user": "postgres",
    //     "password": "",
    //     "database": "test",
    //     "port": 5432 // optional
    // }

    public convenience init(config: Config) throws {
        guard let postgresql = config["postgresql"]?.object else {
            throw ConfigError.missingFile("postgresql")
        }

        if let url = postgresql["url"]?.string {
            try self.init(url: url)
        } else {
            guard let user = postgresql["user"]?.string else {
                throw ConfigError.missing(key: ["user"], file: "postgresql", desiredType: String.self)
            }

            guard let password = postgresql["password"]?.string else {
                throw ConfigError.missing(key: ["password"], file: "postgresql", desiredType: String.self)
            }

            guard let dbname = postgresql["database"]?.string else {
                throw ConfigError.missing(key: ["database"], file: "postgresql", desiredType: String.self)
            }

            let host = postgresql["host"]?.string
            let port = postgresql["port"]?.int

            try self.init(
                host: host ?? "localhost",
                port: port ?? 5432,
                dbname: dbname,
                user: user,
                password: password
            )
        }
    }

    /**
        Creates a PostgreSQL provider from a URL.

        "psql://user:pass@host:5432/database"

    */
    public convenience init(url: String) throws {
        let uri = try URI(url)
        guard
            let user = uri.userInfo?.username,
            let password = uri.userInfo?.info
        else {
            throw ConfigError.missing(key: ["url(userInfo)"], file: "postgresql", desiredType: URI.self)
        }

        let port = uri.port.flatMap { Int($0) }

        let dbname = uri.path
            .characters
            .split(separator: "/")
            .map { String($0) }
            .joined(separator: "")

        try self.init(
            host: uri.host,
            port: port ?? 5432,
            dbname: dbname,
            user: user,
            password: password
        )
    }

    // - host: May be either a host name or an IP address. Default is "localhost".
    // - port: Port number for the TCP/IP connection. Default is 5432. Can't be 0.
    // - dbname: Name of PostgreSQL database.
    // - user: Login ID of the PostgreSQL user.
    // - password: Password for user.
    // - throws: `Error.cannotEstablishConnection` if the call to connection fails.
    public init(
        host: String = "localhost",
        port: Int = 5432,
        dbname: String,
        user: String,
        password: String
    ) throws {
        let driver = PostgreSQLDriver(
            host: host,
            port: port,
            dbname: dbname,
            user: user,
            password: password
        )

        self.driver = driver
        self.database = Database(driver)
    }

    // See Vapor.Provider.boot
    public func boot(_ drop: Droplet) {
        if let existing = drop.database {
            drop.log.debug("VaporPostgreSQL overriding existing database: \(type(of: existing))")
        }
        drop.database = database
    }

    // See Vapor.Provider.afterInit
    public func afterInit(_ drop: Droplet) {
    }

    // See Vapor.Provider.beforeRun
    public func beforeRun(_ drop: Droplet) {
    }
}
