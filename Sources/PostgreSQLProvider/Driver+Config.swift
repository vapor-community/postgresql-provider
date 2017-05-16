import URI
import Vapor
import Fluent
import PostgreSQLDriver

extension PostgreSQLDriver.Driver: ConfigInitializable {
    /// Creates a PostgreSQLDriver from a `postgresql.json`
    /// config file.
    ///
    /// The file should contain similar JSON:
    ///
    ///     {
    ///         "hostname": "127.0.0.1",
    ///         "user": "root",
    ///         "password": "",
    ///         "database": "test",
    ///         "port": 5432, // optional
    ///     }
    ///
    /// Optionally include a url instead:
    ///
    ///     {
    ///         "url": "postgresql://user:pass@host:3306/database"
    ///     }
    public convenience init(config: Config) throws {
        guard let postgresql = config["postgresql"]?.object else {
            throw ConfigError.missingFile("postgresql")
        }

        if let url = postgresql["url"]?.string {
            try self.init(url: url)
        } else {
            let masterHostname: String
            if let master = postgresql["hostname"]?.string {
                masterHostname = master
            } else if let master = postgresql["master"]?.string {
                masterHostname = master
            } else {
                throw ConfigError.missing(key: ["hostname"], file: "postgresql", desiredType: String.self)
            }
            
            let readReplicaHostnames: [String]
            if let array = postgresql["readReplicas"]?.array?.flatMap({ $0.string }) {
                readReplicaHostnames = array
            } else if let string = postgresql["readReplicas"]?.string {
                readReplicaHostnames = string.commaSeparatedArray()
            } else {
                readReplicaHostnames = []
            }
            
            guard let user = postgresql["user"]?.string else {
                throw ConfigError.missing(key: ["user"], file: "postgresql", desiredType: String.self)
            }

            guard let password = postgresql["password"]?.string else {
                throw ConfigError.missing(key: ["password"], file: "postgresql", desiredType: String.self)
            }

            guard let database = postgresql["database"]?.string else {
                throw ConfigError.missing(key: ["database"], file: "postgresql", desiredType: String.self)
            }

            let port = postgresql["port"]?.int

            try self.init(
                masterHostname: masterHostname,
                readReplicaHostnames: readReplicaHostnames,
                user: user,
                password: password,
                database: database,
                port: port ?? 5432
            )
        }
    }

    /// See PostgreSQLDriver.init(host: String, ...)
    public convenience init(url: String) throws {
        let uri = try URI(url)
        guard
            let user = uri.userInfo?.username,
            let pass = uri.userInfo?.info
        else {
            throw ConfigError.missing(key: ["url(userInfo)"], file: "postgresql", desiredType: URI.self)
        }

        let db = uri.path
            .characters
            .split(separator: "/")
            .map { String($0) }
            .joined(separator: "")

        try self.init(
            masterHostname: uri.hostname,
            readReplicaHostnames: [],
            user: user,
            password: pass,
            database: db,
            port: uri.port.flatMap { Int($0) } ?? 5432
        )
    }
}
