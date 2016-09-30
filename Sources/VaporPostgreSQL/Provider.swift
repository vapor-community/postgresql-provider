import URI
import Vapor
import Fluent
import FluentPostgreSQL

public typealias PostgreSQLDriver = FluentPostgreSQL.PostgreSQLDriver

public final class Provider: Vapor.Provider {
    public let provided: Providable

    public enum Error: Swift.Error {
        case noPostgreSQLConfig
        case missingConfig(String)
    }

    /**
        PostgreSQL database driver created by the provider.
    */
    public let driver: PostgreSQLDriver

    /**
        Creates a PostgreSQL provider from a `postgresql.json` config file.

        The file should contain similar JSON:

            {
                "host": "127.0.0.1",
                "user": "postgres",
                "password": "",
                "database": "test",
                "port": 5432, // optional
            }

        Optionally include a url instead:

            {
                "url": "psql://user:pass@host:5432/database"
            }

    */
    public convenience init(config: Config) throws {
        guard let postgresql = config["postgresql"]?.object else {
            throw Error.noPostgreSQLConfig
        }

        if let url = postgresql["url"]?.string {
            try self.init(url: url)
        } else {
            guard let host = postgresql["host"]?.string else {
                throw Error.missingConfig("host")
            }

            guard let user = postgresql["user"]?.string else {
                throw Error.missingConfig("user")
            }

            guard let password = postgresql["password"]?.string else {
                throw Error.missingConfig("password")
            }

            guard let dbname = postgresql["database"]?.string else {
                throw Error.missingConfig("database")
            }

            let port = postgresql["port"]?.int

            try self.init(
                host: host,
                port: port!,
                dbname: dbname,
                user: user,
                password: password
            )
        }
    }

    public convenience init(url: String) throws {
        let uri = try URI(url)
        guard
            let user = uri.userInfo?.username,
            let password = uri.userInfo?.info else {
                throw Error.missingConfig("UserInfo")
            }

        let port = uri.port.flatMap { Int($0) }

        let dbname = uri.path
            .characters
            .split(separator: "/")
            .map { String($0) }
            .joined(separator: "")

        try self.init(
            host: uri.host,
            port: port!,
            dbname: dbname,
            user: user,
            password: password
        )
    }

    /**
    - host: May be either a host name or an IP address. Default is "localhost".
    - port: Port number for the TCP/IP connection. Default is 5432. Can't be 0.
    - dbname: Name of PostgreSQL database.
    - user: Login ID of the PostgreSQL user.
    - password: Password for user.
    - throws: `Error.cannotEstablishConnection` if the call to connection fails.
    */
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

        let database = Database(driver)
        provided = Providable(database: database)
    }

    /**
        Called after the Droplet has completed
        initialization and all provided items
        have been accepted.
    */
    public func afterInit(_ drop: Droplet) {
    }

    /**
        Called before the Droplet begins serving
        which is @noreturn.
    */
    public func beforeRun(_ drop: Droplet) {
    }
}
