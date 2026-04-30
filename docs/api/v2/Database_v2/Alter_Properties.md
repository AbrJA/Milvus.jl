# Alter Database Properties

**POST** `/v2/vectordb/databases/alter`

This operation alters the properties of the specified database.

**Tags:** Database Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string) **(required)**: The name of the target database.
  - `properties` (object) **(required)**: The properties to be modified in key-value pairs.
    - `database.replica.number` (integer): The number of replicas for the specified database.
    - `database.resource_groups` (string): The names of the resource groups associated with the specified database in a common-separated list.
    - `database.diskQuota.mb` (integer): The maximum size of the disk space for the specified database, in megabytes (MB).
    - `database.max.collections` (integer): The maximum number of collections allowed in the specified database.
    - `database.force.deny.writing` (boolean): Whether to force the specified database to deny writing operations.
    - `database.force.deny.reading` (boolean): Whether to force the specified database to deny reading operations.

### Responses

**200:** Returns an empty response.

- **Type:** `object`
