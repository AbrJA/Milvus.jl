# Hybrid Search

**POST** `/v2/vectordb/entities/hybrid_search`

This operation searches for entities based on vector similarity and scalar filtering and reranks the results using a specified strategy.

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
  - `partitionNames` (array): The name of the partitions to which this operation applies. Setting this parameter indicates that the search is within the specified partitions. Otherwise, the search is across all partitions in the collection.
  - `search` (array) **(required)**: The search parameters
  - `rerank` (object): The reranking strategy.
    - `strategy` (string): The name of the reranking strategy.
    - `params` (object): A set of parameters related to the specified strategy
  - `limit` (integer): The total number of entities to return.
You can use this parameter in combination with **offset** in **param** to enable pagination.
The sum of this value and **offset** in **param** should be less than 16,384. 
  - `outputFields` (array): An array of fields to return along with the search results.
  - `consistencyLevel` (string): The consistency level of the search operation. The value should be the same as the consistency level of the target collection.

### Responses

**200:** Returns the search results.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): Search results

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
