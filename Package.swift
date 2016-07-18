import PackageDescription

let package = Package(
    name: "VaporPostgreSQL",
    dependencies: [
   		 .Package(url: "https://github.com/qutheory/fluent-postgresql.git", majorVersion: 0, minor: 2),
   		 .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 14)
    ]
)
