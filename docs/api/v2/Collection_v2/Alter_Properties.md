# Alter Collection Properties

**POST** `/v2/vectordb/collections/alter_properties`

This operation alters the properties of a collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database which the collection belongs to. Setting this to a non-existing database results in an error.
  - `collectionName` (string) **(required)**: The name of the target collection.
Setting this to a non-existing collection results in an error.
  - `properties` (object) **(required)**: The properties of the collection to alter.
    - `mmmap.enabled` (boolean): Whether to enable the memory-mapped feature for the collection. Setting this to `true` allows the collection to be accessed directly from disk without loading it into memory, which can extend collection capacity.
    - `collection.ttl.seconds` (integer): The time-to-live (TTL) of the collection in seconds. Setting this to a non-zero values enables automatic deletion of expired documents from the collection after the specified number of seconds.
    - `partitionkey.isolation` (boolean): Whether to enable partition key isolation for the collection. Setting this to `true` ensures that documents with the same partition key are always stored in the same partition, which can improve query performance.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
