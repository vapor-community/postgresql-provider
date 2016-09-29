# PostgreSQL Provider for Vapor

Adds PostgreSQL support to the Vapor web framework.


```swift
let postgresql = try VaporPostgreSQL.Provider(user: "root", password: "", dbname: "birdwatcher")

let app = Droplet(providers: [postgresql])
```

## Install and link PostgreSQL

Follow the instructions at [vapor/postgresql](https://github.com/vapor/postgresql) to properly install and link PostgreSQL.
