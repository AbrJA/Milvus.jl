# Rename Collection

**POST** `/v2/vectordb/collections/rename`

This operation renames an existing collection and optionally moves the collection to a new database.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `collectionName` (string) **(required)**: The name of the target collection.
Setting this to a non-existing collection results in an error.
  - `dbName` (string): The name of the database that to which the collection belongs .
Setting this to a non-existing database results in an error.
  - `newDbName` (string): The name of the database to which the collection belongs after this operation.
The value defaults to **default**. Setting this to a database rather than the one the collection belongs to before this operation moves this collection to the specified database.
Setting this to a non-existing database results in an error.
  - `newCollectionName` (string) **(required)**: The name of the target collection after this operation.
Setting this to the value of **old_collection_name** results in an error.

### Responses

**200:** None

**success:**

- **Type:** `object`
- **Description:** A success response
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which is an empty object.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
