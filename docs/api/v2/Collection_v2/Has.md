# Has Collection

**POST** `/v2/vectordb/collections/has`

This operation checks whether a collection exists.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database in which to check the existence of a collection.
  - `collectionName` (string) **(required)**: The name of an existing collection.

### Responses

**200:** A boolean value indicates whether the specified collection exists.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which carries a boolean value.
    - `has` (boolean): A boolean value indicates whether the specified collection exists.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
