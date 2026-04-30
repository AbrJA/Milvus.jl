# Create Alias

**POST** `/v2/vectordb/aliases/create`

This operation creates an alias for an existing collection. A collection can have multiple aliases, while an alias can be associated with only one collection.

**Tags:** Alias Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database to which the collection belongs.
  - `collectionName` (string) **(required)**: The name of the target collection to assign the created alias to.
  - `aliasName` (string) **(required)**: The alias of the collection. 

### Responses

**200:** None

**success:**

- **Type:** `object`
- **Description:** A success response
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which is an empty object.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
