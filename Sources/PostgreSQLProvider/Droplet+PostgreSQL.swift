import Vapor

extension Droplet {
    /// Returns the current PostgreSQL driver or throws an error.
    /// This is a convenience for casting the
    /// drop.database.driver as a PostgreSQLDriver type.
    public func postgresql() throws -> PostgreSQLDriver.Driver {
        let database = try assertDatabase()
        
        guard let driver = database.driver as? PostgreSQLDriver.Driver else {
            throw PostgreSQLProviderError.invalidFluentDriver(database.driver)
        }
        
        return driver
    }
}
