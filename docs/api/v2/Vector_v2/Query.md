# Query

**POST** `/v2/vectordb/entities/query`

This operation conducts a filtering on the scalar field with a specified boolean expression.

**Tags:** Vector Operations (V2)

### Parameters

- **`Authorization`** (header, `string`)
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database.
  - `collectionName` (string) **(required)**: The name of the collection to which this operation applies.
  - `filter` (string) **(required)**: The filter used to find matches for the search.
  - `outputFields` (array): An array of fields to return along with the query results.
  - `partitionNames` (array): The name of the partitions to which this operation applies. Setting this parameter restricts the operation to the specified partitions. If not set, the operation applies to all partitions in the collection.
  - `limit` (integer): The total number of entities to return.
You can use this parameter in combination with **offset** in **param** to enable pagination.
The sum of this value and **offset** in **param** should be less than 16,384. 
  - `offset` (integer): The number of records to skip in the search result. 
You can use this parameter in combination with limit to enable pagination. 
The sum of this value and limit should be less than 16,384. 

### Responses

**200:** A list of dictionaries with each dictionary representing a queried entity.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): A list of dictionaries with each dictionary representing a queried entity.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
