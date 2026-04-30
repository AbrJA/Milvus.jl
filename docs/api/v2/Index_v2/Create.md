# Create Index

**POST** `/v2/vectordb/indexes/create`

This creates a named index for a target field, which can either be a vector field or a scalar field.

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
  - `indexParams` (array) **(required)**: The parameters that apply to the index-building process.

### Responses

**200:** None

- **Type:** `object`
