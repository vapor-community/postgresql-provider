public enum PostgreSQLProviderError: Error {
    case invalidFluentDriver(Fluent.Driver)
    case unspecified(Error)
}

extension PostgreSQLProviderError: Debuggable {
    public var reason: String {
        switch self {
        case .invalidFluentDriver(let driver):
            return "Invalid Fluent driver: \(type(of: driver)). PostgreSQL driver required."
        case .unspecified(let error):
            return "Unknown: \(error)"
        }
    }
    
    public var identifier: String {
        switch self {
        case .invalidFluentDriver:
            return "invalidFluentDriver"
        case .unspecified:
            return "unknown"
        }
    }
    
    public var possibleCauses: [String] {
        switch self {
        case .invalidFluentDriver:
            return [
                "You have not added the `PostgreSQLProvider.Provider` to your Droplet.",
                "You have not specified `postgresql` in the `fluent.json` file.",
                "`drop.database` is getting set programatically to a non-PostgreSQL database"
            ]
        case .unspecified:
            return []
        }
    }
    
    public var suggestedFixes: [String] {
        return [
            "Ensure you have properly configured the PostgreSQLProvider package according to the documentation"
        ]
    }
    
    public var documentationLinks: [String] {
        return [
            "https://docs.vapor.codes/2.0/postgresql/package/"
        ]
    }
}
