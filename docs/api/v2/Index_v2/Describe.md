# Describe Index

**POST** `/v2/vectordb/indexes/describe`

This operation describes the current index.

**Tags:** Index Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database to which the collection belongs.
  - `collectionName` (string) **(required)**: The name of the collection to which the index belongs.
  - `indexName` (string) **(required)**: The name of the index to describe.

### Responses

**200:** An object that contains the detailed description of the current index.

- **Type:** `object`
