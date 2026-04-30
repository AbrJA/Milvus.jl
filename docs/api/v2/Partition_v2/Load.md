# Load Partitions

**POST** `/v2/vectordb/partitions/load`

This operation loads the data of the current partition into memory.

**Tags:** Partition Operations (V2)

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
  - `partitionNames` (array) **(required)**: The list of names of the target partitions.

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
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
