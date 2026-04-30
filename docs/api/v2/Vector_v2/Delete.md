# Delete

**POST** `/v2/vectordb/entities/delete`

This operation deletes entities by their IDs or with a boolean expression.

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
  - `filter` (string) **(required)**: A scalar filtering condition to filter matching entities. You can set this parameter to an empty string to skip scalar filtering. To build a scalar filtering condition, refer to [Boolean Expression Rules](https://milvus.io/docs/boolean.md)[Reference on Scalar Filters](/docs/get-and-scalar-query#reference-on-scalar-filters). 
  - `partitionName` (string): The name of a partition in the current collection. 
If specified, the data is to be deleted from the specified partition.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
