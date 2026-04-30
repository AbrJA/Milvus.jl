# Drop Alias

**POST** `/v2/vectordb/aliases/drop`

This operation drops a specified alias. 

**Tags:** Alias Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database to which the collection belongs.
  - `collectionName` (string): The name of the collection to which the alias is assigned to.
  - `aliasName` (string) **(required)**: The alias to drop.
When dropping an alias, you do not need to provide the collection name because one alias can only be assigned to exactly one collection. Therefore, the server knows which collection the specified alias belongs to.

### Responses

**200:** Return an empty object or an error message.

**success:**

- **Type:** `object`
- **Description:** A success response
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which is an empty object.

**failure:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
