# Upsert

**POST** `/v2/vectordb/entities/upsert`

This operation inserts new records into the database or updates existing ones.

**Tags:** Vector Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database.
  - `collectionName` (string) **(required)**: The name of the collection in which to upsert data.
  - `partitionName` (string): The name of a partition in the current collection. 
If specified, the data is to be inserted into the specified partition.
  - `data` (object) **(required)**: An entity object or an array of entity objects. Note that the keys in an entity object should match the collection schema

### Responses

**200:** A MutationResult object.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which carries the result of the upsert operation.
    - `upsertCount` (integer): The number of upserted entities.
    - `upsertIds` (array): An array of the IDs of upserted entities.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
