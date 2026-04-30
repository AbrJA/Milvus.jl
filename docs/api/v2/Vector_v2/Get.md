# Get

**POST** `/v2/vectordb/entities/get`

This operation gets specific entities by their IDs.

**Tags:** Vector Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database.
  - `collectionName` (string) **(required)**: The name of the collection to which this operation applies.
  - `id` (object) **(required)**: A specific entity ID or a list of entity IDs.
  - `outputFields` (array): An array of fields to return along with the query results.
  - `partitionNames` (array): The name of the partitions to which this operation applies.

### Responses

**200:** Returns the query results.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): Query results.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
