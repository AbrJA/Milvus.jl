# List Collections

**POST** `/v2/vectordb/collections/list`

This operation lists all collection names.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of an existing database.

### Responses

**200:** This operation lists all collections in the database used in the current connection.

- **Type:** `object`
