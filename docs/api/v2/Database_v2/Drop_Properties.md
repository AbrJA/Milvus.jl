# Drop Database Properties

**POST** `/v2/vectordb/databases/drop_properties`

This operation drops the specified properties of the specified database.

**Tags:** Database Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string) **(required)**: The name of the target database.
  - `propertyKeys` (array) **(required)**: The names of the properties to be dropped.

### Responses

**200:** Return an empty response.

- **Type:** `object`
