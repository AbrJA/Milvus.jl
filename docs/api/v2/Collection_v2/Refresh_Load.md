# Refresh Load

**POST** `/v2/vectordb/collections/refresh_load`

This operaton refreshes the load of a collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database which the collection belongs to. Setting this to a non-existing database results in an error.
  - `collectionName` (string) **(required)**: The name of the collection to refresh.
Setting this to a non-existing collection results in an error.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
