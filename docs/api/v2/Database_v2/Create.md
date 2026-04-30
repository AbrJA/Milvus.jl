# Create Database

**POST** `/v2/vectordb/databases/create`

This operation creates a new database in the specified cluster.

**Tags:** Database Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string) **(required)**: The name of the new database.
  - `properties` (object): The properties of the new database in key-value pairs.
    - `database.replica.number` (integer): The number of replicas for the new database.
    - `database.resource_groups` (string): The names of the resource groups associated with the new database in a common-separated list.
    - `database.diskQuota.mb` (integer): The maximum size of the disk space for the new database, in megabytes (MB).
    - `database.max.collections` (integer): The maximum number of collections allowed in the new database.
    - `database.force.deny.writing` (boolean): Whether to force the new database to deny writing operations.
    - `database.force.deny.reading` (boolean): Whether to force the new database to deny reading operations.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
