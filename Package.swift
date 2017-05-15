import PackageDescription

let package = Package(
    name: "VaporPostgreSQL",
    dependencies: [
        // PostgreSQL driver for Fluent
        .Package(url: "https://github.com/vapor/postgresql-driver.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
        // A provider for including Fluent in Vapor applications
        .Package(url: "https://github.com/vapor/fluent-provider.git", Version(1,0,0, prereleaseIdentifiers: ["beta"])),
        // A web framework and server for Swift that works on macOS and Ubuntu.
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
    ]
)
