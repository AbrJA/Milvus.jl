# Get Collection Load State

**POST** `/v2/vectordb/collections/get_load_state`

This operation returns the load status of a specific collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of a database to which the collection belongs.
  - `collectionName` (string) **(required)**: The name of a collection.
  - `partitionNames` (string): A list of partition names. If any partition names are specified, releasing any of these partitions results in the return of a NotLoad state.

### Responses

**200:** A LoadState object that indicates the load status of the specified collection.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): A LoadState object that indicates the load status and load progress of the specified collection.
    - `loadState` (string): An object that indicates the load status of the specified collection.
    - `loadProgress` (integer): An integer that indicates the load progress in the percentage of the specified collection.
    - `message` (string): Returned message.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
