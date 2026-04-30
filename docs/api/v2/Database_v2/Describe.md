# Describe Database

**POST** `/v2/vectordb/databases/describe`

This operation describes the specified database.

**Tags:** Database Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string) **(required)**: The name of the target database.

### Responses

**200:** Returns the properties of the specified database.

- **Type:** `object`
