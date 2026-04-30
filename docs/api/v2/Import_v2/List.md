# List Import Jobs

**POST** `/v2/vectordb/jobs/import/list`

This operation lists all import jobs of a specific cluster.

**Tags:** Import Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges.

- **`Accept`** (header, `string`)
  - Use `application/json`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `clusterId` (string) **(required)**: ID of a specific cluster on Zilliz Cloud.
  - `pageSize` (integer): Number of records to return at each request.
  - `currentPage` (integer): Current page number.
  - `dbName` (string): Name of the database to which the import job belongs.

### Responses

**200:** Returns a list of import jobs

**Option 1:**

- **Type:** `object`
- **Properties:**
  - `code` (string): Response code.
  - `data` (object): Response payload, which is a list of import jobs in detail.
    - `count` (integer): Total number of records listed in this response.
    - `currentPage` (integer): Current page number for your reference.
    - `pageSize` (integer): Maximum number of records to be included in each return.
    - `records` (array): List of import jobs in detail.

**Option 2:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
