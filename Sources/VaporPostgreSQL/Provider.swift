import Vapor
import FluentPostgreSQL

public final class Provider: Vapor.Provider {
    /*
        PostgreSQL database driver created by the provider 
    */
    public let driver: PostgreSQLDriver

    /*
        PostgreSQL database created by the provider
    */
    public let database: DatabaseDriver?

    /*
        Initialize PostgreSQL database running on host
        - parameter host: May be eitehr  a host name or an IP address. default localhost 
        - parameter port: If port is not 0 the value is used as the port number for the TCP/IP connection. default 5432
        - parameter dbname: Name of database
        - parameter user: PostgreSQL login ID
        - parameter password: Password for user
        - throws: Error.cannotEstablishConnection if the call to PostgreSQL fails. Note this attempts to execute a SELECT version() to the db to make sure there is a connection
    */
    public init(host: String = "localhost" , port: UInt = 5432, user: String, password: String, dbname: String) throws {
        let driver = PostgreSQLDriver(host: host, port: port, user: user, password: password, dbname: dbname)
        try driver.raw("SELECT version()")
        self.driver = driver 
        self.database = driver
    }

    public func boot(with drop: Droplet) { 

    }
}
