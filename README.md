![Travis Build](https://travis-ci.org/vapor/postgresql-provider.svg?branch=master)

# PostgreSQL Provider for Vapor

Adds PostgreSQL support to the Vapor web framework.

## Usage

```swift
import Vapor
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider.self)
```

## Config

To build, create a `postgresql.json` file in the `Config/secrets` folder.
You may need to create the `secrets` folder if it does not exist. The secrets
folder is under the gitignore and shouldn't be committed.

Here's an example `Config/secrets/postgresql.json`

```json
{
    "host": "127.0.0.1",
    "user": "postgres",
    "password": "",
    "database": "test",
    "port": 5432
}
```

Or, just set a url.

```json
{
    "url": "psql://user:pass@host:5432/database"
}
```

## Install and link PostgreSQL

Follow the instructions at [vapor/postgresql](https://github.com/vapor/postgresql) to properly install and link PostgreSQL.
