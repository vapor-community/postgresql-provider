[![Swift](https://img.shields.io/badge/swift-3.1_--_4.0-brightgreen.svg)](https://swift.org)
[![Linux Build Status](https://img.shields.io/circleci/project/github/vapor-community/postgresql-provider.svg?label=Linux)](https://circleci.com/gh/vapor-community/postgresql-provider)
[![macOS Build Status](https://img.shields.io/travis/vapor-community/postgresql-provider.svg?label=macOS)](https://travis-ci.org/vapor-community/postgresql-provider)
[![codecov](https://codecov.io/gh/vapor-community/postgresql-provider/branch/master/graph/badge.svg)](https://codecov.io/gh/vapor-community/postgresql-provider)
[![GitHub license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)

# PostgreSQL Provider for Vapor
Adds PostgreSQL support to the Vapor web framework.

## Setup
Add the dependency to Package.swift

```JSON
.Package(url: "https://github.com/vapor-community/postgresql-provider.git", majorVersion: 2, minor: 0)
```

## Usage

```swift
import Vapor
import PostgreSQLProvider

let config = try Config()
try config.addProvider(PostgreSQLProvider.Provider.self)

let drop = try Droplet(config)
```

## Configure Fluent
Once the provider is added to your Droplet, you can configure Fluent to use the PostgreSQL driver.

 `Config/fluent.json`
 
```json
  "driver": "postgresql"
```

## Configure PostgreSQL
### Basic
Here is an example of a simple PostgreSQL configuration file.

 `Config/secrets/postgresql.json`
 
```json
{
    "hostname": "127.0.0.1",
    "user": "postgres",
    "password": "hello",
    "database": "test",
    "port": 5432
}
```

Alternatively, you can set a url with the configuration parameters.

 `Config/secrets/postgresql.json`
 
```json
{
    "url": "psql://user:pass@hostname:5432/database"
}
```

### Read Replicas
Read replicas can be supplied by passing a single `master` hostname and an array of `readReplicas` hostnames.

 `Config/secrets/postgresql.json`
 
```json
{
    "master": "master.postgresql.foo.com",
    "readReplicas": ["read01.postgresql.foo.com", "read02.postgresql.foo.com"],
    "user": "postgres",
    "password": "hello",
    "database": "test",
    "port": 5432
}
```

### Driver
You can get access to the PostgreSQL Driver on the droplet.

```swift
import Vapor
import PostgreSQLProvider

let postgresqlDriver = try drop.postgresql()
```
