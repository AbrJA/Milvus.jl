# Search

**POST** `/v2/vectordb/entities/search`

This operation conducts a vector similarity search with an optional scalar filtering expression.

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
  - `data` (array) **(required)**: A list of vector embeddings.
MilvusZilliz Cloud searches for the most similar vector embeddings to the specified ones.
  - `annsField` (string) **(required)**: The name of the vector field.
  - `filter` (string): The filter used to find matches for the search.
  - `limit` (integer): The total number of entities to return.
You can use this parameter in combination with **offset** in **param** to enable pagination.
The sum of this value and **offset** in **param** should be less than 16,384. 
  - `offset` (integer): The number of records to skip in the search result. 
You can use this parameter in combination with limit to enable pagination. 
The sum of this value and limit should be less than 16,384. 
  - `groupingField` (string): The name of the field that serves as the aggregation criteria.
  - `outputFields` (array): An array of fields to return along with the search results.
  - `searchParams` (object): The parameter settings specific to this operation.
    - `metricType` (string): The name of the metric type that applies to the current search. The value should be the same as the metric type of the target collection.
    - `params` (object): Extra search parameters.
  - `partitionNames` (array): The name of the partitions to which this operation applies. Setting this parameter indicates that the search is within the specified partitions. Otherwise, the search is across all partitions in the collection.
  - `consistencyLevel` (string): The consistency level of the search operation. The value should be the same as the consistency level of the target collection.

### Responses

**200:** Returns the search results.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): A list of entity objects.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
