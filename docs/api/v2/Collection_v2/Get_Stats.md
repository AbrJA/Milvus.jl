# Get Collection Stats

**POST** `/v2/vectordb/collections/get_stats`

This operation gets the number of entities in a collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database which the collection belongs to. Setting this to a non-existing database results in an error.
  - `collectionName` (string) **(required)**: The name of the collection to check.
Setting this to a non-existing collection results in an error.

### Responses

**200:** The number of entities in a collection.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Statistics of the specified collection
    - `rowCount` (integer): The number of entities.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
