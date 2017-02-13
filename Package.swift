import PackageDescription

let package = Package(
    name: "VaporPostgreSQL",
    dependencies: [
        .Package(url: "https://github.com/vapor/postgresql-driver.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"])),
    ]
)
