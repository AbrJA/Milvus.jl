# Insert

**POST** `/v2/vectordb/entities/insert`

This operation inserts data into a specific collection. 

**Tags:** Vector Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the target database.
  - `collectionName` (string) **(required)**: The name of an existing collection.
  - `data` (any) **(required)**: An entity object or an array of entity objects. Note that the keys in an entity object should match the collection schema
  - `partitionName` (string): The name of a partition in the current collection. 
If specified, the data is to be inserted into the specified partition.

### Responses

**200:** A dictionary contains information about the number of inserted entities.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which carries the results of this operation.
    - `insertCount` (integer): The number of inserted entities.
    - `insertIds` (array): An array of the IDs of inserted entities.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
