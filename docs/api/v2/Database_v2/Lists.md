# List Databases

**POST** `/v2/vectordb/databases/list`

This operation lists all databases in the current Milvus instancecluster.

**Tags:** Database Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**

### Responses

**200:** Returns a list of database names.

- **Type:** `object`
