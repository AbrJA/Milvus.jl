# Alter Index Properties

**POST** `/v2/vectordb/indexes/alter_properties`

This operation alters the properties of an index.

**Tags:** Index Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database that to which the collection belongs .
Setting this to a non-existing database results in an error.
  - `collectionName` (string) **(required)**: The name of the target collection.
Setting this to a non-existing collection results in an error.
  - `indexName` (string) **(required)**: The name of the target index.
  - `properties` (object) **(required)**: The new index parameters to be set.
    - `mmap.enabled` (boolean): Whether to enable memory mapping for the current index.

### Responses

**200:** Returns an empty response.

- **Type:** `object`
