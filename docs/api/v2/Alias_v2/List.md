# List Aliases

**POST** `/v2/vectordb/aliases/list`

This operation lists all existing collection aliases in the specified databaseZilliz Cloud cluster.

**Tags:** Alias Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of an existing database.
  - `collectionName` (string): The name of an existing collection. If specified, only returns aliases of the specified collection. If not specified, returns aliases of all collections in the database.

### Responses

**200:** A list of collection aliases. 

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): Response payload which is a list of item objects.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
