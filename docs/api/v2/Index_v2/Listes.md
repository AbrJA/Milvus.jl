# List Indexes

**POST** `/v2/vectordb/indexes/list`

This operation lists all indexes of a specific collection.

**Tags:** Index Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database to which the collection belongs.
  - `collectionName` (string) **(required)**: The name of an existing collection. Setting this to a non-existing collection leads to an error.

### Responses

**200:** An object that contains the names of all built indexes.

- **Type:** `object`
