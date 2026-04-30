# Has Partition

**POST** `/v2/vectordb/partitions/has`

This operation checks whether a partition exists.

**Tags:** Partition Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of an existing database.
  - `collectionName` (string) **(required)**: The name of an existing collection.
  - `partitionName` (string) **(required)**: The name of the partition to test.

### Responses

**200:** A boolean value indicating whether the specified partition exists.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which carries a boolean value.
    - `has` (boolean): A boolean value indicates whether the specified partition exists.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
