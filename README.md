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

let drop = Droplet()
try drop.addProvider(PostgreSQLProvider.Provider.self)
```

## Config

To build, create a `postgresql.json` file in the `Config/secrets` folder.
You may need to create the `secrets` folder if it does not exist. The `secrets`
folder is in the .gitignore and shouldn't be committed.

Here's an example `Config/secrets/postgresql.json`

```json
{
    "hostname": "127.0.0.1",
    "user": "postgres",
    "password": "",
    "database": "test",
    "port": 5432
}
```

Or, just set a url.

```json
{
    "url": "psql://user:pass@hostname:5432/database"
}
```
