# Compact Collection

**POST** `/v2/vectordb/collections/compact`

This operation compacts the collection by merging small segments into larger ones. It is recommended to call this operation after inserting a large amount of data into a collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `collectionName` (string) **(required)**: The name of the target collection.
Setting this to a non-existing collection results in an error.

### Responses

**200:** Return an empty response.

- **Type:** `object`
