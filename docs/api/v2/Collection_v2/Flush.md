# Flush Collection

**POST** `/v2/vectordb/collections/flush`

This operation flushes the streaming data and seals segments. It is recommended to call this operation after all the data has been inserted into a collection.

**Tags:** Collection Operations (V2)

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

### Responses

**200:** Return an empty response.

- **Type:** `object`
