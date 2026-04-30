# List Partitions

**POST** `/v2/vectordb/partitions/list`

This operation lists all partitions in the database used in the current connection.

**Tags:** Partition Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the target database.
  - `collectionName` (string) **(required)**: The name of the target collection to which the partition belongs.

### Responses

**200:** A list of partition names.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): A list of partition names

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
