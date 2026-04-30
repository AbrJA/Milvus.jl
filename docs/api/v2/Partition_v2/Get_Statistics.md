# Get Partition Statistics

**POST** `/v2/vectordb/partitions/get_stats`

This operations gets the number of entities in a partition.

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
  - `partitionName` (string) **(required)**: The name of the target partition of this operation. 

### Responses

**200:** Returns the number of entities in the specified collection.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Statistics of the specified partition.
    - `rowCount` (integer): The number of entities.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
