// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "PostgreSQLProvider",
    products: [
        .library(name: "PostgreSQLProvider", targets: ["PostgreSQLProvider"]),
    ],
    dependencies: [
        // PostgreSQL driver for Fluent
        .package(url: "https://github.com/vapor-community/postgresql-driver.git", .upToNextMajor(from: "2.1.0")),
        
        // A provider for including Fluent in Vapor applications
        .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.2.0")),

        // A web framework and server for Swift that works on macOS and Ubuntu.
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.0"))
    ],
    targets: [
        .target(name: "PostgreSQLProvider", dependencies: ["PostgreSQLDriver", "FluentProvider", "Vapor"]),
        .testTarget(name: "PostgreSQLProviderTests", dependencies: ["PostgreSQLProvider"]),
    ]
)
