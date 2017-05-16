![Travis Build](https://travis-ci.org/vapor/postgresql-provider.svg?branch=master)

# PostgreSQL Provider for Vapor
Adds PostgreSQL support to the Vapor web framework.

## Setup
Add the dependency to Package.swift

```JSON
.Package(url: "https://github.com/vapor/postgresql-provider.git", majorVersion: 2, minor: 0)
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

 `config/fluent.json`
```json
  "driver": "postgresql"
```

## Configure PostgreSQL
### Basic
Here is an example of a simple PostgreSQL configuration file.

 `config/secrets/postgresql.json`
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

 `config/secrets/postgresql.json`
```json
{
    "url": "psql://user:pass@hostname:5432/database"
}
```

### Read Replicas
Read replicas can be supplied by passing a single `master` hostname and an array of `readReplicas` hostnames.

 `config/secrets/postgresql.json`
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

### Driver¶
You can get access to the PostgreSQL Driver on the droplet.

```swift
import Vapor
import PostgreSQLProvider

let postgresqlDriver = try drop.postgresql()
```
