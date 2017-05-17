import PackageDescription

let package = Package(
    name: "PostgreSQLProvider",
    dependencies: [
        // PostgreSQL driver for Fluent
        .Package(url: "https://github.com/vapor/postgresql-driver.git", majorVersion: 2),
        // A provider for including Fluent in Vapor applications
        .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 1),
        // A web framework and server for Swift that works on macOS and Ubuntu.
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
    ]
)
